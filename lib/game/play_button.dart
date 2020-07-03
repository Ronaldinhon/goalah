import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/gestures.dart';

import 'ball_game.dart';

class PlayButton extends SpriteComponent {
  final BallGame game;
  final Offset position;

  PlayButton(
    this.game,
    double width,
    double height,
    this.position,
  ) : super.fromSprite(width, height, Sprite('play_button.png')) {
    anchor = Anchor.center;
    x = position.dx;
    y = position.dy;
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  @override
  void render(Canvas c) {
    if (game.status == Status.Pause) super.render(c);
  }

  Path area() {
    return Path()..addOval(Rect.fromCircle(center: Offset(x, y), radius: width / 2));
  }
}
