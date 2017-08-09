'use strict'
module.exports = function(app) {
    var questionController = require('../controllers/SpeakQuestionController')

    //route question
    app.route('/question/speak/:id').get(questionController.read_a_question)
    .put(questionController.update_a_question)
    //.delete(questionController.delete_a_task)
    app.route('/question/speak/').put(questionController.create_a_question)
    .get(questionController.list_all_questions)
}