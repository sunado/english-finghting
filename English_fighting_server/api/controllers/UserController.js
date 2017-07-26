'use strict'

var mongoose = require('mongoose')
var users = mongoose.model('User')
var User = require('../models/User')

exports.list_all_user = function(req,res){
    users.find({}, function(err, task) {
    if (err)
      res.send(err);
    res.json(task);
  })
}
exports.get_a_user = function(req,res){
    users.findOne({facebookId: req.params.id},function(err,result){
        if (err){
            res.send(err)
        }
        console.log(result)
        res.json(result)
    })
}
exports.update_user_info = function(req,res){
    users.findOneAndUpdate({facebookId:req.params.id},req.body,{new: true},function(err,result){
        if(err) res.send(err)
        res.json(result)
    })
}

exports.delete_a_user = function(req,res,next){
    users.remove({facebookId: req.params.id},function(err,result){
        if (err) next(err)
        res.send("OK")
    })
}
exports.create_a_user = function(req,res){
    console.log(req.body)
    var new_user= new User(req.body)
    new_user.save(function(err,result){
        if (err)
            res.send(err)
        res.json(result)
    })
}