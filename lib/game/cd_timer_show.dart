import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/anchor.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/gestures.dart';

import 'ball_game.dart';

class CdTimerShow extends SpriteComponent {
  final BallGame game;
  final Offset position;

  double oriWidth;
  double oriHeight;
  double cubicTime = 0;
  Cubic inOut = Curves.easeInOut;
  bool increase = true;
  int currentNumber = 6;
  bool shown = false;

  CdTimerShow(
    this.game,
    double width,
    double height,
    this.position,
  ) : super.fromSprite(width, height, Sprite('6.png')) {
    x = position.dx;
    y = position.dy;
    anchor = Anchor.center;
    oriWidth = width;
    oriHeight = height;
  }

  @override
  void update(double dt) {
    if (currentNumber != game.countDown.remainingTime) {
      cubicTime = 0;
      currentNumber = game.countDown.remainingTime;
      increase = true;
      shown = false;
    }
    if (increase) {
      cubicTime += dt;
      if (cubicTime > 0.65) {
        cubicTime = 0;
        increase = false;
        shown = true;
      }
    }
    width = (1 + inOut.transform(cubicTime)) * oriWidth;
    height = (1 + inOut.transform(cubicTime)) * oriHeight;
    var oppa = 0.7 - inOut.transform(cubicTime);
    var pain = Paint()
      ..color = Color.fromRGBO(255, 255, 255, oppa > 0 ? oppa : 0);
    sprite = Sprite(currentNumber.toString() + '.png')..paint = pain;
    super.update(dt);
  }

  @override
  void render(Canvas c) {
    if (currentNumber <= 3 && !shown) {
      super.render(c);
    }
  }
}
