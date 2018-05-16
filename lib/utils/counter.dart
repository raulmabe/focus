import 'package:flutter/material.dart';

class Counter extends AnimatedWidget{

  Animation<int> animation;

  Counter({Key key, this.animation }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
      return new Center(
        child: new Text(animation.value.toString(), style: new TextStyle(
          color: Colors.white, 
          fontWeight: FontWeight.w200, 
          fontSize: 100.0,
          fontFamily: 'Poppins',
          )
        ),
      );
  }
}