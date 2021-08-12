import 'package:flutter/material.dart';

import './answer.dart';
import './question.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final VoidCallback answerQuestion;
  final int questionIndex;

  Quiz({
    required this.answerQuestion,
    required this.questions,
    required this.questionIndex
  });

  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(questions[questionIndex]['questionText'] as String),
        // Renders list of Widgets
        ...(questions[questionIndex]['answers'] as List<String>)
            .map((answer) => Answer(answerQuestion, answer))
            .toList(),
      ],
    );
  }
}
