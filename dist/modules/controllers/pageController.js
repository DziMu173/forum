"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.theme = exports.user = exports.thread = exports.reg = exports.vhod = exports.home = void 0;
const forDB_1 = __importDefault(require("../forDB"));
const render_1 = __importDefault(require("../render"));
const url_1 = __importDefault(require("url"));
const sort_1 = __importDefault(require("../sort"));
const home = (request, response, username) => {
    (0, forDB_1.default)('select * from themes order by theme_name ASC').then(themeList => {
        (0, render_1.default)(response, 'index.ejs', { themeList }, username);
    });
};
exports.home = home;
const vhod = (request, response, username) => {
    (0, render_1.default)(response, 'vhod.ejs', {}, username);
};
exports.vhod = vhod;
const reg = (request, response, username) => {
    (0, render_1.default)(response, 'reg.ejs', {}, username);
};
exports.reg = reg;
const thread = (request, response, username) => {
    const urlRequest = url_1.default.parse(request.url, true);
    const threadId = urlRequest.query.id;
    if (threadId != null && threadId !== '') {
        (0, forDB_1.default)(`SELECT * FROM messages_view where thread_id = ${threadId} ORDER BY id limit 10`)
            .then(messages => {
            (0, forDB_1.default)(`SELECT * FROM threads where id = ${threadId}`)
                .then(thread => {
                (0, render_1.default)(response, 'thread.ejs', { messages, thread }, username);
            });
        });
    }
};
exports.thread = thread;
const user = (request, response, username) => {
    (0, render_1.default)(response, 'user.ejs', {}, username);
};
exports.user = user;
const theme = (request, response, username) => {
    const urlRequest = url_1.default.parse(request.url, true);
    const themeId = urlRequest.query.id;
    const sort = urlRequest.query.sort;
    const sortType = (0, sort_1.default)(sort);
    if (themeId != null && themeId !== '' && sort != null && sort !== '') {
        (0, forDB_1.default)(`SELECT * FROM threads where theme_id='${themeId}' ${sortType} limit 20`)
            .then(threadList => {
            (0, forDB_1.default)(`SELECT * FROM themes where id='${themeId}'`).then(theme => {
                (0, render_1.default)(response, 'theme.ejs', { threadList, theme }, username);
            });
        });
    }
};
exports.theme = theme;
