import 'dart:ui';

import 'package:flame/components/text_component.dart';
import 'package:flame/anchor.dart';
import 'package:flutter/gestures.dart';

import 'ball_game.dart';

class ResumeWord extends TextComponent
{
  final BallGame game;
  final Offset position;

  ResumeWord(
    this.game,
    this.position,
  ) : super('Resume') {
    anchor = Anchor.topCenter;
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
}
