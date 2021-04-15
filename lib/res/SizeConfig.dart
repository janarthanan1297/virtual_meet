import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SizeConfig {
  static double _screenWidth;
  static double _screenHeight;

  // ignore: non_constant_identifier_names
  static double screenWidth_;
  // ignore: non_constant_identifier_names
  static double screenHeight_;

  static double _blockSizeHorizontal = 0;
  static double _blockSizeVertical = 0;

  static double textMultiplier;
  static double imageSizeMultiplier;
  static double heightMultiplier;
  static bool isPortrait;
  static bool isTab;

  void init(BoxConstraints constraints, Orientation orientation) {
    if (orientation == Orientation.portrait) {
      _screenHeight = constraints.maxHeight;
      _screenWidth = constraints.maxWidth;

      screenHeight_ = constraints.maxHeight;
      screenWidth_ = constraints.maxWidth;

      print("Portrait");
      isPortrait = true;

      // isTab finder
      // if (_screenWidth > 600) {
      //   isTab = true;
      // } else {
      //   isTab = false;
      // }

    } else {
      _screenHeight = constraints.maxWidth;
      _screenWidth = constraints.maxHeight;

      screenHeight_ = constraints.maxHeight;
      screenWidth_ = constraints.maxWidth;

      print("Landscape");
      isPortrait = false;

      // isTab finder    <We will get back to this later>
      // if (_screenWidth > 600) {
      //   isTab = true;
      // } else {
      //   isTab = false;
      // }

    }

    _blockSizeHorizontal = _screenWidth / 100;
    _blockSizeVertical = _screenHeight / 100;

    textMultiplier = _blockSizeVertical;
    imageSizeMultiplier = _blockSizeHorizontal;
    heightMultiplier = _blockSizeVertical;

    print("TextMultiplier..." + textMultiplier.toString());
    print("ImageSizeMultiplier..." + imageSizeMultiplier.toString());
    print("HeightMultiplier..." + heightMultiplier.toString());

    print("SceenHeight..." + _screenHeight.toString());
    print("SceenWidth..." + _screenWidth.toString());
  }
}
