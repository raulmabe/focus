import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double barHeight = 66.0;

  @override
  Size get preferredSize {
    return new Size.fromHeight(50.0);
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery
      .of(context)
      .padding
      .top;
    return new Container(
      padding: new EdgeInsets.only(top: statusBarHeight),
      height: statusBarHeight + barHeight,
      decoration: new BoxDecoration(
        color: const Color.fromRGBO(0, 0, 0, 0.0),
        ),
      child: new TabBar(
          labelColor: Colors.white,
          indicatorColor: Colors.white,
          unselectedLabelColor: Colors.white,
          tabs: <Widget>[
            new Tab(
              child: new Icon(Icons.watch_later), //Icons.access_time),
            ),
            new Tab(
              child: new Icon(Icons.music_note),
            )
          ],
        ),
    );
  }
}