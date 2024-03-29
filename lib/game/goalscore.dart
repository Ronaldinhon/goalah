import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/gestures.dart';

import 'ball_game.dart';

class Goalscore extends SpriteComponent {
  final BallGame game;
  final Offset position;
  bool score = false;
  bool scored = false;

  Goalscore(
    this.game,
    double width,
    double height,
    this.position,
  ) : super.fromSprite(width, height, Sprite('goalscore.png')) {
    anchor = Anchor.topLeft;
    x = position.dx;
    y = position.dy;
  }

  @override
  void update(double dt) {
    if (!Path.combine(PathOperation.intersect, rect(), game.baller.circle())
        .getBounds()
        .isEmpty) {
      score = true;
    } else {
      score = false;
      scored = false;
    }
    if (score && !scored) {
      ++game.score;
      scored = true;
      Flame.audio.play('goal_robot.mp3');
      game.basicWorld.goalpost.tele = true;
      game.countDown.stopTimer();
      game.cover.updateCover();
      game.backWorld.updateHeight();
    }
    if (game.score == 210) {
      game.saveWinning();
    }
    super.update(dt);
  }

  Path rect() {
    return Path()
      ..addRect(Rect.fromLTWH(x, y, width, height));
  }
}
