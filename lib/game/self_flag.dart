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
  String selected = '___';

  SelfFlag(
    this.game,
    double width,
    double height,
    this.position,
  ) : super.fromSprite(width, height, Sprite('grey.png')) {
    anchor = Anchor.topRight;
    x = position.dx;
    y = position.dy;
    getCountry();
  }

  @override
  void update(double dt) {
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
    game.flagsRip.selected = -1;
    game.flagsRip.updateFlag();
    game.flags.selected = -1;
    game.flags.updateFlag();
    game.vs.updateVersus();
    game.currentCountry = code;
  }

  Rect area() {
    return Rect.fromLTWH(x - width, y, width, height);
  }
}
