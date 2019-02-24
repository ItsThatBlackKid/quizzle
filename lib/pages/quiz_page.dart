import 'dart:async';

import 'package:flutter/material.dart';

import '../utils/questions.dart';
import '../utils/quiz.dart';
import "../ui/verdict.dart";
import '../ui/answer_btn.dart';
import '../ui/question_text.dart';
import 'score_page.dart';

class QuizPage extends StatefulWidget {

  @override
  State createState() => new QuizPageState();

}

class QuizPageState extends State<QuizPage> {
  Timer timer;
  double timeLeft = 15;

  Question currentQuestion;
  Quiz quiz = new Quiz([
    new Question("Jake is the best developer", true),
    new Question("Flutter is awesome", true),
    new Question("Masturbation is bad", false)
  ]);

  String questionText;
  int questionNum;
  bool isCorrect;
  bool showOverlay = false;

  @override
  void initState() {
    super.initState();
    currentQuestion = quiz.nextQuestion;
    questionText = currentQuestion.question;
    questionNum = quiz.questionNumber;
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      print("tick");
      if (timeLeft != 0) {
        timeLeft--;
        return;
      }
      t.cancel();
    });
  }

  Future<Null> _moveProgressBar() async {

  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Column(
            children: <Widget>[
              new AnswerButton(true, () => handleAnswer(true)),
              new QuestionText(questionText, questionNum),
              new LinearProgressIndicator(
                backgroundColor: Colors.white,
                value: timeLeft,
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.blueAccent),
              ),
              new AnswerButton(false, () => handleAnswer(false)),
            ]
        ),
        showOverlay == true ? new VerdictOverlay(isCorrect, () {
          if (quiz.length == questionNum) {
            Navigator.of(context).push(
                new MaterialPageRoute(builder: (BuildContext context) =>
                new ScorePage(
                    quiz.score, quiz.length)));
            return;
          }
          currentQuestion = quiz.nextQuestion;
          this.setState(() {
            showOverlay = false;
            questionText = currentQuestion.question;
            questionNum = quiz.questionNumber;
          });
        }) : new Container(),
      ],
    );
  }

  void handleAnswer(bool answer) {
    isCorrect = (currentQuestion.answer == answer);
    quiz.answer(isCorrect);
    this.setState(() {
      showOverlay = true;
    });
  }


}