import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:reonapp/GlobalComponents/GlobalAppColor/GlobalAppColor.dart';
import 'package:reonapp/GlobalComponents/GlobalFlag/GlobalFlag.dart';
import 'package:reonapp/GlobalComponents/GlobalNavigationRoute/GlobalNavigationRoute.dart';
import 'package:reonapp/HomeScreen/HomeScreen.dart';
import 'package:reonapp/PrivacyPolicy/PrivacyPolicy.dart';
import 'package:reonapp/TermsConditionScreen/TermsConditionScreen.dart';
//-----------------------------------------NavigationDrawer--------------------//
class HomeDrawer extends StatefulWidget {
  static String tag = GlobalNavigationRoute.TagDrawer.toString();
  @override
  HomeDrawerState createState() => new HomeDrawerState();
}
//-----------------------------------------NavigationDrawerState--------------//
class HomeDrawerState extends State<HomeDrawer> {
  // ignore: non_constant_identifier_names
  int ChangeColor;
  // ignore: non_constant_identifier_names
  String status = '';
  ProgressDialog pr;
//-----------------------------------------initState()-------------------------//
  @override
  void initState() {
    super.initState();
  }
//-----------------------------------------Widget------------------------------//
  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context);
    pr.style(message: GlobalFlag.PleaseWait.toString(),);
    return Scaffold(
      body: Center(
        child:new Drawer(
            elevation: 20.0,
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [GlobalAppColor.DrawerText, GlobalAppColor.DrawerText])
                  ),
                  child: Container(
                    height: 70,
                    padding: new EdgeInsets.only(top:20.0),
                    child: ListTile(
                      title: Text(
                          GlobalFlag.ReonTechnologies.toString().toUpperCase(),textAlign: TextAlign.center, style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                        letterSpacing: 1.4,
                        backgroundColor: Colors.transparent,
                        fontWeight: FontWeight.bold,
                        fontFamily: GlobalFlag.FontCode.toString(),),),
                    ),
                  ),
                ),
//-------------------------------------Home-----------------------------------//
                Container(
                  color: ChangeColor == 1 ? GlobalAppColor.DrawerText : GlobalAppColor.AppBarColorCode,
                  child: ListTile(
                    title: Row(
                      children: <Widget>[
                        Icon(FontAwesomeIcons.home, size: 20, color: ChangeColor == 1 ?  GlobalAppColor.AppBarColorCode : GlobalAppColor.DrawerText,),
                        SizedBox(width: 15,),
                        Text(GlobalFlag.HomeScreen.toUpperCase().toString(), style: TextStyle(fontFamily: GlobalFlag.FontCode.toString(), fontSize: 14, color: ChangeColor == 1 ?  GlobalAppColor.AppBarColorCode : GlobalAppColor.DrawerText, fontWeight: FontWeight.bold,),),
                      ],
                    ),
                    onTap: () {
                      ChnageTapColorHome();
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(HomeView.tag);
                    },
                  ),
                ),
                Divider(
                  height: 1, thickness: 0.2, color:GlobalAppColor.AppIcon,),
//-------------------------------------Products-------------------------------//
                Container(
                  color: ChangeColor == 2 ? GlobalAppColor.DrawerText : GlobalAppColor.AppBarColorCode,
                  child: ListTile(
                    title: Row(
                      children: <Widget>[
                        Icon(FontAwesomeIcons.productHunt, size: 20, color: ChangeColor == 2 ?  GlobalAppColor.AppBarColorCode : GlobalAppColor.DrawerText,),
                        SizedBox(width: 15,),
                        Text(GlobalFlag.Products.toUpperCase().toString(), style: TextStyle(fontFamily: GlobalFlag.FontCode.toString(), fontSize: 14, color: ChangeColor == 2 ?  GlobalAppColor.AppBarColorCode : GlobalAppColor.DrawerText, fontWeight: FontWeight.bold,),),
                      ],
                    ),
                    onTap: () {
                      ChnageTapColorProducts();
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(HomeView.tag);
                    },
                  ),
                ),
                Divider(
                  height: 1, thickness: 0.2, color:GlobalAppColor.AppIcon,),
//-------------------------------------Notifications--------------------------//
                Container(
                  color: ChangeColor == 3 ? GlobalAppColor.DrawerText : GlobalAppColor.AppBarColorCode,
                  child: ListTile(
                    title: Row(
                      children: <Widget>[
                        Icon(FontAwesomeIcons.bell, size: 20, color: ChangeColor == 3 ?  GlobalAppColor.AppBarColorCode : GlobalAppColor.DrawerText,),
                        SizedBox(width: 15,),
                        Text(GlobalFlag.Notifications.toUpperCase().toString(), style: TextStyle(fontFamily: GlobalFlag.FontCode.toString(), fontSize: 14, color: ChangeColor == 3 ?  GlobalAppColor.AppBarColorCode : GlobalAppColor.DrawerText, fontWeight: FontWeight.bold,),),
                      ],
                    ),
                    onTap: () {
                      ChnageTapColorNotifications();
                      Navigator.of(context).pop();
                      /*Navigator.of(context).pushNamed(MessageView.tag);*/
                    },
                  ),
                ),
                Divider(
                  height: 1, thickness: 0.2, color:GlobalAppColor.AppIcon,),
//-------------------------------------Terms/Conditions-----------------------//
                Container(
                  color: ChangeColor == 4 ? GlobalAppColor.DrawerText : GlobalAppColor.AppBarColorCode,
                  child: ListTile(
                    title: Row(
                      children: <Widget>[
                        Icon(FontAwesomeIcons.info, size: 20, color: ChangeColor == 4 ?  GlobalAppColor.AppBarColorCode : GlobalAppColor.DrawerText,),
                        SizedBox(width: 15,),
                        Text(GlobalFlag.TermsConditions.toUpperCase().toString(), style: TextStyle(fontFamily: GlobalFlag.FontCode.toString(), fontSize: 14, color: ChangeColor == 4 ?  GlobalAppColor.AppBarColorCode : GlobalAppColor.DrawerText, fontWeight: FontWeight.bold,),),
                      ],
                    ),
                    onTap: () {
                      ChnageTapColorTermsConditions();
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(TermsConditionScreen.tag);
                    },
                  ),
                ),
                Divider(
                  height: 1, thickness: 0.2, color:GlobalAppColor.AppIcon,),
//-------------------------------------PrivacyPolicy-----------------------//
                Container(
                  color: ChangeColor == 5 ? GlobalAppColor.DrawerText : GlobalAppColor.AppBarColorCode,
                  child: ListTile(
                    title: Row(
                      children: <Widget>[
                        Icon(FontAwesomeIcons.eye, size: 20, color: ChangeColor == 5 ?  GlobalAppColor.AppBarColorCode : GlobalAppColor.DrawerText,),
                        SizedBox(width: 15,),
                        Text(GlobalFlag.PrivacyPolicy.toUpperCase().toString(), style: TextStyle(fontFamily: GlobalFlag.FontCode.toString(), fontSize: 14, color: ChangeColor == 5 ?  GlobalAppColor.AppBarColorCode : GlobalAppColor.DrawerText, fontWeight: FontWeight.bold,),),
                      ],
                    ),
                    onTap: () {
                      ChnageTapColorPrivacyPolicy();
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(PrivacyPolicy.tag);
                    },
                  ),
                ),
                Divider(
                  height: 1, thickness: 0.2, color:GlobalAppColor.AppIcon,),
              ],
            )),
      ),
    );
  }
//--------------------Navigation-Color-Change---------------------------------//
  // ignore: non_constant_identifier_names
  void ChnageTapColorHome() {
    setState(() {
      ChangeColor = 1;
    });
  }
// ignore: non_constant_identifier_names
  void ChnageTapColorProducts() {
    setState(() {
      ChangeColor = 2;
    });
  }
// ignore: non_constant_identifier_names
  void ChnageTapColorNotifications() {
    setState(() {
      ChangeColor = 3;
    });
  }
  // ignore: non_constant_identifier_names
  void ChnageTapColorTermsConditions() {
    setState(() {
      ChangeColor = 4;
    });
  }
  // ignore: non_constant_identifier_names
  void ChnageTapColorPrivacyPolicy() {
    setState(() {
      ChangeColor = 5;
    });
  }
//------------------------------END-------------------------------------------//
}