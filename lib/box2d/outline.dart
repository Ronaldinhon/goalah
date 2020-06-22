import 'dart:ui';

import 'box2d_world.dart';
import '../game/ball_game.dart';
import '../game/helper.dart';

import 'package:flutter/gestures.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:box2d_flame/box2d.dart';

class Outline extends BodyComponent {
  Body body;
  PolygonShape shape1;
  Size screenSize;
  BasicWorld boxx;
  Offset bodyPos;
  BallGame game;

  Outline(this.boxx, this.screenSize) : super(boxx) {
    game = boxx.ballGame;

    final arr1 = List<Vector2>();
    arr1.add(offsetToVec(Offset(0, 0)));
    arr1.add(offsetToVec(Offset(screenSize.width, 0)));
    arr1.add(offsetToVec(Offset(screenSize.width, 8)));
    arr1.add(offsetToVec(Offset(0, 8)));
    shape1 = PolygonShape()..set(arr1, 4);

    BodyDef bd1 = BodyDef();
    bd1.linearVelocity = Vector2(0, 0);
    bd1.gravityScale = 0;
    bd1.position = offsetToVec(Offset(0, screenSize.height * 0.09));
    bd1.type = BodyType.KINEMATIC;

    FixtureDef fd1 = FixtureDef();
    fd1.density = 2;
    fd1.restitution = 0.1;
    fd1.friction = 0.2;
    fd1.shape = shape1;
    fd1.userData = 'top';

    body = world.createBody(bd1);
    body.createFixtureFromFixtureDef(fd1);
  }

  @override
  void update(double t) {}

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
          renderPolygon(canvas, _renderPolygonM(fixture), Color.fromARGB(255, 255, 255, 255));
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
}
