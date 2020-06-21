import 'package:box2d_flame/box2d.dart';
import 'package:flame/flame.dart';

import 'box2d_world.dart';

class MyContactListener extends ContactListener {
  List<Body> toDestroy = [];
  BasicWorld bWorld;
  // DateTime top = DateTime.now();
  // DateTime bottom = DateTime.now();
  // DateTime left = DateTime.now();
  // DateTime right = DateTime.now();

  MyContactListener(this.bWorld);

  @override
  void beginContact(Contact contact) {}

  @override
  void endContact(Contact contact) {}

  @override
  void postSolve(Contact contact, ContactImpulse impulse) {}

  @override
  void preSolve(Contact contact, Manifold oldManifold) {}
}
