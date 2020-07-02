import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/gestures.dart';

import 'ball_game.dart';

class PauseButton extends SpriteComponent {
  final BallGame game;
  final Offset position;

  PauseButton(
    this.game,
    double width,
    double height,
    this.position,
  ) : super.fromSprite(width, height, Sprite('pause_button.png')) {
    anchor = Anchor.topRight;
    x = position.dx;
    y = position.dy;
    pos();
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  Rect area() {
    return Rect.fromLTWH(x - width, y, width, height);
  }

  void pos() {
    y = (game.screenSize.height * 0.09 * 0.5) - (height / 2) ;
  }
}
