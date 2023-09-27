"use strict";
const getContentType = (ext) => {
    switch (ext) {
        case '.css':
            return 'text/css';
        case '.png':
            return 'image/png';
        case '.js':
            return 'application/javascript';
        default:
            return 'text/plain';
    }
};
module.exports = getContentType;
