"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.getAll = exports.create = void 0;
const url_1 = __importDefault(require("url"));
const forDB_1 = __importDefault(require("../forDB"));
const getPostData_1 = __importDefault(require("../getPostData"));
const render_1 = __importDefault(require("../render"));
const sort_1 = __importDefault(require("../sort"));
const create = (request, response, username) => {
    (0, getPostData_1.default)(request).then(body => {
        const { threadTitle, threadId } = JSON.parse(body);
        (0, forDB_1.default)(`select exists(select * from threads where title = '${threadTitle}')`).then(data => {
            if (data[0].exists !== true) {
                (0, forDB_1.default)(`INSERT INTO threads (title, theme_id) VALUES ('${threadTitle}', '${threadId}')`).then(() => {
                    response.writeHead(200, { 'Content-Type': 'application/json;charset=utf-8' });
                    response.end(JSON.stringify({ isCreatedThread: true }));
                });
            }
            else {
                response.writeHead(400, { 'Content-Type': 'application/json;charset=utf-8' });
                response.end(JSON.stringify({ isCreatedThread: false }));
            }
        });
    });
};
exports.create = create;
const getAll = (request, response, username) => {
    const urlRequest = url_1.default.parse(request.url, true);
    const offset = urlRequest.query.offset;
    const limit = urlRequest.query.limit;
    const themeId = urlRequest.query.id;
    const sort = urlRequest.query.sort;
    const sortType = (0, sort_1.default)(sort);
    (0, forDB_1.default)(`select * from threads where theme_id =${themeId} ${sortType} limit ${limit} offset ${offset}`)
        .then(threadList => {
        (0, render_1.default)(response, 'components/threadList.ejs', { threadList });
    });
};
exports.getAll = getAll;
