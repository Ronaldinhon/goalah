import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:box2d_flame/box2d.dart';
import 'package:flutter/gestures.dart';

// import '../ball_game.dart';
import '../game/helper.dart';
import 'box2d_world.dart';

class Football extends BodyComponent {
  CircleShape ball;
  Size screenSize;
  Offset centerPos;
  BasicWorld boxx;

  DateTime top = DateTime.now();
  DateTime bottom = DateTime.now();
  DateTime left = DateTime.now();
  DateTime right = DateTime.now();
  DateTime partition = DateTime.now();

  Football(this.boxx, this.screenSize) : super(boxx) {
    var tilesize = boxx.ballGame.tileSizeX;
    centerPos = Offset(tilesize * 4.5, screenSize.height * 0.5);
    ball = CircleShape()..radius = tilesize / 2 / 50;

    BodyDef bd = BodyDef();
    bd.linearVelocity = Vector2(0, 0);
    bd.angularVelocity = 0;
    bd.linearDamping = 0.1;
    bd.angularDamping = 0.1;
    bd.position = offsetToVec(centerPos);
    bd.type = BodyType.DYNAMIC;

    FixtureDef fd = FixtureDef();
    fd.density = 20;
    fd.restitution = 0.2;
    fd.friction = 0.2;
    fd.shape = ball;
    fd.userData = 'ball';

    body = world.createBody(bd);
    body.createFixtureFromFixtureDef(fd);
  }

  @override
  void update(double t) {
    // print(world.getContactCount());

    for (Contact contact = world.getContactList();
        contact != null;
        contact = contact.getNext()) {
      if (contact.isTouching() &&
          [contact.fixtureA.userData, contact.fixtureB.userData]
              .contains('ball')) {
        var a = contact.fixtureA.userData;
        var b = contact.fixtureB.userData;
        var aBody = contact.fixtureA.getBody();
        var bBody = contact.fixtureB.getBody();
        var yImpact =
            (aBody.linearVelocity.y - bBody.linearVelocity.y).abs() / 5;
        var xImpact =
            (aBody.linearVelocity.x - bBody.linearVelocity.x).abs() / 10;
        var yImpact2d =
            yImpact > 1.0 ? 1.0 : double.parse(yImpact.toStringAsFixed(2));
        var xImpact2d =
            xImpact > 1.0 ? 1.0 : double.parse(xImpact.toStringAsFixed(2));
        if ([a, b].contains('top')) {
          if (DateTime.now().difference(top).inMilliseconds >= 150) {
            Flame.audio.play('BouncingBall.mp3', volume: yImpact2d / 2);
          }
          top = DateTime.now();
        } else if ([a, b].contains('bottom')) {
          if (DateTime.now().difference(bottom).inMilliseconds >= 150) {
            Flame.audio.play('BouncingBall.mp3', volume: yImpact2d / 1.5);
          }
          if (boxx.ballGame.countDown.stopped) boxx.ballGame.countDown.resetCDown();
          bottom = DateTime.now();
        } else if ([a, b].contains('left')) {
          if (DateTime.now().difference(left).inMilliseconds >= 150) {
            Flame.audio.play('BouncingBall.mp3', volume: xImpact2d / 1.5);
          }
          left = DateTime.now();
        } else if ([a, b].contains('right')) {
          if (DateTime.now().difference(right).inMilliseconds >= 150) {
            Flame.audio.play('BouncingBall.mp3', volume: xImpact2d / 1.5);
          }
          right = DateTime.now();
        } else if ([a, b].contains('partition')) {
          if (DateTime.now().difference(partition).inMilliseconds >= 150) {
            Flame.audio.play('BouncingBall.mp3', volume: xImpact2d / 2);
          }
          partition = DateTime.now();
        }
      }
    }
  }

  @override
  void render(Canvas canvas) {}

  Path circle() {
    return Path()
      ..addOval(Rect.fromCenter(
          center: vecToOffset(body.position),
          width: boxx.ballGame.tileSizeX,
          height: boxx.ballGame.tileSizeX));
  }

  double topY() {
    return (vecToOffset(body.position).dy - (boxx.ballGame.tileSizeX / 2));
  }

  // void relocate() {
  //   body.linearVelocity = Vector2.zero();
  //   body.setTransform(boxx.balance.body.position - Vector2(0, 4), 0);
  // }
}
