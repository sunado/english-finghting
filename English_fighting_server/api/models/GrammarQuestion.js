'use strict'
var mongoose = require('mongoose');
var Schema = mongoose.Schema

var GrammarQuestion = new Schema({
    baseSentence: String,
    wrongSentence: String,
    wrongPos: [Number],
    id: Number
})

module.exports = mongoose.model('GrammarQuestion',GrammarQuestion)