import 'package:flutter/material.dart';

import './custom-text.dart';
import './text-control.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _App();
  }
}

class _App extends State<App> {
  var _appBarTitle = 'Assignment 01';
  var _bodyText = 'I am the best!!';

  void _changeBodyText() {
    setState(() {
      _bodyText = 'Jk, bb is!!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(_appBarTitle),
        ),
        body: Center(
          child: Column(
            children: [
              CustomText(_bodyText),
              TextControl(_changeBodyText),
            ],
          ),
        ),
      ),
    );
  }
}
