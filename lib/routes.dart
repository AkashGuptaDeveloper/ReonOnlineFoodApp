//--------------------------Import-Library------------------------------------//
//------------------------------Declared-routes-------------------------------//
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:reonapp/HomeScreen/HomeScreen.dart';
import 'package:reonapp/SplashScreen/SplashScreen.dart';
import 'package:reonapp/SubCategory/SubCategory.dart';
import 'package:reonapp/PrivacyPolicy/PrivacyPolicy.dart';
import 'package:reonapp/TermsConditionScreen/TermsConditionScreen.dart';
final routes = {
  '/Splash': (BuildContext context) => new SplashScreen(),
  '/': (BuildContext context) => new SplashScreen(),
  SplashScreen.tag: (context) => SplashScreen(),
  HomeView.tag: (context) => HomeView(),
  SubCategory.tag: (context) => SubCategory(),
  TermsConditionScreen.tag: (context) => TermsConditionScreen(),
  PrivacyPolicy.tag: (context) => PrivacyPolicy(),
  /* MessageView.tag: (context) => MessageView(),*/
};
//-------------------------------END------------------------------------------//