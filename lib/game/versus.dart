import 'dart:ui';

import 'package:flame/components/text_component.dart';
import 'package:flame/anchor.dart';
import 'package:flutter/gestures.dart';

import 'ball_game.dart';

class Versus extends TextComponent
{
  final BallGame game;
  final Offset position;

  Versus(
    this.game,
    this.position,
  ) : super('') {
    anchor = Anchor.bottomLeft;
    x = position.dx;
    y = position.dy;
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  @override
  void render(Canvas c) {
    if (game.status == Status.Playing) super.render(c);
  }

  void updateVersus() {
    text = game.selfFlag.selected.toUpperCase() + ' VS ' + game.flags.selectedCountry.toUpperCase();
  }
}
