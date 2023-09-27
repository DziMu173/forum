"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (k !== "default" && Object.prototype.hasOwnProperty.call(mod, k)) __createBinding(result, mod, k);
    __setModuleDefault(result, mod);
    return result;
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
/* eslint-disable @typescript-eslint/no-non-null-assertion */
const http_1 = __importDefault(require("http"));
const url_1 = __importDefault(require("url"));
const pageRouter_1 = __importDefault(require("./modules/routers/pageRouter"));
const authRouter_1 = __importDefault(require("./modules/routers/authRouter"));
const threadRouter_1 = __importDefault(require("./modules/routers/threadRouter"));
const messageRouter_1 = __importDefault(require("./modules/routers/messageRouter"));
const decoding_1 = __importDefault(require("./modules/decoding"));
const userRouter_1 = __importDefault(require("./modules/routers/userRouter"));
const dotenv = __importStar(require("dotenv"));
dotenv.config();
const server = http_1.default.createServer((request, response) => {
    var _a;
    const urlRequest = url_1.default.parse(request.url, true);
    const pathName = (_a = urlRequest.pathname) === null || _a === void 0 ? void 0 : _a.split('/');
    const decodedUsername = (0, decoding_1.default)(request);
    if (pathName != null) {
        if (pathName[1] === 'api') {
            switch (pathName[2]) {
                case 'auth': {
                    (0, authRouter_1.default)(request, response, pathName[3], decodedUsername);
                    break;
                }
                case 'thread': {
                    (0, threadRouter_1.default)(request, response, pathName[3], decodedUsername);
                    break;
                }
                case 'message': {
                    (0, messageRouter_1.default)(request, response, pathName[3], decodedUsername);
                    break;
                }
                case 'user': {
                    (0, userRouter_1.default)(request, response, pathName[3], decodedUsername);
                    break;
                }
            }
        }
        else {
            (0, pageRouter_1.default)(request, response, pathName[1], decodedUsername);
        }
    }
});
server.listen(Number(process.env.SERVER_PORT), () => {
    console.log(`Server started on port ${Number(process.env.SERVER_PORT)}`);
});
