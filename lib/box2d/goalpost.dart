import 'dart:math';
import 'dart:ui';

import 'box2d_world.dart';
import '../game/ball_game.dart';
import '../game/helper.dart';
import '../game/goalscore.dart';

import 'package:flutter/gestures.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:box2d_flame/box2d.dart';

class Goalpost extends BodyComponent {
  Body body;
  PolygonShape shape1;
  PolygonShape shape2;
  PolygonShape shape3;
  Size screenSize;
  BasicWorld boxx;
  Offset bodyPos;
  BallGame game;
  double xRange;
  Goalscore net;
  bool tele = false;

  Goalpost(this.boxx, this.screenSize) : super(boxx) {
    game = boxx.ballGame;
    bodyPos = Offset(
        screenSize.width * (0.5 - 0.14), (screenSize.height * 0.08) + 10);
    var halfWidth = screenSize.width * 0.28;
    xRange = screenSize.width * 0.72;

    final arr1 = List<Vector2>();
    arr1.add(offsetToVec(Offset(halfWidth, 0)));
    arr1.add(offsetToVec(Offset(0, 0)));
    arr1.add(offsetToVec(Offset(0, 9)));
    arr1.add(offsetToVec(Offset(halfWidth, 9)));
    shape1 = PolygonShape()..set(arr1, 4);

    BodyDef bd1 = BodyDef();
    bd1.linearVelocity = Vector2(0, 0);
    bd1.gravityScale = 0;
    bd1.position = offsetToVec(bodyPos);
    bd1.type = BodyType.KINEMATIC;

    FixtureDef fd1 = FixtureDef();
    fd1.density = 2;
    fd1.restitution = 0.1;
    fd1.friction = 0.2;
    fd1.shape = shape1;
    fd1.userData = 'partition';

    var tilesize = boxx.ballGame.tileSizeX;
    final arr2 = List<Vector2>();
    arr2.add(offsetToVec(Offset(0, 0)));
    arr2.add(offsetToVec(Offset(9, 0)));
    arr2.add(offsetToVec(Offset(9, tilesize + 14)));
    arr2.add(offsetToVec(Offset(0, tilesize + 14)));
    shape2 = PolygonShape()..set(arr2, 4);

    FixtureDef fd2 = FixtureDef();
    fd2.density = 2;
    fd2.restitution = 0.1;
    fd2.friction = 0.2;
    fd2.shape = shape2;
    fd2.userData = 'partition';

    final arr3 = List<Vector2>();
    arr3.add(offsetToVec(Offset((halfWidth), 0)));
    arr3.add(offsetToVec(Offset((halfWidth) - 9, 0)));
    arr3.add(offsetToVec(Offset((halfWidth) - 9, tilesize + 14)));
    arr3.add(offsetToVec(Offset((halfWidth), tilesize + 14)));
    shape3 = PolygonShape()..set(arr3, 4);

    FixtureDef fd3 = FixtureDef();
    fd3.density = 2;
    fd3.restitution = 0.1;
    fd3.friction = 0.2;
    fd3.shape = shape3;
    fd3.userData = 'partition';

    body = world.createBody(bd1);
    body.createFixtureFromFixtureDef(fd1);
    body.createFixtureFromFixtureDef(fd2);
    body.createFixtureFromFixtureDef(fd3);

    net =
        Goalscore(game, halfWidth - 12, tilesize + 10, bodyPos + Offset(6, 4));
    teleport1();
  }

  @override
  void update(double t) {
    if (tele &&
        boxx.baller.topY() > bottomY() &&
        boxx.baller.body.linearVelocity.y > 0) {
      teleport();
      tele = false;
    }
  }

  @override
  void render(Canvas canvas) {
    for (Fixture fixture = body.getFixtureList();
        fixture != null;
        fixture = fixture.getNext()) {
      switch (fixture.getType()) {
        case ShapeType.CHAIN:
          // _renderChain(canvas, fixture, Color.fromARGB(255, 0, 255, 0));
          break;
        case ShapeType.CIRCLE:
          // _renderCircle(canvas, fixture, Color.fromARGB(255, 0, 0, 255));
          break;
        case ShapeType.EDGE:
          throw Exception('not implemented');
          break;
        case ShapeType.POLYGON:
          renderPolygon(canvas, _renderPolygonM(fixture),
              Color.fromARGB(255, 150, 75, 0));
          break;
      }
    }
  }

  List<Offset> _renderPolygonM(Fixture fixture) {
    PolygonShape polygon = fixture.getShape();
    List<Offset> points = List<Offset>();
    for (int i = 0; i < polygon.count; ++i) {
      points.add(vecToOffset(polygon.vertices[i] + body.position));
    }

    return points;
  }

  void teleport() {
    move();
    game.countDown.resetCDown();
  }

  void teleport1() {
    move();
  }

  void move() {
    var ypos = vecToOffset(body.position).dy;
    var randomX = Random().nextDouble() * xRange;
    body.setTransform(offsetToVec(Offset(randomX, ypos)), 0);
    net.x = randomX + 6;
    game.flags.updateFlag();
    game.vs.updateVersus();
  }

  double bottomY() {
    return vecToOffset(body.position).dy + (boxx.ballGame.tileSizeX + 14) + (screenSize.height * 0.1);
  }
}
