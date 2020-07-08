import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/gestures.dart';

import 'ball_game.dart';

class PauseCover extends SpriteComponent {
  final BallGame game;
  final Offset position;
  int selected = -1;
  static Paint pain = Paint()..color = Color.fromRGBO(255, 255, 255, 0.65);

  PauseCover(
    this.game,
    double width,
    double height,
    this.position,
  ) : super.fromSprite(width, height, Sprite('grey.png')..paint = pain) {
    // anchor = Anchor.bottomCenter;
    x = position.dx;
    y = position.dy;
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  @override
  void render(Canvas c) {
    if ([Status.Pause, Status.Won, Status.Lost].contains(game.status)) super.render(c);
  }
}
