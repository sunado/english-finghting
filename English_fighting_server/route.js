'use strict'

module.exports = function(app){
    require('./api/route/Auth')(app)
    require('./api/route/ChooseQuestion')(app)
    require('./api/route/User')(app)

}

