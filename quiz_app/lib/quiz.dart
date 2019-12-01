import 'package:flutter/material.dart';
import 'package:quiz_app/answer.dart';
import 'package:quiz_app/question.dart';

class Quiz extends StatelessWidget {
  final int questionIndex;
  final List<Map<String, Object>> questions;
  final Function answerQuestion;
  Quiz(@required this.questions, @required this.answerQuestion,
      @required this.questionIndex);
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Question(questions[questionIndex]['questionText']),
      ...(questions[questionIndex]['answers'] as List<Map<String,Object>>).map((answer) {
        return Answer(()=>answerQuestion(answer['score']), answer['text']);
      }).toList(),
    ]);
  }
}
