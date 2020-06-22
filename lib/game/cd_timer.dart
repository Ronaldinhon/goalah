import 'dart:async';
import 'dart:ui';

import 'package:flame/components/text_component.dart';
import 'package:flame/anchor.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/gestures.dart';

import 'ball_game.dart';

class CdTimer extends TextComponent {
  final BallGame game;
  final Offset position;
  final String lol;
  Timer _pointOnes = Timer.periodic(Duration(seconds: 60), (timer) {});
  Stopwatch stopwatch = Stopwatch();
  double loop = 3.0;

  CdTimer(
    this.game,
    this.lol,
    this.position,
  ) : super(lol) {
    x = position.dx;
    y = position.dy;
    anchor = Anchor.topRight;
    pos();
  }

  @override
  void update(double dt) {
    var remainingTime = loop - (stopwatch.elapsedMilliseconds / 1000);
    if (remainingTime > 0.5) {
      config = TextConfig(color: Color.fromARGB(255, 0, 0, 0));
    } else {
      config = TextConfig(color: Color.fromARGB(255, 255, 0, 0));
    }
    text = remainingTime.toStringAsFixed(1) + 's';
    super.update(dt);
  }

  void resetCDown() {
    // loop = 3.0;
    // _pointOnes = Timer.periodic(Duration(milliseconds: 100), (timer) {
    //   loop -= 0.1;
    // });
    stopwatch.reset();
    stopwatch.start();
  }

  void stopTimer() {
    // _pointOnes.cancel();
    stopwatch.stop();
  }

  void pos() {
    y = (game.screenSize.height * 0.09 * 0.5) - (height / 2);
  }
}
