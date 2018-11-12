import 'package:flutter/material.dart';

final verticalPaddingPortrait = 10.0;
final horizontalPaddingPortrait = 16.0;
final verticalPaddingLand = 20.0;
final horizontalPaddingLand = 8.0;

Widget buildHeader(BuildContext context, String title) {
  var screenHeight = MediaQuery.of(context).size.height;
  return MediaQuery.of(context).orientation == Orientation.portrait
      ? Padding(
    padding: EdgeInsets.only(
      top: verticalPaddingPortrait,
      bottom: 35.0,
      left: horizontalPaddingPortrait,
      right: horizontalPaddingPortrait,
    ),
    child: Container(
      height: screenHeight * 0.15,
      alignment: Alignment.center,
      child: Image.asset(
        'im/logo.png',  // im folder must be created and set in pubspec.yaml
        fit: BoxFit.contain,
      ),
    ),
  )
      : Container();
}
