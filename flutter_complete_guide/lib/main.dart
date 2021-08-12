import 'package:flutter/material.dart';

import './answer.dart';
import './question.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final questions = const [
    {
      'questionText': 'What\'s your favorite color?',
      'answers': [
        'Black',
        'Red',
        'Green',
        'White',
      ],
    },
    {
      'questionText': 'What\'s your favorite animal?',
      'answers': [
        'Rabbit',
        'Snake',
        'Elephant',
        'Lion',
      ],
    },
    {
      'questionText': 'Who\'s your favorite instructor?',
      'answers': [
        'Max',
        'Max',
        'Max',
        'Max',
      ],
    },
  ];

  var _questionIndex = 0;

  void _answerQuestion() {
    setState(() {
      _questionIndex = _questionIndex + 1;
    });
    if (_questionIndex < questions.length) {
      print('We have more questions for you!');
    } else {
      print('No more questions!');
    }
  }

  // `@override` is optional but helps make the code look clearer. It means that we're overriding the build method on the `StatelessWidget` class.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My First App'),
        ),
        body: _questionIndex < questions.length
            ? Column(
                children: [
                  Question(questions[_questionIndex]['questionText'] as String),
                  // Renders list of Widgets
                  ...(questions[_questionIndex]['answers'] as List<String>)
                      .map((answer) => Answer(_answerQuestion, answer))
                      .toList(),
                ],
              )
            : Center(
                child: Text('You did it!'),
              ),
      ),
    );
  }
}
