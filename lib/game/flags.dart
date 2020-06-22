import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/gestures.dart';

import 'ball_game.dart';
import 'db_helper.dart';

class Flags extends SpriteComponent {
  final BallGame game;
  final Offset position;
  int selected = -1;

  Flags(
    this.game,
    double width,
    double height,
    this.position,
  ) : super.fromSprite(width, height, Sprite('grey.png')) {
    anchor = Anchor.topRight;
    x = position.dx;
    y = position.dy;
    pos();
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  void updateFlag() {
    ++selected;
    sprite = Sprite(game.countryList[selected] + '.png');
  }

  Rect area() {
    return Rect.fromLTWH(x - width, y - height, width, height);
  }

  void pos() {
    y = (game.screenSize.height * 0.09 * 0.5) - (height / 2) ;
  }
}
