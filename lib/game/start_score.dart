import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/anchor.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/gestures.dart';

import 'ball_game.dart';
import 'db_helper.dart';

class StartScore extends SpriteComponent {
  final BallGame game;
  final Offset position;
  bool troy = false;
  Curve bIn = Curves.bounceIn;
  double cubicTime = 0.28;
  double oriY;
  bool up;

  StartScore(
    this.game,
    double width,
    double height,
    this.position,
  ) : super.fromSprite(width, height, Sprite('score_to_start.png')) {
    anchor = Anchor.center;
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
    print(bIn.transform(cubicTime));
    var pain = Paint()..color = Color.fromRGBO(255, 255, 255, 0.5 + (bIn.transform(cubicTime) * 2));
    sprite = Sprite('score_to_start.png')
      ..paint = pain;
    // y = oriY + (bIn.transform(cubicTime) * 49);
    super.update(dt);
  }

  @override
  void render(Canvas c) {
    if (game.status == Status.Playing) {
      super.render(c);
    }
  }

  bool destroy() {
    return troy;
  }
}
