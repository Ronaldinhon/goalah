import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/gestures.dart';

import 'ball_game.dart';

class Arrow extends SpriteComponent {
  final BallGame game;
  final Offset position;
  String selected;
  bool troy = false;
  double oriY;
  Curve bIn = Curves.bounceIn;
  double cubicTime = 0.28;
  bool up;

  Arrow(
    this.game,
    double width,
    double height,
    this.position,
  ) : super.fromSprite(width, height, Sprite('down_arrow.png')) {
    anchor = Anchor.bottomCenter;
    x = position.dx;
    y = position.dy;
    oriY = position.dy;
  }

  @override
  void update(double dt) {
    if (game.score > 0) troy = true;
    if (cubicTime <= 0.28) {
      up = true;
    } else if (cubicTime >= 0.64) {
      up = false;
    }
    if (up) {
      cubicTime += dt * 0.35;
    } else {
      cubicTime -= dt * 0.35;
    }
    if (cubicTime <= 0.28) {
      cubicTime = 0.28;
    } else if (cubicTime >= 0.64) {
      cubicTime = 0.64;
    }
    y = oriY - (bIn.transform(cubicTime) * (game.screenSize.width * 0.08));
    super.update(dt);
  }

  void render(Canvas c) {
    if (game.status == Status.PendingCountry) {
      super.render(c);
    }
  }

  bool destroy() {
    return troy;
  }
}
