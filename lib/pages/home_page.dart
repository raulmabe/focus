import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter/cupertino.dart';
import '../themes/mainTheme.dart';
import '../utils/counter.dart';
import '../utils/customappbar.dart';
import '../utils/sound_grid.dart';
import '../utils/settings.dart';

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return new HomePage();
  }
}

class HomePage extends StatefulWidget{
  
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {

  AnimationController _counterController;
  static const int _startWorkValue = 52;
  static const int _startRestValue = 17;

  bool _isWorking = true;

  AnimationController _mainButtonOpacityController, _mainButtonSizeController;
  Animation<double> _mainButtonOpacityAnim, _mainButtonSizeAnim;

  @override
  void initState(){
    super.initState();
    changeStatusColor(Colors.transparent);

    _counterController = new AnimationController(
      vsync: this,
      duration: const Duration(seconds: _startWorkValue),
      value: 0.0,
    );

    _mainButtonOpacityController = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
      value: 1.0,
    );
    _mainButtonOpacityAnim = new CurvedAnimation(
      parent: _mainButtonOpacityController,
      curve: Curves.linear,
    );

    _mainButtonSizeController = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
      value: 0.0,
    );
    _mainButtonSizeAnim = new CurvedAnimation(
      parent: _mainButtonSizeController,
      curve: Curves.fastOutSlowIn,
    );

    addListeners();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme
      .of(context)
      .textTheme;
      changeNavigationColor(gradientColor2);
      return new Material(
        child: new Stack(
          children: <Widget>[
             new Container(
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
              child: new Align(
                alignment: FractionalOffset.bottomCenter,
                child: new Container(
                  padding: const EdgeInsets.all(10.0),
                  child: new Text(
                    'F O C U S',
                    style: textTheme.headline.copyWith(
                      color: Colors.grey.shade800.withOpacity(0.8),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              )
            ),
            new DefaultTabController(
              length: 2,
              child: new Scaffold(
                backgroundColor: Colors.transparent,
                appBar: new CustomAppBar(),
                body: new TabBarView(
                  children: <Widget>[
                    /**
                     *  Timer page
                     */
                    new Container(
                      margin: new EdgeInsets.all(20.0),
                      decoration: new BoxDecoration(
                        color: Colors.grey.shade100.withOpacity(0.2),
                        borderRadius: new BorderRadius.circular(5.0)
                      ),
                      child: new Counter(
                        animation: new StepTween(
                          end: 0,
                          begin: (_isWorking) ? _startWorkValue : _startRestValue,
                          ).animate(_counterController),
                      ),
                    ),
                    /**
                     *  Sound page
                     */
                    new Container(
                      margin: new EdgeInsets.all(20.0),
                      decoration: new BoxDecoration(
                        color: Colors.grey.shade100.withOpacity(0.2),
                        borderRadius: new BorderRadius.circular(5.0)
                      ),
                      child: new SoundGrid(),
                    ),
                  ],
                ),
                bottomNavigationBar: new Container(
                  height: 70.0,
                  margin: EdgeInsets.only(bottom: 50.0, left: 20.0, right: 20.0),
                  decoration: new BoxDecoration(
                    color: const Color.fromRGBO(0, 0, 0, 0.0), //Colors.grey.shade100.withOpacity(0.2),
                  ),
                  child: new Row(
                    children: <Widget>[
                      /**
                       * Settings Button
                       */
                      new Expanded(
                        child: new IconButton(
                          color: Colors.white,
                          icon: new Icon(Icons.more_horiz),
                          onPressed: showSettings,
                        ),
                      ),
                      /**
                       *  Play Button
                       */
                      new Expanded(
                        child: new Opacity(
                          opacity: _mainButtonOpacityAnim.value,
                          child: new Container(
                            width: 55.0 - _mainButtonSizeAnim.value*20,
                            height: 55.0 - _mainButtonSizeAnim.value*20,
                            child: new FloatingActionButton(
                              onPressed: _counterController.isAnimating ? null : () => playTime(),
                              backgroundColor: (_mainButtonOpacityController.isAnimating) ? detailsColor : mainButtonColor,
                              child: new Icon(
                                  _counterController.isAnimating ? null : Icons.data_usage,
                                  color: Colors.white,
                                  size: 30.0 - _mainButtonSizeAnim.value*20,
                              ),
                            ),
                          )
                        )
                      ),
                      /**
                       *  Restart Button
                       */
                      new Expanded(
                        child: new IconButton(
                          disabledColor: Colors.grey[500],
                          color: Colors.white,
                          icon: new Icon(Icons.settings_backup_restore),
                          onPressed: (!_counterController.isAnimating) ? null : () => restartTime(),
                        ),
                      )
                    ],
                  )
                ),
              ),
            ),
          ],
        ),
      );
    }

    void showSettings() async{

      await showDialog(
        context: context,
        child: new Dialog(
          child: new Settings((){
              setState(() {});
            })
        )
      );
    }

  @override
    void dispose() {
      _counterController.dispose();
      print("Disposing");// TODO: implement dispose
      super.dispose();
    }

    void playTime(){
      _counterController.forward(from: 0.0);
    }

    void restartTime(){
      _isWorking = true;
      _counterController.duration = new Duration(seconds: 52);
      _counterController.stop();
      _counterController.value = 0.0;

      _mainButtonSizeController.reverse(from: 1.0);
    }

    void addListeners(){
      _mainButtonOpacityAnim.addListener(() => this.setState(() {}));
      _mainButtonOpacityAnim.addStatusListener((status){
        if(status == AnimationStatus.completed) _mainButtonOpacityController.reverse(from: 1.0);
        if(status == AnimationStatus.dismissed) _mainButtonOpacityController.forward(from: 0.0);
      });
      _mainButtonSizeAnim.addListener(() => this.setState(() {}));
      


    _counterController.addStatusListener((status){
      if(status == AnimationStatus.completed ){
        if(_isWorking){
           _isWorking = false;
          _counterController.duration = new Duration(seconds: 17);
        } else{
           _isWorking = true;
           _counterController.duration = new Duration(seconds: 52);
        }
        _counterController.forward(from: 0.0);
      }
      if(status == AnimationStatus.dismissed){
        // RESTARTED TIME
        _mainButtonOpacityController.value = 1.0;
        _mainButtonOpacityController.stop();
      } 
      if(status == AnimationStatus.forward){
        // COUNTER STARTS
        _mainButtonOpacityController.reverse(from: 1.0);
        _mainButtonSizeController.forward(from: 0.0);
      }
      setState(() {});
    });
    }

/*
    void showSnack(String s){
        final snackbar = new SnackBar(
          content: new Text(s),
          action: new SnackBarAction(
            label: "Quit",
            onPressed: () => exit(0),
          ),
        );
        //Scaffold.of(context).showSnackBar(snackbar);
        scaffoldKey.currentState.showSnackBar(snackbar);
    }
*/

    void changeStatusColor(Color color) async {
    try {
      await FlutterStatusbarcolor.setStatusBarColor(color);
    }  catch (e) {
      print(e);
    }
  }

  void changeNavigationColor(Color color) async {
    try {
      await FlutterStatusbarcolor.setNavigationBarColor(color);
    }  catch (e) {
      print(e);
    }
  }
}