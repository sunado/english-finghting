'use strict'
module.exports = function(app) {
    var questionController = require('../controllers/ListenQuestionController')

    //route question
    app.route('/question/listen/:id').get(questionController.read_a_question)
    .put(questionController.update_a_question)
    //.delete(questionController.delete_a_task)
    app.route('/question/listen/').put(questionController.create_a_question)
    .get(questionController.list_all_questions)
}