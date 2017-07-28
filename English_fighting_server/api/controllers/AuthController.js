'use strict'

var http = require('http')
var https = require('https')

var host = "graph.facebook.com"
var port = 443
var method = "GET" 
var users = require('mongoose').model('User')
exports.auth = function(req,res){
    console.log(req.params.token)
    var path = "/me?access_token="+req.params.token
    var options = {
        host: host,
        port: port,
        path: path,
        metod: method 
    }
    var request = https.request(options,function(result){
        console.log("Auth statuscode: ",res.statusCode)

        result.on('data',function(data){
            console.log("\n loaded data: \n")
            var json = JSON.parse(data)
            var id  = json.id 
            console.log("id: "+id)
            users.findOne({facebookId: id},function(err,result){
                if (err){
                    res.send(err)
                }
                console.log(result)
                res.json(result)
            }) 
        })
    })
    request.end()
    request.on('error',function(err){
        console.error("Auth request: ",e)
    })
    
}

exports.getData = function(req,res) {
    console.log(req.params.token)
    var path = "/me?fields=id,email,name,age_range,gender,locale,link,picture,timezone,updated_time,verified&access_token="+req.params.token
    var options = {
        host: host,
        port: port,
        path: path,
        metod: method 
    }
    var request = https.request(options,function(result){
        console.log("Auth statuscode: ",res.statusCode)

        result.on('data',function(data){
            console.log("\n loaded data: \n")
            process.stdout.write(data)
            var json = JSON.parse(data)
            res.send(json)
        })
    })
    request.end()
    request.on('error',function(err){
        console.error("Auth request: ",e)
    })
}