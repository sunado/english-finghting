'use strict'

var mongoose = require('mongoose');
var Schema = mongoose.Schema

var UserSchema = new Schema({
    facebookId: {type: String},
    charracter: {type:String},
    fullname: {type:String},
    birth_date: {type: Date},
    email: {type: String},
    phone: {type: String},
    level: {type: Number},
    rank: {type: Number},
    total_win_games: {type: Number},
    total_games: {type: Number},
    total_questions: {type:Number},
    total_right_questions: {type: Number}
})

module.exports = mongoose.model('User',UserSchema)