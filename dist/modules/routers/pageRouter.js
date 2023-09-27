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
const pageController = __importStar(require("../controllers/pageController"));
const pageRouter = (request, response, pathName, username) => {
    switch (pathName) {
        case '': {
            pageController.home(request, response, username);
            break;
        }
        case 'vhod': {
            pageController.vhod(request, response, username);
            break;
        }
        case 'reg': {
            pageController.reg(request, response, username);
            break;
        }
        case 'thread': {
            pageController.thread(request, response, username);
            break;
        }
        case 'user': {
            pageController.user(request, response, username);
            break;
        }
        case 'theme': {
            pageController.theme(request, response, username);
            break;
        }
    }
};
module.exports = pageRouter;
