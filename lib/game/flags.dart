import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/gestures.dart';

import 'ball_game.dart';

class Flags extends SpriteComponent {
  final BallGame game;
  final Offset position;
  int selected = -1;
  String selectedCountry;

  Flags(
    this.game,
    double width,
    double height,
    this.position,
  ) : super.fromSprite(width, height, Sprite('grey.png')) {
    anchor = Anchor.topLeft;
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
    selectedCountry = game.countryList[selected];
    sprite = Sprite(selectedCountry + '.png');
  }

  Rect area() {
    return Rect.fromLTWH(x - width, y, width, height);
  }

  void pos() {
    y = (game.screenSize.height * 0.09 * 0.5) - (height / 2) ;
  }
}
