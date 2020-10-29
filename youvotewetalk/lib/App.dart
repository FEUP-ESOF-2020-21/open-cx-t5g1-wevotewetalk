import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'StartPage.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'We Vote You Talk',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: StartPage(),
    );
  }
}
