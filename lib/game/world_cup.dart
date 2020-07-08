import 'dart:core';
import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/gestures.dart';

import 'ball_game.dart';

class WorldCup extends SpriteComponent {
  final BallGame game;
  final Offset position;

  WorldCup(
    this.game,
    double width,
    double height,
    this.position,
  ) : super.fromSprite(width, height, Sprite('worldcup.png')) {
    anchor = Anchor.topRight;
    x = position.dx;
    y = position.dy;
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  Rect area() {
    return Rect.fromLTWH(x - width, y, width, height);
  }
}
