import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'helper.dart';

import 'ball_game.dart';

class Pointer extends SpriteComponent {
  final BallGame game;
  final Offset position;
  bool troy = false;
  List<Offset> offsets = List<Offset>();
  int target = 1;

  Pointer(
    this.game,
    double width,
    double height,
    this.position,
  ) : super.fromSprite(width, height, Sprite('pointer.png')) {
    anchor = Anchor.center;
    x = position.dx;
    y = position.dy;
    var diff = game.screenSize.width * 0.1;
    offsets.addAll([
      position,
      Offset(position.dx, position.dy - (diff * 1.5)),
      Offset(position.dx - (diff * 2), position.dy - (diff * 1.5)),
      Offset(position.dx + (diff * 2), position.dy - (diff * 1.5)),
      Offset(position.dx, position.dy - (diff * 1.5)),
    ]);
  }

  @override
  void update(double dt) {
    double stepDistance = 40 * dt;
    Offset toTarget = offsets[target] - Offset(x, y);
    if (stepDistance < toTarget.distance) {
      Offset stepToTarget =
          Offset.fromDirection(toTarget.direction, stepDistance);
      x += stepToTarget.dx;
      y += stepToTarget.dy;
    } else {
      x += toTarget.dx;
      y += toTarget.dy;
      setTargetLocation();
    }
    if (game.score > 0) {
      game.setCountryValue();
      troy = true;
    }
    super.update(dt);
  }

  void render(Canvas c) {
    if (game.status == Status.Playing &&
        game.score == 0 &&
        !game.overlayShown) {
      c.drawLine(
          offsets[0] - Offset(0, height / 2),
          offsets[1] - Offset(0, height / 2),
          Paint()
            ..color = Color.fromARGB(255, 169, 169, 169)
            ..strokeWidth = 2);
      c.drawLine(
          offsets[2] - Offset(0, height / 2),
          offsets[3] - Offset(0, height / 2),
          Paint()
            ..color = Color.fromARGB(255, 169, 169, 169)
            ..strokeWidth = 2);
      super.render(c);
    }
  }

  void setTargetLocation() {
    ++target;
    if (target > 4) target -= 5;
  }

  Offset differ() {
    return (Offset(x, y) - position);
  }

  bool destroy() {
    return troy;
  }
}
