import 'dart:ui';

import 'box2d_world.dart';
import '../ball_game.dart';
import '../helper.dart';

import 'package:flutter/gestures.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:box2d_flame/box2d.dart';

class Balancer extends BodyComponent {
  static double top;
  static double bottom;
  Body body;
  PolygonShape shape;
  Size screenSize;
  Offset center1;
  Offset center2;
  Offset compoundCenter;
  Offset differenceCenter;
  BasicWorld boxx;
  double angle;
  Offset bodyPos;
  BallGame game;
  List<Offset> rotatedPoints;

  Balancer(this.boxx, this.screenSize) : super(boxx) {
    angle = 0;
    game = boxx.ballGame;
    center1 = Offset((game.tileSizeX * 0) + 5, screenSize.height * 0.65);
    center2 = Offset((game.tileSizeX * 9) - 5, screenSize.height * 0.65);
    compoundCenter = center1 + center2;
    differenceCenter = center2 - center1;
    top = screenSize.height * 0.45;
    bottom = screenSize.height * 0.85;

    final arrrrrr = List<Vector2>();
    arrrrrr.add(offsetToVec(Offset(-differenceCenter.dx / 2, -5)));
    arrrrrr.add(offsetToVec(Offset(differenceCenter.dx / 2, -5)));
    arrrrrr.add(offsetToVec(Offset(differenceCenter.dx / 2, 5)));
    arrrrrr.add(offsetToVec(Offset(-differenceCenter.dx / 2, 5)));
    shape = PolygonShape()..set(arrrrrr, 4);

    BodyDef bd = BodyDef();
    bd.linearVelocity = Vector2.zero();
    bd.gravityScale = 0;
    bd.position = offsetToVec(compoundCenter / 2);
    bd.type = BodyType.KINEMATIC;

    FixtureDef fd = FixtureDef();
    fd.density = 2;
    fd.restitution = 0.1;
    fd.friction = 0.2;
    fd.shape = shape;
    fd.userData = 'bottom';

    body = world.createBody(bd);
    body.createFixtureFromFixtureDef(fd);

    bodyPos = vecToOffset(body.position);
  }

  // Path get polygonPath {
  //   return Path()..addPolygon(rotatedPoints, true);
  // }

  @override
  void update(double t) {
    if (game.status == Status.Playing) {
      bodyPos = vecToOffset(body.position);
      // actually i'm doing this for dy only
      Offset targetOffset =
          game.initialBalOffset - (game.initialDrag - game.currentDrag) * 1.5;
      if (targetOffset.dy < top) {
        targetOffset = Offset(screenSize.width / 2, top);
      } else if (targetOffset.dy > bottom) {
        targetOffset = Offset(screenSize.width / 2, bottom);
      }
      if (bodyPos.dy != targetOffset.dy) {
        body.linearVelocity = Vector2(0, (targetOffset - bodyPos).dy);
      }

      double supposedAngle = 0;
      if (!game.dragEnd) {
        if (game.currentDrag.dx < game.xCenterLeft) {
          supposedAngle = (game.xCenterLeft - game.currentDrag.dx) /
              (game.tileSizeX * 7) *
              0.85;
        } else if (game.currentDrag.dx > game.xCenterRight) {
          supposedAngle = (game.currentDrag.dx - game.xCenterRight) /
              (game.tileSizeX * 7) *
              -0.85;
        }
      }
      if (body.getAngle() != supposedAngle) {
        body.angularVelocity = (supposedAngle - body.getAngle()) * 6;
      }
    }
  }

  @override
  void render(Canvas canvas) {
    canvas.drawLine(
        Offset(0, top),
        Offset(screenSize.width, top),
        Paint()
          ..color = Color.fromARGB(255, 0, 0, 0)
          ..strokeWidth = 2);
    super.render(canvas);
  }

  // void delete() {
  //   body.getFixtureList().setFilterData(Filter()..maskBits = 0);
  //   print(body.getFixtureList().getFilterData().maskBits);
  // }
}
