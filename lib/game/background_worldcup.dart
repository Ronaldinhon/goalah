import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/gestures.dart';

import 'ball_game.dart';

class BackgroundWorldcup extends SpriteComponent {
  final BallGame game;
  final Offset position;
  int selected = -1;
  static Paint pain = Paint()..color =  Color.fromRGBO(255, 255, 255, 0.5);

  BackgroundWorldcup(
    this.game,
    double width,
    double height,
    this.position,
  ) : super.fromSprite(width, height, Sprite('grey.png')..paint = pain) {
    anchor = Anchor.bottomCenter;
    x = position.dx;
    y = position.dy;
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  @override
  void render(Canvas c) {
    super.render(c);
  }

  void updateHeight() {
    height = ((game.score ~/ 10) / 21) * (game.screenSize.height * 0.6);
    sprite = Sprite('row-' + (game.score ~/ 10).toString() + '.png')
      ..paint = pain;
  }

  // void updateFlag() {
  //   ++selected;
  //   var pain = Paint()..color =  Color.fromRGBO(255, 255, 255, 0.3);
  //   sprite = Sprite(game.countryList[selected] + '.png')
  //     ..paint = pain;
  // }
}
