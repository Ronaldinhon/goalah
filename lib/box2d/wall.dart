import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:box2d_flame/box2d.dart';

import '../helper.dart';
import 'box2d_world.dart';

class Wall extends BodyComponent {
  Body body;
  PolygonShape shape;
  Size screenSize;
  final BasicWorld box;
  Offset position;
  Offset point1;
  Offset point2;

  Wall(this.box, this.screenSize, this.position, lor) : super(box) {
    var length = screenSize.height / 2;
    point1 = Offset(0, -length);
    point2 = Offset(0, length);

    shape = PolygonShape()..setAsEdge(offsetToVec(point1), offsetToVec(point2));
    BodyDef bd = BodyDef();
    bd.linearVelocity = Vector2.zero();
    bd.position = offsetToVec(position);
    bd.type = BodyType.STATIC;
    
    FixtureDef fd = FixtureDef();
    fd.density = 0;
    fd.restitution = 0.3;
    fd.friction = 0.3;
    fd.shape = shape;
    fd.userData = lor;
    
    body = world.createBody(bd);
    body.createFixtureFromFixtureDef(fd);
  }

  @override
  void update(double t) {}

  @override
  void render(Canvas canvas) {}
}
