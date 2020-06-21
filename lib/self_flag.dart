import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/gestures.dart';

import 'ball_game.dart';
import 'db_helper.dart';
import 'helper.dart';

class SelfFlag extends SpriteComponent {
  final BallGame game;
  final Offset position;
  String selected;

  SelfFlag(
    this.game,
    double width,
    double height,
    this.position,
  ) : super.fromSprite(width, height, Sprite('grey.png')) {
    anchor = Anchor.bottomRight;
    x = position.dx;
    y = position.dy;
    getCountry();
  }

  @override
  void update(double dt) {
    // print(game.status);
    super.update(dt);
  }

  Future<void> getCountry() async {
    final dataList = await DBHelper.getData('country', 0);
    if (dataList.isNotEmpty) {
      selected = dataList[0]['country_code'];
      sprite = Sprite(selected + '.png');
      setCountryCodeList(selected);
    } else {
      game.status = Status.PendingCountry;
    }
  }

  void setFlag(String countryCode) {
    selected = countryCode;
    sprite = Sprite(countryCode + '.png');
    game.status = Status.Playing;
    DBHelper.insert('country', {'id': 0, 'country_code': countryCode});
    setCountryCodeList(selected);
  }

  void setCountryCodeList(String code) {
    var codeList = countryCodes();
    codeList.removeWhere((item) => item == code);
    codeList.shuffle();
    game.countryList = codeList;
    game.flags.selected = -1;
    game.flags.updateFlag();
  }

  Rect area() {
    return Rect.fromLTWH(x - width, y - height, width, height);
  }
}
