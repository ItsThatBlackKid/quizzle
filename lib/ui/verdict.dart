import 'package:flutter/material.dart';
import 'dart:math' as math;

class VerdictOverlay extends StatefulWidget {
  final bool _isCorrect;
  final VoidCallback _onTap;

  VerdictOverlay(this._isCorrect, this._onTap);

  @override
  State<StatefulWidget> createState() => new VerdictOverlayState();
}

class VerdictOverlayState extends State<VerdictOverlay>
    with SingleTickerProviderStateMixin {
  Animation<double> _iconAnimation;
  AnimationController _iconAnimationController;

  @override
  void initState() {
    super.initState();

    _iconAnimationController = new AnimationController(vsync: this,
        duration: new Duration(seconds: 4));
    _iconAnimation = new CurvedAnimation(parent: _iconAnimationController,
        curve: Curves.elasticOut);
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Material(
        color: Colors.black54,
        child: new InkWell(
            onTap: ()  {
              _iconAnimationController.stop();
              widget._onTap();
            },
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                    decoration: new BoxDecoration(color: Colors.white,
                        shape: BoxShape.circle),
                    child: new Transform.rotate(
                      angle: _iconAnimation.value * 2 * math.pi,
                      child: new Icon(
                          widget._isCorrect == true ? Icons.done : Icons.clear,
                          size: _iconAnimation.value * 80),)
                ),
                new Padding(padding: new EdgeInsets.only(bottom: 20)),
                new Text(widget._isCorrect == true ? "Correct!" : "Incorrect!",
                    style: new TextStyle(color: Colors.white, fontSize: 30)),
              ],
            )
        )
    );
  }
}