"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.logout = exports.login = exports.registration = void 0;
const forDB_1 = __importDefault(require("../forDB"));
const getPostData_1 = __importDefault(require("../getPostData"));
const jsonwebtoken_1 = __importDefault(require("jsonwebtoken"));
const cookie_1 = __importDefault(require("cookie"));
const registration = function (request, response, username) {
    (0, getPostData_1.default)(request).then(body => {
        const { username, password } = JSON.parse(body);
        (0, forDB_1.default)(`SELECT EXISTS(SELECT id FROM users WHERE name = '${username}')`)
            .then(data => {
            if (data[0].exists === false) {
                (0, forDB_1.default)(`insert into users (name, password) values('${username}', '${password}')`).then(() => {
                    const secret = process.env.SECRET || 'secret';
                    const token = jsonwebtoken_1.default.sign({ username }, secret, { expiresIn: '1d' });
                    response.setHeader('Set-Cookie', cookie_1.default.serialize('token', token, {
                        httpOnly: true,
                        maxAge: 24 * 60 * 60,
                        sameSite: 'strict',
                        path: '/'
                    }));
                    response.writeHead(201, { 'Content-Type': 'application/json;charset=utf-8' });
                    response.end(JSON.stringify({ isAuthorized: true }));
                });
            }
            else {
                response.writeHead(400, { 'Content-Type': 'application/json;charset=utf-8' });
                response.end(JSON.stringify({ isAuthorized: false }));
            }
            ;
        });
    });
};
exports.registration = registration;
const login = (request, response, username) => {
    (0, getPostData_1.default)(request).then(body => {
        const { username, password } = JSON.parse(body);
        (0, forDB_1.default)(`SELECT EXISTS(SELECT id FROM users WHERE name = '${username}' AND password = '${password}')`)
            .then(data => {
            if (data[0].exists === true) {
                const secret = process.env.SECRET || 'secret';
                const token = jsonwebtoken_1.default.sign({ username }, secret, { expiresIn: '1d' });
                response.setHeader('Set-Cookie', cookie_1.default.serialize('token', token, {
                    httpOnly: true,
                    maxAge: 24 * 60 * 60,
                    sameSite: 'strict',
                    path: '/'
                }));
                response.writeHead(200, { 'Content-Type': 'application/json;charset=utf-8' });
                response.end(JSON.stringify({ isAuthorized: true }));
            }
            else {
                response.writeHead(200, { 'Content-Type': 'application/json;charset=utf-8' });
                response.end(JSON.stringify({ isAuthorized: false }));
            }
            ;
        });
    });
};
exports.login = login;
const logout = (request, response, username) => {
    (0, getPostData_1.default)(request).then(body => {
        const { deleteCookie } = JSON.parse(body);
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
};
exports.logout = logout;
