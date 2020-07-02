import 'dart:ui';

import 'package:fbr_dwc/box2d/goalpost.dart';
import 'package:flutter/gestures.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:box2d_flame/box2d.dart';

import '../game/ball_game.dart';
import 'roof.dart';
import 'balancer.dart';
import 'my_contactlistener.dart';
import 'wall.dart';
import 'football.dart';
import 'outline.dart';

class BasicWorld extends Box2DComponent {
  Balancer balance;
  BallGame ballGame;
  Size screenSize;
  Wall wallA;
  Wall wallE;
  Roof roof;
  MyContactListener myContactListener;
  Football baller;
  Outline outline;
  Goalpost goalpost;
  double unitWidth;

  double dta;
  int velocityIterationsa;
  int positionIterationsa;

  // int velocityIterations;
  // int positionIterations;

  BasicWorld(this.ballGame, Size size) : super(scale: 1.0) {
    screenSize = size;
  }

  @override
  void initializeWorld() {
    world = World.withGravity(Vector2(0, 13));
    balance = Balancer(this, screenSize);
    wallA = Wall(this, screenSize, Offset(0, screenSize.height / 2), 'left');
    wallE = Wall(this, screenSize,
        Offset(screenSize.width, screenSize.height / 2), 'right');

    roof = Roof(this, screenSize, [Offset.zero, Offset(screenSize.width, 0)]);

    baller = Football(this, screenSize);
    outline = Outline(this, screenSize);
    goalpost = Goalpost(this, screenSize);
    unitWidth = ballGame.unitWidth;

    world.setContactListener(myContactListener = MyContactListener(this));
    dta = world.step.dt;
    velocityIterationsa = world.step.velocityIterations;
    positionIterationsa = world.step.positionIterations;
    print(dta);
    // print(velocityIterationsa);
    // print(positionIterationsa);
  }

  void pause() {
    // print('here');
    // world.stack.forEach((bod) {
    //   bod.setActive(false);
    // });
    baller.body.setActive(false);
    balance.body.setActive(false);
    // world.stepDt(0, 5, 5);
    // velocityIterations = null;
    // positionIterations = null;
  }

  void resume() {
    // world.stepDt(0, velocityIterationsa, positionIterationsa);
    ballGame.countDown.resetCDown();
    ballGame.countDown.paused = false;
    baller.body.setActive(true);
    balance.body.setActive(true);
  }
}

// import 'partition.dart';
// import 'top_bottom.dart';
// List<Partition> parts = List<Partition>();
// List<TopBottom> tops = List<TopBottom>();
// parts.forEach((p) {
//   tops.addAll([p.top, p.bottom]);
// });
// List<Partition> makePartition(double yPos) {
//   List<Partition> list = List<Partition>();
//   for (var x = 0; x <= 4; ++x) {
//     list.add(
//       Partition(
//           this, screenSize, Offset(((1 + x) * (unitWidth)) + (x * 6) + 3, yPos)),
//     );
//   }
//   return list;
// }
