import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
// import 'package:flame/components/component.dart';

import 'helper.dart';
import 'fb_img.dart';
import 'score.dart';
import 'wood_img.dart';
import 'pointer.dart';
import 'shadow.dart';
import 'self_flag.dart';
import 'flags.dart';
import '../box2d/football.dart';
import '../box2d/balancer.dart';
import '../box2d/box2d_world.dart';
import 'db_helper.dart';

import 'dart:async' as time;

import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/components/parallax_component.dart';

enum Status {
  PendingCountry,
  Playing,
  Win,
  Lost,
}

class BallGame extends BaseGame with PanDetector, HasWidgetsOverlay {
  Size screenSize;
  double tileSizeX;

  Offset initialDrag = Offset.zero;
  Offset currentDrag = Offset.zero;
  Offset initialBalOffset;
  double xCenterLeft;
  double xCenterRight;
  bool dragEnd = true;

  double speedo = 4.5;
  double unitWidth;

  BasicWorld basicWorld;
  Football baller;
  Balancer balance;

  Status status;
  List<String> countryList;

  int score;
  Pointer pointer;
  SelfFlag selfFlag;
  Flags flags;
  static const oneSec = Duration(seconds: 1);

  BallGame(size) {
    resize(size);
    initialize();
  }

  void initialize() {
    status = Status.Playing;
    // countryList.shuffle();
    score = 0;

    final images = [
      ParallaxImage("CartoonClouds.jpg",
          repeat: ImageRepeat.repeat, fill: LayerFill.height),
    ];
    add(ParallaxComponent(images, baseSpeed: Offset(0, 0)));

    unitWidth = (screenSize.width - (6 * 5)) / 6;

    countryList = countryCodes();
    add(flags = Flags(this,
        screenSize.height * 0.104,
        screenSize.height * 0.064,
        Offset(screenSize.width * 0.96, screenSize.height * 0.018)));
    add(selfFlag = SelfFlag(
        this,
        screenSize.height * 0.104,
        screenSize.height * 0.064,
        Offset(screenSize.width * 0.96, screenSize.height * 0.94)));

    add(Score(this, 'Goals: 0', Offset(10, 15)));
    basicWorld = BasicWorld(this, screenSize);
    basicWorld.initializeWorld();
    add(basicWorld);
    add(balance = basicWorld.balance);
    add(baller = basicWorld.baller);
    add(basicWorld.outline);

    initialBalOffset = balance.bodyPos;

    add(FbImg(
      this,
      tileSizeX * 2 / 2,
      tileSizeX * 2 / 2,
      vecToOffset(baller.body.position),
    ));

    add(WoodImg(
      this,
      (tileSizeX * 9) - 10,
      10,
      vecToOffset(balance.body.position),
    ));

    add(basicWorld.goalpost.net);
    add(basicWorld.goalpost);
    add(Plshadow(this, screenSize.width * 0.5, 5,
        Offset(screenSize.width / 2, (screenSize.height * 0.93))));
    add(pointer = Pointer(this, tileSizeX, tileSizeX,
        Offset(screenSize.width / 2, screenSize.height * 0.9)));
  }

  void resize(Size size) {
    screenSize = size;
    tileSizeX = screenSize.width / 9;
    xCenterLeft = tileSizeX * 4;
    xCenterRight = tileSizeX * 5;
    super.resize(size);
  }

  @override
  void onPanEnd(DragEndDetails details) {
    dragEnd = true;
  }

  void onPanStart(DragStartDetails details) {
    // print('hai'); - didnt work as expected after removing TapDetector
    dragEnd = false;
    initialBalOffset = balance.bodyPos;
    initialDrag = details.globalPosition;
    currentDrag = details.globalPosition;
    if ((status == Status.PendingCountry ||
            (status == Status.Playing && score == 0)) &&
        selfFlag.area().contains(details.globalPosition)) {
      status = Status.PendingCountry;
      addWidgetOverlay('dropdown', dropdown());
    }
  }

  void onPanUpdate(DragUpdateDetails details) {
    currentDrag = details.globalPosition;
  }

  void onPanDown(DragDownDetails details) {
    dragEnd = false;
    initialBalOffset = balance.bodyPos;
    initialDrag = details.globalPosition;
    currentDrag = details.globalPosition;
    if ((status == Status.PendingCountry ||
            (status == Status.Playing && score == 0)) &&
        selfFlag.area().contains(details.globalPosition)) {
      status = Status.PendingCountry;
      addWidgetOverlay('dropdown', dropdown());
    }
    // print('down'); - too bottom & right dont detect very good
  }

  Widget dropdown() {
    return Center(
      child: Card(
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.circular(5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButton<String>(
                      isDense: true,
                      hint: Text("Select Country"),
                      // value: selfFlag.selected,
                      value: null,
                      onChanged: (String newValue) {
                        selfFlag.setFlag(newValue);
                        removeWidgetOverlay('dropdown');
                      },
                      items: myJson().map((Map map) {
                        return new DropdownMenuItem<String>(
                          value: map["id"].toString(),
                          child: Row(
                            children: <Widget>[
                              Image.asset(
                                map["image"],
                                width: 25,
                              ),
                              Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text(map["name"])),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
