import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/gestures.dart';

import 'ball_game.dart';

class PickCountry extends SpriteComponent {
  final BallGame game;
  final Offset position;
  String selected;
  bool troy = false;

  PickCountry(
    this.game,
    double width,
    double height,
    this.position,
  ) : super.fromSprite(width, height, Sprite('choose_country.png')) {
    anchor = Anchor.bottomRight;
    x = position.dx;
    y = position.dy;
  }

  @override
  void update(double dt) {
    if (game.score > 0) troy = true;
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
