"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.newMsg = exports.getAll = void 0;
/* eslint-disable @typescript-eslint/restrict-template-expressions */
/* eslint-disable @typescript-eslint/no-non-null-assertion */
/* eslint-disable n/no-deprecated-api */
/* eslint-disable @typescript-eslint/no-floating-promises */
const url_1 = __importDefault(require("url"));
const forDB_1 = __importDefault(require("../forDB"));
const render_1 = __importDefault(require("../render"));
const getPostData_1 = __importDefault(require("../getPostData"));
const fs_1 = __importDefault(require("fs"));
function getAll(request, response, username) {
    const urlRequest = url_1.default.parse(request.url, true);
    const threadId = urlRequest.query.id;
    const offset = urlRequest.query.offset;
    const limit = urlRequest.query.limit;
    (0, forDB_1.default)(`SELECT * FROM messages_view where thread_id = ${threadId} ORDER BY id limit ${limit} offset ${offset}`)
        .then(messages => {
        (0, render_1.default)(response, 'components/messages.ejs', { messages });
    });
}
exports.getAll = getAll;
const newMsg = function (request, response, username) {
    (0, getPostData_1.default)(request).then(body => {
        const { threadId, message, file } = JSON.parse(body);
        let fileDir = null;
        if (file) {
            fileDir = `${new Date().getTime()}.png`;
            const fileParts = file.split(',');
            const fileBody = fileParts[1];
            const binaryData = Buffer.from(fileBody, 'base64');
            fs_1.default.writeFileSync(`src/uploads/${fileDir}`, binaryData);
        }
        ;
        (0, forDB_1.default)(`insert into messages(content, thread_id, name, image) values ('${message}', ${threadId}, '${username}', '${fileDir}')`).then(() => {
            response.writeHead(200);
            response.end();
        });
    });
};
exports.newMsg = newMsg;
