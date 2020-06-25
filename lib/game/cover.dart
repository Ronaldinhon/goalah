import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/gestures.dart';

import 'ball_game.dart';
import 'db_helper.dart';

class Cover extends SpriteComponent {
  final BallGame game;
  final Offset position;
  double recordHeight;

  Cover(
    this.game,
    double width,
    double height,
    this.position,
  ) : super.fromSprite(width, height, Sprite('shadow.png')) {
    anchor = Anchor.topRight;
    x = position.dx;
    y = position.dy;
    recordHeight = height;
    updateCover();
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  @override
  void render(Canvas c) {
    if (game.score > 0) {
      super.render(c);
    }
  }

  void updateCover() {
    height = ((21 - (game.score ~/ 10)) / 21) * recordHeight;
  }
}
