import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/anchor.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/gestures.dart';

import 'ball_game.dart';

class CdTimer extends SpriteComponent {
  final BallGame game;
  final Offset position;
  final double width;
  final double height;
  Stopwatch stopwatch = Stopwatch();
  int loop = 6;
  int remainingTime = 6;
  bool stopped = false;
  bool paused = false;

  CdTimer(
    this.game,
    this.width,
    this.height,
    this.position,
  ) : super.fromSprite(width, height, Sprite('6.png')) {
    x = position.dx;
    y = position.dy;
    anchor = Anchor.topCenter;
    pos();
  }

  @override
  void update(double dt) {
    remainingTime = loop - (stopwatch.elapsedMilliseconds ~/ 500);
    if (remainingTime <= 0) remainingTime = 0;
    if (remainingTime <= 0 && !paused) {
      Flame.audio.play('whistle.mp3');
      game.basicWorld.pause();
      paused = true;
      game.status = Status.Lost;
      game.saveScore();
    } 
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

  void resume() {
    stopwatch.start();
  }

  void pos() {
    y = (game.screenSize.height * 0.09 * 0.5) - (height / 2);
  }
}
