'use strict'
var mongoose = require('mongoose');
var Schema = mongoose.Schema

var ListenQuestionSchema = new Schema({
    question: String,
    a: String,
    b: String,
    c: String,
    d: String,
    audio: String,
    id: Number
})

module.exports = mongoose.model('ListenQuestion',ListenQuestionSchema)