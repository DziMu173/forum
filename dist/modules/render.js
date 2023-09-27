"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
const path_1 = __importDefault(require("path"));
const ejs_1 = __importDefault(require("ejs"));
function renderPage(response, page, SQLdata, username) {
    const modData = { SQLdata, username };
    const pagePath = path_1.default.join(__dirname, '../views/', page);
    ejs_1.default.renderFile(pagePath, modData, (err, data) => {
        if (err != null) {
            response.writeHead(404);
            response.write('File not found!\n');
            response.end('Error 404');
            response.end();
        }
        else {
            response.writeHead(200, { 'Content-Type': 'text/html' });
            response.write(data);
            response.end();
        }
    });
}
module.exports = renderPage;
