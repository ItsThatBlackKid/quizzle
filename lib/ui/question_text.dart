import 'package:flutter/material.dart';

class QuestionText extends StatefulWidget {
  final String _question;
  final int _questionNumber;

  QuestionText(this._question, this._questionNumber);

  @override
  State createState() => QuestionTextState();
}

class QuestionTextState extends State<QuestionText>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = new AnimationController(
        duration: new Duration(milliseconds: 1000), vsync: this);
    animation = new CurvedAnimation(parent: controller, curve: Curves.linear);
    animation.addListener(() => this.setState(() {}));
    controller.forward();
  }

  @override
  void didUpdateWidget(QuestionText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget._question != widget._question) {
      controller.reset();
      controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
        color: Colors.white,
        child: new Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: new Center(
              child: new Text(
                  "Statement " +
                      widget._questionNumber.toString() +
                      ": " +
                      widget._question,
                  style:
                      new TextStyle(fontSize: animation.value * 15))
          ),
        )
    );
  }
}
