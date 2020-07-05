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
import 'cd_timer.dart';
import 'world_cup.dart';
import 'cover.dart';
import 'start_score.dart';
import 'arrow.dart';
import 'pause_button.dart';
import 'pick_country.dart';
import 'background_worldcup.dart';
import 'pause_cover.dart';
import 'play_button.dart';
import 'resume_word.dart';
import 'versus.dart';
import 'flags_ripple.dart';
import 'world_cup_ripple.dart';
import 'cd_timer_show.dart';
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
  Pause,
  Lost,
  Win,
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
  CdTimer countDown;
  Cover cover;
  bool overlayShown = false;
  PauseButton pause;
  BackgroundWorldcup backWorld;
  PlayButton playButton;
  Versus vs;
  FlagsRipple flagsRip;

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
    add(countDown = CdTimer(
        this,
        screenSize.height * 0.03,
        screenSize.height * 0.05,
        Offset(screenSize.width * 0.5, screenSize.height * 0.1)));
    add(flags = Flags(
        this,
        screenSize.width * 0.23,
        screenSize.width * 0.14,
        Offset((screenSize.width * 0.56) + (countDown.width / 2),
            screenSize.height * 0.018)));
    add(flagsRip = FlagsRipple(
        this,
        screenSize.width * 0.23,
        screenSize.width * 0.14,
        Offset((screenSize.width * (0.56 + 0.115)) + (countDown.width / 2),
            (screenSize.height * 0.018) + (screenSize.width * 0.07))));
    add(selfFlag = SelfFlag(
        this,
        screenSize.width * 0.23,
        screenSize.width * 0.14,
        Offset(screenSize.width * 0.95, screenSize.height * 0.87)));
    add(CdTimerShow(this,
        screenSize.height * 0.09,
        screenSize.height * 0.15,
        Offset(screenSize.width * 0.5, screenSize.height * 0.3)));
    add(backWorld = BackgroundWorldcup(
        this,
        screenSize.height * 0.2,
        screenSize.height * 0,
        Offset(screenSize.width / 2, screenSize.height * 0.8)));
    add(PickCountry(this, screenSize.width * 0.34, screenSize.width * 0.2,
        Offset(screenSize.width * 0.95, screenSize.height * 0.8)));
    add(Arrow(
        this,
        screenSize.width * 0.08,
        screenSize.width * 0.08,
        Offset(screenSize.width * (0.95 - (0.244 / 2)),
            screenSize.height * 0.858)));
    add(WorldCup(
        this,
        screenSize.width * 0.056,
        screenSize.width * 0.144,
        Offset((screenSize.width * (0.96 - 0.244)) - 20,
            screenSize.height * 0.87)));
    add(WorldCupRipple(
        this,
        screenSize.width * 0.056,
        screenSize.width * 0.144,
        Offset((screenSize.width * (0.96 - 0.244 - 0.028)) - 20,
            (screenSize.height * 0.87) + (screenSize.width * 0.144 / 2))));
    add(cover = Cover(
        this,
        screenSize.width * 0.056,
        screenSize.width * 0.144,
        Offset((screenSize.width * (0.96 - 0.244)) - 20,
            (screenSize.height * 0.87))));
    add(pause = PauseButton(
        this,
        screenSize.height * 0.06,
        screenSize.height * 0.06,
        Offset(screenSize.width - 6, screenSize.height * 0.018)));
    add(Score(this, 'Goals: 0', Offset(10, 15)));
    add(vs = Versus(this, Offset(10, (screenSize.height * 0.45) - 5)));

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
    add(StartScore(this, screenSize.width / 2, screenSize.width / 5,
        Offset(screenSize.width / 2, screenSize.height * 0.32)));
    add(PauseCover(this, screenSize.width, screenSize.height, Offset.zero));
    add(playButton = PlayButton(
        this,
        screenSize.width / 4,
        screenSize.width / 4,
        Offset(screenSize.width / 2, screenSize.height * 0.5)));
    add(ResumeWord(
        this,
        Offset(screenSize.width / 2,
            (screenSize.height * 0.5) + (playButton.height / 2) + 15)));
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
      // status = Status.PendingCountry;
      addWidgetOverlay('dropdown', dropdown());
      overlayShown = true;
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
      // status = Status.PendingCountry;
      addWidgetOverlay('dropdown', dropdown());
      overlayShown = true;
    }
    if (status == Status.Playing &&
        score > 0 &&
        countDown.remainingTime > 0 &&
        pause.area().contains(details.globalPosition)) {
      pauseGame();
    }
    if (status == Status.Pause &&
        playButton.area().contains(details.globalPosition)) {
      resumeGame();
    }
    // print('down'); - too bottom & right dont detect very good
  }

  void pauseGame() {
    countDown.stopTimer();
    basicWorld.pause();
    status = Status.Pause;
  }

  void resumeGame() {
    countDown.resume();
    basicWorld.resume();
    status = Status.Playing;
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
                        overlayShown = false;
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
