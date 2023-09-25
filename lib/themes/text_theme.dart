import 'package:flutter/material.dart';
import 'package:solid_software_test_app/themes/color_theme.dart';

abstract class Fonts {
  static const main_text = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w600,
    color: ColorTheme.gray,
  );
  static const appBar = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w600,
    color: ColorTheme.dark_orange,
  );
  static const button =  TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w600,
    color: ColorTheme.white,
  );
  static const text = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    color: ColorTheme.white,
  );
  static const bonus_buttons = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: ColorTheme.white,
  );



}