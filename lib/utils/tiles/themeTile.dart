import 'dart:math';

import 'package:flutter/material.dart';
import '../../themes/mainTheme.dart';
import '../../themes/darkTheme.dart';
import '../../themes/greenTheme.dart';
import '../../themes/pinkTheme.dart';

class ThemeTile extends StatefulWidget {
  
  TextStyle title, subtitle;

  VoidCallback callback;

  ThemeTile(this.title, this.subtitle, this.callback);

  @override
  _themeTileState createState() => new _themeTileState(title, subtitle, callback);

}

class _themeTileState extends State<ThemeTile>{

  TextStyle title, subtitle;

  final GlobalKey<AppExpansionTileState> expansionTile = new GlobalKey();

  _themeTileState(this.title, this.subtitle, this.callback);

  VoidCallback callback;

  var pinkTheme, greenTheme;

  @override
  void initState(){
    super.initState();
    pinkTheme = new PinkTheme();
    greenTheme = new GreenTheme();
  }

  @override
    Widget build(BuildContext context) {
      return new AppExpansionTile(
        key: expansionTile,
        leading: new ClipOval(
          clipper: new CircleClipper(),
          child: new Container(
            height: 35.0,
            width: 35.0,
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                    gradientColor1,
                    gradientColor2,
                  ],
                  stops: [0.0, 1.0],
                )
            ),
          ),
        ),
        title: new Text('Theme', style: title,),
        children: <Widget>[
          new Padding(padding: EdgeInsets.only(top: 10.0),),
          new Row(
            children: <Widget>[
              new Expanded(
                child: new GestureDetector(
                  onTap: () {
                    changeTheme(0);
                    expansionTile.currentState.collapse();
                    callback();
                  },
                  child: new ClipOval(
                    clipper: new CircleClipper(),
                    child: new Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: new BoxDecoration(
                        gradient: new LinearGradient(
                            begin: FractionalOffset.topCenter,
                            end: FractionalOffset.bottomCenter,
                            colors: [
                              greenTheme.gradientColor1,
                              greenTheme.gradientColor2,
                            ],
                            stops: [0.0, 1.0],
                          )
                      ),
                    ),
                  ),
                ),
              ),
              new Expanded(
                child: new GestureDetector(
                  onTap: () {
                    changeTheme(1);
                    expansionTile.currentState.collapse();
                    callback();
                  },
                  child: new ClipOval(
                    clipper: new CircleClipper(),
                    child: new Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: new BoxDecoration(
                        gradient: new LinearGradient(
                            begin: FractionalOffset.topCenter,
                            end: FractionalOffset.bottomCenter,
                            colors: [
                              pinkTheme.gradientColor1,
                              pinkTheme.gradientColor2,
                            ],
                            stops: [0.0, 1.0],
                          )
                      ),
                    ),
                  ),
                ),
              ),
              /*
              new Expanded(
                child: new GestureDetector(
                  onTap: () {
                    changeTheme(2);
                    expansionTile.currentState.collapse();
                    callback();
                  },
                  child: new ClipOval(
                    clipper: new CircleClipper(),
                    child: new Container(
                      width: 40.0,
                      height: 40.0,
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
              ),*/
            ],
          ),
          new Padding(padding: EdgeInsets.only(bottom: 10.0),),
        ],
      );
    }

    void changeTheme(int i){
      switch (i) {
        case 2:
          /*
          gradientColor1 = darkTheme.gradientColor1;
          gradientColor2 = darkTheme.gradientColor2;
          mainButtonColor = darkTheme.mainButtonColor;
          detailsColor = darkTheme.detailsColor;
          accentColor = darkTheme.accentColor;
          */
          break;
        case 1:
          gradientColor1 = pinkTheme.gradientColor1;
          gradientColor2 = pinkTheme.gradientColor2;
          mainButtonColor = pinkTheme.mainButtonColor;
          detailsColor = pinkTheme.detailsColor;
          accentColor = pinkTheme.accentColor;
          break;
        case 0:
        default:
          gradientColor1 = greenTheme.gradientColor1;
          gradientColor2 = greenTheme.gradientColor2;
          mainButtonColor = greenTheme.mainButtonColor;
          detailsColor = greenTheme.detailsColor;
          accentColor = greenTheme.accentColor;
      }
      setState(() {});
    }
}

class CircleClipper extends CustomClipper<Rect> {

  @override
    Rect getClip(Size size) {
      return new Rect.fromCircle(
        center: new Offset(size.width/2, size.height/2),
        radius: min(size.width, size.height) /2,
      );
    }

  @override
    bool shouldReclip(CustomClipper<Rect> oldClipper) {
      // TODO: implement shouldReclip
      return true;
    }
}



const Duration _kExpand = const Duration(milliseconds: 200);

class AppExpansionTile extends StatefulWidget {
    const AppExpansionTile({
        Key key,
        this.leading,
        this.title,
        this.backgroundColor,
        this.onExpansionChanged,
        this.children: const <Widget>[],
        this.trailing,
        this.initiallyExpanded: false,
    })
        : assert(initiallyExpanded != null),
            super(key: key);

    final Widget leading;
    final Widget title;
    final ValueChanged<bool> onExpansionChanged;
    final List<Widget> children;
    final Color backgroundColor;
    final Widget trailing;
    final bool initiallyExpanded;

    @override
    AppExpansionTileState createState() => new AppExpansionTileState();
}

class AppExpansionTileState extends State<AppExpansionTile> with SingleTickerProviderStateMixin {
    AnimationController _controller;
    CurvedAnimation _easeOutAnimation;
    CurvedAnimation _easeInAnimation;
    ColorTween _borderColor;
    ColorTween _headerColor;
    ColorTween _iconColor;
    ColorTween _backgroundColor;
    Animation<double> _iconTurns;

    bool _isExpanded = false;

    @override
    void initState() {
        super.initState();
        _controller = new AnimationController(duration: _kExpand, vsync: this);
        _easeOutAnimation = new CurvedAnimation(parent: _controller, curve: Curves.easeOut);
        _easeInAnimation = new CurvedAnimation(parent: _controller, curve: Curves.easeIn);
        _borderColor = new ColorTween();
        _headerColor = new ColorTween();
        _iconColor = new ColorTween();
        _iconTurns = new Tween<double>(begin: 0.0, end: 0.5).animate(_easeInAnimation);
        _backgroundColor = new ColorTween();

        _isExpanded = PageStorage.of(context)?.readState(context) ?? widget.initiallyExpanded;
        if (_isExpanded)
            _controller.value = 1.0;
    }

    @override
    void dispose() {
        _controller.dispose();
        super.dispose();
    }

    void expand() {
        _setExpanded(true);
    }

    void collapse() {
        _setExpanded(false);
    }

    void toggle() {
        _setExpanded(!_isExpanded);
    }

    void _setExpanded(bool isExpanded) {
        if (_isExpanded != isExpanded) {
            setState(() {
                _isExpanded = isExpanded;
                if (_isExpanded)
                    _controller.forward();
                else
                    _controller.reverse().then<void>((Null value) {
                        setState(() {
                            // Rebuild without widget.children.
                        });
                    });
                PageStorage.of(context)?.writeState(context, _isExpanded);
            });
            if (widget.onExpansionChanged != null) {
                widget.onExpansionChanged(_isExpanded);
            }
        }
    }

    Widget _buildChildren(BuildContext context, Widget child) {
        final Color borderSideColor = _borderColor.evaluate(_easeOutAnimation) ?? Colors.transparent;
        final Color titleColor = _headerColor.evaluate(_easeInAnimation);

        return new Container(
            decoration: new BoxDecoration(
                color: _backgroundColor.evaluate(_easeOutAnimation) ?? Colors.transparent,
                border: new Border(
                    top: new BorderSide(color: borderSideColor),
                    bottom: new BorderSide(color: borderSideColor),
                )
            ),
            child: new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                    IconTheme.merge(
                        data: new IconThemeData(color: _iconColor.evaluate(_easeInAnimation)),
                        child: new ListTile(
                            onTap: toggle,
                            leading: widget.leading,
                            title: new DefaultTextStyle(
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .subhead
                                    .copyWith(color: titleColor),
                                child: widget.title,
                            ),
                            trailing: widget.trailing ?? new RotationTransition(
                                turns: _iconTurns,
                                child: const Icon(Icons.expand_more),
                            ),
                        ),
                    ),
                    new ClipRect(
                        child: new Align(
                            heightFactor: _easeInAnimation.value,
                            child: child,
                        ),
                    ),
                ],
            ),
        );
    }

    @override
    Widget build(BuildContext context) {
        final ThemeData theme = Theme.of(context);
        _borderColor.end = theme.dividerColor;
        _headerColor
            ..begin = theme.textTheme.subhead.color
            ..end = theme.accentColor;
        _iconColor
            ..begin = theme.unselectedWidgetColor
            ..end = theme.accentColor;
        _backgroundColor.end = widget.backgroundColor;

        final bool closed = !_isExpanded && _controller.isDismissed;
        return new AnimatedBuilder(
            animation: _controller.view,
            builder: _buildChildren,
            child: closed ? null : new Column(children: widget.children),
        );
    }
}