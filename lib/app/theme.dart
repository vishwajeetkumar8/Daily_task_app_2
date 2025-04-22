import 'dart:ui';
import 'package:flutter/material.dart';



class appColor {
  appColor._Color();

  static final appColor instance= appColor._Color();
  factory appColor(){
    return instance;
  }

  bool isDark = false;


  Color get Background => isDark? Color(0xff121212) :Color(0xffF8F9FA);
  Color get Surface => isDark? Color(0xff1E1E1E) :Color(0xffFFFFFF);
  Color get Primary => isDark? Color(0xff7F5AF0) :Color(0xff6C5CE7);
  Color get Secondary => isDark? Color(0xff2CB67D) :Color(0xff00B894);
  Color get Accent => isDark? Color(0xffFF6E6C) :Color(0xffFF7675);
  Color get TextPrimary => isDark? Color(0xffFFFFFF) :Color(0xff2D3436);
  Color get TextDim => isDark? Color(0xffB0B0B0) :Color(0xff636E72);
  Color get Error => isDark? Color(0xffFF5555) :Color(0xffD63031);

   get iconChange => isDark? Icon(Icons.sunny,color: appColor().TextPrimary,): Icon(Icons.brightness_2,color: appColor().TextPrimary,);

  void changeMode(){
    isDark= !isDark;

  }
}