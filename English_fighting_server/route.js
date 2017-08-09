'use strict'

module.exports = function(app){
    require('./api/route/Auth')(app)
    require('./api/route/ChooseQuestion')(app)
    require('./api/route/User')(app)
    require('./api/route/ListenQuestion')(app)
    require('./api/route/GrammarQuesiton')(app)
    require('./api/route/SpeakQuestion')(app)
}

