'use strict'
var mongoose = require('mongoose');
var Schema = mongoose.Schema

var ChooseQuestionSchema = new Schema({
    id: Number,
    question: String,
    a: String,
    b: String,
    c: String,
    d: String
})

module.exports = mongoose.model('ChooseQuestion',ChooseQuestionSchema)
