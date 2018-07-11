import 'package:flutter/material.dart';
import './tiles/themeTile.dart';

class Settings extends StatelessWidget {

  TextStyle title, subtitle;
  Color lightColor, darkColor;

  VoidCallback callbackUpdate;

  Settings(VoidCallback callbackUpdate){
    this.callbackUpdate = callbackUpdate;
    
    title = new TextStyle(
      color: Colors.blueGrey,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600
    );
    subtitle = new TextStyle(
      color: Colors.blueGrey,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w400
    );
    darkColor = Colors.blueGrey;
    lightColor = new Color.fromRGBO(93, 242, 214,1.0);
  }

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new Container(
        height: double.infinity,
        width: double.infinity,
       //margin: EdgeInsets.all(30.0),
        decoration: new BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: new ListView(
              children: <Widget>[
                new ThemeTile(title, subtitle, callbackUpdate),
                new Divider(color: darkColor,),
                new ListTile(title: new Text('About me', style: subtitle,),),
                new Divider(color: darkColor,),
              ],
            ),
          ),
        ),
      );
    }

}