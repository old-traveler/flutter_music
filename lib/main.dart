import 'package:flutter/material.dart';

void main() => runApp(MusicApp());

class MusicApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
