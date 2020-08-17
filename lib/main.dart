//--------------------------Import-Library------------------------------------//
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reonapp/GlobalComponents/GlobalAppColor/GlobalAppColor.dart';
import 'package:reonapp/routes.dart';

//---------------------------Create-mainMethod--------------------------------//
void main() => runApp(new MyApp());
Map<int, Color> color = {
  50: Color.fromRGBO(255, 255, 255, .1),
  100: Color.fromRGBO(255, 255, 255, .2),
  200: Color.fromRGBO(255, 255, 255, .3),
  300: Color.fromRGBO(255, 255, 255, .4),
  400: Color.fromRGBO(255, 255, 255, .5),
  500: Color.fromRGBO(255, 255, 255, .6),
  600: Color.fromRGBO(255, 255, 255, .7),
  700: Color.fromRGBO(255, 255, 255, .8),
  800: Color.fromRGBO(255, 255, 255, .9),
  900: Color.fromRGBO(255, 255, 255, 10),
};

//---------------------------------StatelessWidget----------------------------//
class MyApp extends StatelessWidget {
//----------------------------Genrated-Widget build---------------------------//
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: GlobalAppColor.AppBarColorCode));
    MaterialColor colorCustom = MaterialColor(0xFFFFFFFF, color);
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: colorCustom,
      ),
      debugShowCheckedModeBanner: false,
      routes: routes,
    );
  }
}
//---------------------------END-----------------------------------------------//
