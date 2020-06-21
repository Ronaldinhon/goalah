import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/gestures.dart';
// import 'package:flame/components/mixins/tapable.dart';
import 'helper.dart';

import 'ball_game.dart';

class WoodImg extends SpriteComponent 
// with Tapable 
{
  final BallGame game;
  final Offset position;
  bool shown = false;
  bool active = false;
  bool troy = false;

  WoodImg(
    this.game,
    double width,
    double height,
    this.position,
  ) : super.fromSprite(width, height, Sprite('wood.png')) {
    anchor = Anchor.center;
    x = position.dx;
    y = position.dy;
  }

  @override
  void update(double dt) {
    var pos;
    pos = vecToOffset(game.balance.body.position);
    angle = game.balance.body.getAngle();
    x = pos.dx;
    y = pos.dy;
    super.update(dt);
  }
}
