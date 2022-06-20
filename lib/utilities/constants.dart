import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Ruler - water.dart

const kRulerColor = 0xffA9A9A9;
const kRulerColorOpacity = 0.2;
const kRulerMarginOnlyTop = 8.0;
// const kRulerHeight = 3.0;
double kRulerHeight(context) {
  return 0.003 * MediaQuery.of(context).size.height;
}

// const kRulerLongWidth = 30.0;
double kRulerLongWidth(context) {
  return 0.06 * MediaQuery.of(context).size.width;
}

// const kRulerShortWidth = 20.0;
double kRulerShortWidth(context) {
  return 0.04 * MediaQuery.of(context).size.width;
}
//Color

const kBlueColor = 0xff6BAFEE;
const kWaveLightBlueColor = 0xffe1effc;
const kWaveDeepBlueColor = 0XFFb3d7f6;
const kDeepGreyColor = 0xff424242;
const kGreyColor = 0xff797979;
const kSettingsScreenBackgroundColor = 0xffcbe4f9;
const kDailyRecordsBackgroundColor = 0xffcbe4f9;

//Screen body textstyle
TextStyle kBodyTitle(context) {
  return GoogleFonts.frankRuhlLibre(
      textStyle: TextStyle(
    fontSize: 0.045 * MediaQuery.of(context).size.width,
    fontWeight: FontWeight.w400,
    color: Color(kDeepGreyColor),
  ));
}

TextStyle kBodyText(context) {
  return GoogleFonts.frankRuhlLibre(
      textStyle: TextStyle(
    fontSize: 0.038 * MediaQuery.of(context).size.width,
    fontWeight: FontWeight.w400,
    color: Color(kGreyColor),
  ));
}

//screentitletextstyle

TextStyle kScreenTitle(context) {
  return GoogleFonts.frankRuhlLibre(
      textStyle: TextStyle(
    fontSize: 0.08 * MediaQuery.of(context).size.width,
    fontWeight: FontWeight.w500,
    color: Color(kDeepGreyColor),
  ));
}

TextStyle kBigNumber(context) {
  return TextStyle(
    fontWeight: FontWeight.w100,
    fontSize: 0.28 * MediaQuery.of(context).size.width,
    color: Color(kDeepGreyColor),
  );
}

TextStyle kBigNumberPercentage(context) {
  return TextStyle(
    fontWeight: FontWeight.w200,
    fontSize: 0.08 * MediaQuery.of(context).size.width,
    color: Color(kDeepGreyColor),
  );
}

TextStyle kBigNumberSubText(context) {
  return TextStyle(
    fontSize: 0.045 * MediaQuery.of(context).size.width,
    color: Color(kGreyColor),
    fontWeight: FontWeight.w300,
  );
}

//Age list
List<int> ageList = [for (var i = 0; i < 100; i += 1) i];

//IncreaseAmountTile

double kWidthIncreaseAmountTile(context) {
  return 0.23 * MediaQuery.of(context).size.width;
}

double kHeightIncreaseAmountTile(context) {
  return 0.15 * MediaQuery.of(context).size.height;
}

double kHeightIncreaseAmountTileImage(context) {
  return 0.10 * MediaQuery.of(context).size.height;
}

double kPaddingHorizontalIncreaseAmountTile(context) {
  return 0.02 * MediaQuery.of(context).size.width;
}

double kPaddingVerticalIncreaseAmountTile(context) {
  return 0.01 * MediaQuery.of(context).size.height;
}

double kIncreaseAmountTileTextSize(context) {
  return 0.035 * MediaQuery.of(context).size.width;
}

//floating button
double kWidthFloatingButtonAdd(context) {
  return 0.28 * MediaQuery.of(context).size.width;
}

double kHeightFloatingButtonAdd(context) {
  return 0.15 * MediaQuery.of(context).size.height;
}

double kSizeIconFloatingButtonAdd(context) {
  return 0.15 * MediaQuery.of(context).size.width;
}

double kWidthFloatingButtonRevert(context) {
  return 0.14 * MediaQuery.of(context).size.width;
}

double kHeightFloatingButtonRevert(context) {
  return 0.07 * MediaQuery.of(context).size.height;
}

double kSizeIconFloatingButtonRevert(context) {
  return 0.07 * MediaQuery.of(context).size.width;
}

//my record

Widget bar7Days(context, int amount) {
  return Container(
    height: amount * 0.0008 * MediaQuery.of(context).size.height,
    width: 0.088 * MediaQuery.of(context).size.width,
    color: Color(kBlueColor),
    margin: EdgeInsets.symmetric(
      horizontal: 0.0005 * MediaQuery.of(context).size.width,
    ),
  );
}

Widget bar30Days(context, int amount) {
  return Container(
    height: amount * 0.0008 * MediaQuery.of(context).size.height,
    width: 0.020 * MediaQuery.of(context).size.width,
    color: Color(kBlueColor),
    margin: EdgeInsets.symmetric(
      horizontal: 0.0005 * MediaQuery.of(context).size.width,
    ),
  );
}

Widget bar60Days(context, int amount) {
  return Container(
    height: amount * 0.0008 * MediaQuery.of(context).size.height,
    width: 0.0095 * MediaQuery.of(context).size.width,
    color: Color(kBlueColor),
    margin: EdgeInsets.symmetric(
      horizontal: 0.0005 * MediaQuery.of(context).size.width,
    ),
  );
}

Widget bar90Days(context, int amount) {
  return Container(
    height: amount * 0.0008 * MediaQuery.of(context).size.height,
    width: 0.006 * MediaQuery.of(context).size.width,
    color: Color(kBlueColor),
    margin: EdgeInsets.symmetric(
      horizontal: 0.0005 * MediaQuery.of(context).size.width,
    ),
  );
}
