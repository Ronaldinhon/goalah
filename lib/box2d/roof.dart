import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:box2d_flame/box2d.dart';

import '../helper.dart';
import 'box2d_world.dart';

class Roof extends BodyComponent {
  Body body;
  ChainShape shape;
  Size screenSize;
  final BasicWorld box;
  Offset position;
  List<Offset> points;
  List<Vector2> vecs = List<Vector2>();

  Roof(this.box, this.screenSize, this.points) : super(box) {
    position = Offset.zero;
    points.forEach((p) => vecs.add(offsetToVec(p)));
    shape = ChainShape()..createChain(vecs, vecs.length);
    
    BodyDef bd = BodyDef();
    bd.linearVelocity = Vector2.zero();
    bd.position = offsetToVec(position);
    bd.type = BodyType.STATIC;

    FixtureDef fd = FixtureDef();
    fd.density = 0;
    fd.restitution = 0.2;
    fd.friction = 0.3;
    fd.shape = shape;
    fd.userData = 'top';
    
    body = world.createBody(bd);
    body.createFixtureFromFixtureDef(fd);
  }

  @override
  void update(double t) {}

  @override
  void render(Canvas canvas) {}
}
