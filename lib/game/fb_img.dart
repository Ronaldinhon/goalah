import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/gestures.dart';
import 'helper.dart';

import 'ball_game.dart';

class FbImg extends SpriteComponent
{
  final BallGame game;
  final Offset position;
  bool shown = false;
  bool active = false;
  bool troy = false;

  FbImg(
    this.game,
    double width,
    double height,
    this.position,
  ) : super.fromSprite(width, height, Sprite('football.png')) {
    anchor = Anchor.center;
    x = position.dx;
    y = position.dy;
  }

  @override
  void update(double dt) {
    var pos;
    pos = vecToOffset(game.baller.body.position);
    angle = game.baller.body.getAngle();
    x = pos.dx;
    y = pos.dy;
    super.update(dt);
  }
}
