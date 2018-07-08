import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayer.dart';

class SoundGrid extends StatefulWidget{

 @override
  _soundGridState createState() => new _soundGridState();
}

enum PlayerState { stopped, playing, paused }

class _soundGridState extends State<SoundGrid> {

  List<AudioPlayer> audioPlayers;

  List<PlayerState> playerStates;
  List<String> paths;

  List<AssetImage> images;
  List<bool> activeSounds;
  List<double> volumeSounds;

  @override
    void initState() {
      images = new List<AssetImage>();
      activeSounds = new List<bool>();
      volumeSounds = new List<double>();
      audioPlayers = new List<AudioPlayer>();
      playerStates = new List<PlayerState>();
      paths = new List<String>();
      for(int i = 0; i < 16; ++i) images.add(new AssetImage(getImage(i)));
      for(int i = 0; i < 16; ++i) activeSounds.add(false);
      for(int i = 0; i < 16; ++i) volumeSounds.add(0.5);
      for(int i = 0; i < 16; ++i) audioPlayers.add(new AudioPlayer());
      for(int i = 0; i < 16; ++i) playerStates.add(PlayerState.stopped);
      for(int i = 0; i < 16; ++i) paths.add(getPath(i));
      super.initState();
    }

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new Center(
        child: new GridView.count(
          crossAxisCount: 2,
          children: new List.generate(16, (index){
            return new Center(
              child: new GestureDetector(
                onTap: () => setSound(index, !activeSounds[index]),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Container(
                      width: 90.0,
                      height: 90.0,
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                          fit: BoxFit.scaleDown,
                          image: images[index],
                        )
                      ),
                    ),
                    modularWidget(index),
                  ],
                ),
              ),
            );
          })),
      );
    }

    Widget modularWidget(int index){
      bool isActive = activeSounds[index];
      if(!isActive) return new Padding(padding: EdgeInsets.only(top: 32.0,));
      else return new Slider(
        value: volumeSounds[index],
        min: 0.0,
        max: 1.0,
        activeColor: Colors.white,
        inactiveColor: Colors.white,
        divisions: 10,
        onChanged: (double value) => changeVolume(index, value),
      );
    }

    playSound(int i) async {
      final dir = await getTemporaryDirectory();
      final file = new File('${dir.path}/${paths[i]}');
      final soundData = await rootBundle.load('assets/sounds/${paths[i]}');
      final bytes = soundData.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      print('Playing ${paths[i]}');
      int result = 0;
      if(playerStates[i] != PlayerState.playing)
        result = await audioPlayers[i].play(file.path, isLocal: true, volume: volumeSounds[i], loop: true);
      if(result == 1) playerStates[i] = PlayerState.playing;
    }


    void changeVolume(int i, double value) async{
      volumeSounds[i] = value;
      setState(() {});
      await audioPlayers[i].volume(value);
    }

    void setSound(int i, bool play) async{
      activeSounds[i] = play;
      setState(() {});
      // Reproduce sound
      if(play) playSound(i);
      else{
        await audioPlayers[i].stop();
        playerStates[i] = PlayerState.stopped;
      }
    }

    String getPath(int i){
      i = 0;
      switch (i) {
        case 0: return 'sample_loop.wav';
        case 1: return 'thunder.mp3';
        case 2: return 'wind.mp3';
        case 3: return 'forest.mp3';
        case 4: return 'leaves.mp3';
        case 5: return 'water.mp3';
        case 6: return 'seaside.mp3';
        case 7: return 'water_pops.mp3';
        case 8: return 'fire.mp3';
        case 9: return 'night.mp3';
        case 10: return 'coffee.mp3';
        case 11: return 'train.mp3';
        case 12: return 'fan.mp3';
        case 13: return 'whitenoise.mp3';
        case 14: return 'pinknoise.mp3';
        case 15: return 'brownnoise.mp3';
        default : return '';
      }
    }

    String getImage(int index){
      switch (index) {
        case 0: return 'assets/rain.png';
        case 1: return 'assets/thunder.png';
        case 2: return 'assets/wind.png';
        case 3: return 'assets/forest.png';
        case 4: return 'assets/leaves.png';
        case 5: return 'assets/water.png';
        case 6: return 'assets/seaside.png';
        case 7: return 'assets/water_pops.png';
        case 8: return 'assets/fire.png';
        case 9: return 'assets/night.png';
        case 10: return 'assets/coffee.png';
        case 11: return 'assets/train.png';
        case 12: return 'assets/fan.png';
        case 13: return 'assets/whitenoise.png';
        case 14: return 'assets/pinknoise.png';
        case 15: return 'assets/brownnoise.png';
        default : return '';
      }
    }

}