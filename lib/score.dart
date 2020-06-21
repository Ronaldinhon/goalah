import 'dart:ui';

import 'package:flame/components/text_component.dart';
// import 'package:flame/anchor.dart';
// import 'package:flame/sprite.dart';
import 'package:flutter/gestures.dart';
import 'helper.dart';

import 'ball_game.dart';

class Score extends TextComponent
{
  final BallGame game;
  final Offset position;
  final String lol;
  // bool positioned = false;

  Score(
    this.game,
    this.lol,
    this.position,
  ) : super(lol) {
    x = position.dx;
    y = position.dy;
    pos();
  }

  @override
  void update(double dt) {
    text = 'Goals: ' + game.score.toString();
    super.update(dt);
  }

  void pos() {
    // print('heighttttttt'); -> nice
    y = (game.screenSize.height * 0.09 * 0.5) - (height / 2) ;
  }
}
