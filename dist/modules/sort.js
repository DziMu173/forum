"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const sorter = (sort) => {
    if (typeof sort === 'undefined') {
        return 'ORDER BY id';
    }
    ;
    switch (sort) {
        case 'id': {
            return 'ORDER BY id';
        }
        case 'asc': {
            return 'ORDER BY title ASC';
        }
        case 'desc': {
            return 'ORDER BY title DESC';
        }
        default: {
            return 'ORDER BY id';
        }
    }
};
exports.default = sorter;
