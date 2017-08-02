'use strict'

var mongoose = require('mongoose')

var question = mongoose.model('ChooseQuestion')

var ChooseQuesion = require('../models/ChooseQuestion')

exports.list_all_questions = function(req, res) {
  question.find({}, function(err, task) {
    if (err)
      res.send(err);
    res.json(task);
  })
}


exports.read_a_question = function(req,res){
    console.log("Find question "+req.params.id)
    question.findOne({id: req.params.id},function(err,result){
        if (err){
            res.send(err)
        }
        console.log(result)
        res.json(result)
    })
}

exports.update_a_question = function(req,res){
    question.findOneAndUpdate({id:req.params.id},req.body,{new: true},function(err,result){
        if(err) res.send(err)
        res.json(result)
    })
}

exports.delete_a_question = function(req,res,next){
    question.remove({id: req.params.id},function(err,result){
        if (err) next(err)
        res.send("OK")
    })
}

exports.create_a_question = function(req,res){
    console.log(req.body)
    var new_question = new ChooseQuesion(req.body)
    new_question.save(function(err,result){
        if (err)
            res.send(err)
        res.json(result)
    })
}