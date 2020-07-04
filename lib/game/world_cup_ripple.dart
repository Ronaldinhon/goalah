import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/gestures.dart';

import 'ball_game.dart';

class WorldCupRipple extends SpriteComponent {
  final BallGame game;
  final Offset position;
  double oriWidth;
  double oriHeight;
  double cubicTime = 0;
  Cubic inOut = Curves.easeInOut;
  bool increase = true;

  WorldCupRipple(
    this.game,
    double width,
    double height,
    this.position,
  ) : super.fromSprite(width, height, Sprite('worldcup.png')) {
    anchor = Anchor.center;
    x = position.dx;
    y = position.dy;
    oriWidth = width;
    oriHeight = height;
  }

  @override
  void render(Canvas c) {
    if (game.status == Status.Playing && game.score == 0) {
      super.render(c);
    }
  }

  @override
  void update(double dt) {
    if (increase) {
      cubicTime += dt;
      if (cubicTime > 1) {
        cubicTime = 0;
        increase = false;
        Future.delayed(Duration(milliseconds: 699), () {
          increase = true;
        });
      }
    }
    width = (1 + inOut.transform(cubicTime)) * oriWidth;
    height = (1 + inOut.transform(cubicTime)) * oriHeight;
    var pain = Paint()..color = Color.fromRGBO(0, 0, 0, 1 - inOut.transform(cubicTime));
    sprite = Sprite('worldcup.png')..paint = pain;
    super.update(dt);
  }
}
