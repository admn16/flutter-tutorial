import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // `@override` is optional but helps make the code look clearer. It means that we're overriding the build method on the `StatelessWidget` class.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My First App'),
        ),
        body: Text('Hello, world!'),
      ),
    );
  }
}
