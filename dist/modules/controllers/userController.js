"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.deleteUser = exports.updatePassword = void 0;
const forDB_1 = __importDefault(require("../forDB"));
const getPostData_1 = __importDefault(require("../getPostData"));
const cookie_1 = __importDefault(require("cookie"));
const updatePassword = (request, response, username) => {
    (0, getPostData_1.default)(request).then(body => {
        const { oldPassword, newPassword } = JSON.parse(body);
        (0, forDB_1.default)(`select exists(select * from users where password = '${oldPassword}' and name = '${username}')`).then(data => {
            if (data[0].exists === true) {
                (0, forDB_1.default)(`update users set password = '${newPassword}' where name = '${username}'`).then(() => {
                    response.writeHead(200, { 'Content-Type': 'application/json;charset=utf-8' });
                    response.end(JSON.stringify({ isUpdate: true }));
                });
            }
            else {
                response.writeHead(400, { 'Content-Type': 'application/json;charset=utf-8' });
                response.end(JSON.stringify({ isUpdate: false }));
            }
        });
    });
};
exports.updatePassword = updatePassword;
const deleteUser = (request, response, username) => {
    (0, getPostData_1.default)(request).then(body => {
        const { deleteCookie } = JSON.parse(body);
        (0, forDB_1.default)(`delete from users where name = '${username}'`).then(() => {
            if (deleteCookie === true) {
                response.setHeader('Set-Cookie', cookie_1.default.serialize('token', '', {
                    httpOnly: true,
                    maxAge: -1,
                    sameSite: 'strict',
                    path: '/'
                }));
                response.writeHead(200, { 'Content-Type': 'application/json;charset=utf-8' });
                response.end();
            }
        });
    });
};
exports.deleteUser = deleteUser;
