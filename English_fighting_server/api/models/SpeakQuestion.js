'use strict'
var mongoose = require('mongoose');
var Schema = mongoose.Schema

var SpeakQuestion = new Schema({
    question: String,
    content: String,
    id: Number
})

module.exports = mongoose.model('SpeakQuestion',SpeakQuestion)