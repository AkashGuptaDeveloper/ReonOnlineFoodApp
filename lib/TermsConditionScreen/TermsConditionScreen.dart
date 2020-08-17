import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:reonapp/Animation/FadeAnimation.dart';
import 'package:reonapp/Drawer/HomeDrawer.dart';
import 'package:reonapp/GlobalComponents/GlobalAppColor/GlobalAppColor.dart';
import 'package:reonapp/GlobalComponents/GlobalFlag/GlobalFlag.dart';
import 'package:reonapp/GlobalComponents/GlobalNavigationRoute/GlobalNavigationRoute.dart';
import 'package:reonapp/GlobalComponents/GlobalServiceURL/GlobalServiceURL.dart';
//---------------------------------START--------------------------------------//
class TermsConditionScreen extends StatefulWidget {
  static String tag = GlobalNavigationRoute.TagTermsConditionScreen.toString();
  @override
  TermsConditionScreenState createState() => new TermsConditionScreenState();
}
//------------------------------HomeScreenState-------------------------------//
class TermsConditionScreenState extends State<TermsConditionScreen> {
//----------------------------------------ServiceUrl--------------------------//
  // ignore: non_constant_identifier_names
  String TermConditionsUrl_ServiceUrl=GlobalServiceURL.TermConditionsUrl.toString();
//----------------------------------------Global-Variable----------------------//
  String errMessage = GlobalFlag.ErrorSendData;
  String status = '';
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  ProgressDialog pr;
  // ignore: non_constant_identifier_names
  var ReciveJsonData;
//---------------------------_checkInternetConnectivity-----------------------//
  void _checkInternetConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      _showDialog(GlobalFlag.NoInternet, GlobalFlag.InternetNotConnected);
    }else{
      pr.show();
    }
  }
//-------------------------initState()----------------------------------------//
  @override
  void initState() {
    this._checkInternetConnectivity();
    this.FetchTermsConditionScreenFromServer();
    super.initState();
  }
//------------------------------dispose()-------------------------------------//
  @override
  void dispose() {
    super.dispose();
  }
//---------------------------------Widget build-------------------------------//
  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context);
    pr.style(message: GlobalFlag.PleaseWait.toString(),);
//-----------------------------------WillPopScope-----------------------------//
    return  Scaffold(
        drawer: _drawer(),
        key: _globalKey,
        appBar: new AppBar(
          backgroundColor: GlobalAppColor.AppBarColorCode,
          iconTheme: new IconThemeData(color: GlobalAppColor.AppIcon),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(GlobalFlag.ReonTechnologies.toString().toUpperCase(),textAlign: TextAlign.center, style: TextStyle(fontFamily: GlobalFlag.FontCode, fontSize: 16, color: GlobalAppColor.AppIcon, fontWeight: FontWeight.w500,),),
              SizedBox(height: 5.0,),
              Text(GlobalFlag.DigitalMarketingCompany.toString().toUpperCase(),textAlign: TextAlign.center, style: TextStyle(fontFamily: GlobalFlag.FontCode, fontSize: 12, color: GlobalAppColor.AppIcon, fontWeight: FontWeight.w300,),),
            ],
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
//--------------------------------------body----------------------------------//
        body:new FadeAnimation (
          2, new Container(
          padding: const EdgeInsets.all(5.0),
          child:ListView(
            children: <Widget>[
              Html(
                  data: ReciveJsonData==null?"Please wait":ReciveJsonData.toString()
              ),
            ],
          ),
        ),
        ),
      );
  }
//-----------------------AlertDialog------------------------------------------//
  Future<void> _showDialog(title, text) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(GlobalFlag.InternetWarning, textAlign: TextAlign.center, style: new TextStyle(fontSize: 15.0, color: GlobalAppColor.AppIcon, fontWeight: FontWeight.bold),),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(title.toString(), textAlign: TextAlign.center, style: new TextStyle(fontSize: 12.0, color: GlobalAppColor.AppIcon, fontWeight: FontWeight.bold),),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                _dismissDialog(context);
                Navigator.of(context);
              },
              child: Text(GlobalFlag.Ok, style: new TextStyle(fontSize: 15.0, color: GlobalAppColor.AppIcon, fontWeight: FontWeight.bold),),
            ),
          ],
        );
      },
    );
  }
//-------------------------------_dismissDialog-------------------------------//
  _dismissDialog(BuildContext context) {
    Navigator.pop(context);
  }
//---------------------------Widget _drawer-----------------------------------//
  Widget _drawer() {
    return new Drawer(
      elevation: 20.0,
      child: HomeDrawer(),
    );
  }
//-----------------------------setStatus--------------------------------------//
  setStatus(String message) {
    setState(() {
      status = message;
    });
  }
//----------------------------------FetchTermsConditionScreenFromServer-------//
  // ignore: non_constant_identifier_names
  Future<void> FetchTermsConditionScreenFromServer() async {
    // ignore: non_constant_identifier_names
    try{
      http.post(TermConditionsUrl_ServiceUrl.toString(), body: {
        // ignore: non_constant_identifier_names
      }).then((resultHomeList) {
        setStatus(resultHomeList.statusCode == 200 ? resultHomeList.body : errMessage);
        // ignore: non_constant_identifier_names
        ReciveJsonData = resultHomeList.body;
       /* print(GlobalFlag.Printjsonresp.toString()+"${resultHomeList.body.toString()}");*/
        pr.hide();
      }).catchError((error) {
        setStatus(error);
      });
    }catch(e){
    }
  }
}
//----------------------------------END---------------------------------------//