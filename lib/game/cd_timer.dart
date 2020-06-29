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
  Stopwatch stopwatch = Stopwatch();
  double loop = 3.0;
  bool stopped = false;

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
