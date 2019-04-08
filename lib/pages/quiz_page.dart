import 'package:flutter/material.dart';
import '../utils/questions.dart';
import '../utils/quiz.dart';
import '../UI/answer_button.dart';
import '../UI/question_text.dart';
import '../UI/correct_wrong_overlay.dart';
import './quiz_page.dart';
import './score_page.dart';


class QuizPage extends StatefulWidget{


  @override
  State createState() => new QuizPageState();

}

class QuizPageState extends State<QuizPage>{

  Question currentQuestion;
  Quiz quiz = new Quiz([
    Question("Redskins are the best", true),
    Question("Rootbeer is amazing", true),
    Question("Elijah is Ugly", false)
  ]);

  String questionText;
  int questionNumber;
  bool isCorrect;
  bool overlayShouldBeVisible = false;


  @override
  void initState(){
    super.initState();
    currentQuestion= quiz.nextQuestion;
    questionText = currentQuestion.question;
    questionNumber = quiz.questionNumber;
  }

  void handleAnswer(bool answer){
    isCorrect =(currentQuestion.answer == answer);
    quiz.answer(isCorrect);
    this.setState((){
      overlayShouldBeVisible = true;

    });
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Column(
          children: <Widget>[
            new AnswerButton(true, () => handleAnswer(true)),
            QuestionText(questionText, questionNumber),
            new AnswerButton(false, ()=> handleAnswer(false)),
          ],
        ),
        overlayShouldBeVisible == true ? CorrectWrongOverlay(
          isCorrect,
          () {
            if(quiz.length == questionNumber){
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => ScorePage(quiz.score, quiz.length)), (Route route) => route == null );
              return;
            }
            currentQuestion= quiz.nextQuestion;
            this.setState((){
              overlayShouldBeVisible = false;
              questionText = currentQuestion.question;
              questionNumber = quiz.questionNumber;
            });
          }) : Container()
      ],
    ) ;
  }
}