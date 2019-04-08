import 'package:flutter/material.dart';
import 'pages/landing_page.dart';
import 'pages/quiz_page.dart';
import "./pages/score_page.dart";
void main() {
  runApp(new MaterialApp(
    // home: new ScorePage(5, 10),
    home: new LandingPage(),
    // home: QuizPage(),
    
  ),
);

}