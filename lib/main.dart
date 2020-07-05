import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'game/ball_game.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Util flameUtil = Util();
  // await flameUtil.fullScreen();
  // await flameUtil.setOrientation(DeviceOrientation.portraitUp);
  // Size size = await Flame.util.initialDimensions();
  // Flame.audio.disableLog();

  // BallGame game = BallGame(size);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  BallGame _myGame;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: newGame(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            body: _myGame.widget,
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  dynamic newGame() async {
    Util flameUtil = Util();
    await flameUtil.fullScreen();
    await flameUtil.setOrientation(DeviceOrientation.portraitUp);
    Size size = await Flame.util.initialDimensions();
    Flame.audio.disableLog();
    _myGame = BallGame(size);
    return _myGame.widget;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // print('HeredidChangeAppLifecycleStatedidChangeAppLifecycleState');
    if (state == AppLifecycleState.paused) {
      if (_myGame.status == Status.Playing && _myGame.score > 0)
        _myGame.pauseGame();
    }

    if (state == AppLifecycleState.resumed) {}
  }
}
