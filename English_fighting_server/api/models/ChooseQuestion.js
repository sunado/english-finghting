'use strict'
var mongoose = require('mongoose');
var Schema = mongoose.Schema

var ChooseQuestionSchema = new Schema({
    id:{type: Number},
    question: { type : String},
    a: {type: String},
    b: {type: String},
    c: {type: String},
    d: {type: String}
})

module.exports = mongoose.model('ChooseQuestion',ChooseQuestionSchema)
