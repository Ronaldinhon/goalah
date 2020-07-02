import 'dart:async';
import 'dart:ui';

import 'package:flame/components/component.dart';
// import 'package:flame/components/text_component.dart';
import 'package:flame/anchor.dart';
import 'package:flame/sprite.dart';
// import 'package:flame/text_config.dart';
import 'package:flutter/gestures.dart';

import 'ball_game.dart';

class CdTimer extends SpriteComponent {
  final BallGame game;
  final Offset position;
  final double width;
  final double height;
  // final String lol;
  Stopwatch stopwatch = Stopwatch();
  int loop = 6;
  bool stopped = false;
  bool paused = false;

  CdTimer(
    this.game,
    this.width,
    this.height,
    this.position,
  ) : super.fromSprite(width, height, Sprite('0.png')) {
    x = position.dx;
    y = position.dy;
    anchor = Anchor.topCenter;
    pos();
  }

  @override
  void update(double dt) {
    var remainingTime = loop - (stopwatch.elapsedMilliseconds ~/ 500);
    // if (remainingTime >= 4) {
    //   config = TextConfig(color: Color.fromARGB(255, 0, 0, 0));
    // } else {
    //   config = TextConfig(color: Color.fromARGB(255, 255, 0, 0));
    // }
    if (remainingTime <= 0) remainingTime = 0;
    if (remainingTime <= 0 && !paused) {
      game.basicWorld.pause();
      paused = true;
    } 
    // text = remainingTime.toString();
    sprite = Sprite(remainingTime.toString() + '.png');
    super.update(dt);
  }

  void resetCDown() {
    stopwatch.reset();
    stopwatch.start();
    stopped = false;
  }

  void stopTimer() {
    stopwatch.stop();
    stopped = true;
  }

  void pos() {
    y = (game.screenSize.height * 0.09 * 0.5) - (height / 2);
  }
}
