import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';

import 'ball_game.dart';

class Plshadow extends SpriteComponent {
  final BallGame game;
  final Offset position;
  bool troy = false;

  Plshadow(
    this.game,
    double width,
    double height,
    this.position,
  ) : super.fromSprite(width, height, Sprite('shadow.png')) {
    anchor = Anchor.center;
    x = position.dx;
    y = position.dy;
  }

  @override
  void update(double dt) {
    var differ = game.pointer.differ();
    y = position.dy + (differ.dy * 2);
    angle = -differ.dx / (game.screenSize.width * 0.4) * 0.85;
    if (game.score > 0) troy = true;
    super.update(dt);
  }

  void render(Canvas c) {
    if (game.status == Status.Playing && game.score == 0 && !game.overlayShown) {
      super.render(c);
    }
  }

  bool destroy() {
    return troy;
  }
}
