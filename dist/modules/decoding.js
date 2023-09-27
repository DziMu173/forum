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
const jsonwebtoken_1 = __importDefault(require("jsonwebtoken"));
const dotenv = __importStar(require("dotenv"));
dotenv.config();
const DecodingUsername = (request) => {
    const allCookie = request.headers.cookie;
    const secret = process.env.SECRET;
    let token;
    if (allCookie !== null && allCookie !== undefined) {
        const cookies = allCookie.split(';');
        for (const c of cookies) {
            const [name, value] = c.split('=');
            if (name.trim() === 'token') {
                token = value;
                break;
            }
        }
    }
    let decoded;
    if (token !== undefined && secret !== undefined) {
        decoded = jsonwebtoken_1.default.verify(token, secret);
    }
    return decoded === null || decoded === void 0 ? void 0 : decoded.username;
};
module.exports = DecodingUsername;
