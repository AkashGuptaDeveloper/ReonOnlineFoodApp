import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_mac/get_mac.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:device_info/device_info.dart';
import 'package:device_id/device_id.dart';
import 'dart:io' show Platform;
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:reonapp/GlobalComponents/GlobalAppColor/GlobalAppColor.dart';
import 'package:reonapp/GlobalComponents/GlobalFlag/GlobalFlag.dart';
import 'package:reonapp/GlobalComponents/GlobalImageAssets/GlobalImageAssets.dart';
import 'package:reonapp/GlobalComponents/GlobalNavigationRoute/GlobalNavigationRoute.dart';
import 'package:reonapp/GlobalComponents/GlobalServiceURL/GlobalServiceURL.dart';
import 'package:reonapp/HomeScreen/HomeScreen.dart';

//------------------------------------START-----------------------------------//
class SplashScreen extends StatefulWidget {
  static String tag = GlobalNavigationRoute.TagSplashScreen.toString();
  @override
  SplashScreenState createState() => new SplashScreenState();
}

//-----------------------------------SplashScreenState------------------------//
class SplashScreenState extends State<SplashScreen> {
  ProgressDialog pr;
  /*final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();*/
  // ignore: non_constant_identifier_names
  var ReciveToken;
  // ignore: non_constant_identifier_names
  String DeviceRegisterURL_ServiceUrl =
      GlobalServiceURL.DeviceRegisterURL.toString();
  String errMessage = GlobalFlag.ErrorSendData;
  String status = '';
  String _platformVersion = 'Unknown';
// ignore: non_constant_identifier_names
  var LocalTime;
  // ignore: non_constant_identifier_names
  var Device_Name;
  // ignore: non_constant_identifier_names
  var Os_Version;
  // ignore: non_constant_identifier_names
  var mac_adress;
  // ignore: non_constant_identifier_names
  var Device_id;
//-----------------------------------handleTimeout----------------------------//
  void handleTimeout() async {
    Navigator.of(context).push(new MaterialPageRoute(builder: (_) => new HomeView()));
  }
//-----------------------------------startTimeout-----------------------------//
  startTimeout() async {
    var duration = const Duration(seconds: 4);
    return new Timer(duration, handleTimeout);
  }

//-----------------------------------initState--------------------------------//
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

//-----------------------------------_getLocalTime----------------------------//
  void _getLocalTime() {
    var date = DateTime.now();
    LocalTime = DateFormat('HH:mm:ss').format(date).trim();
    /*  print("LocalTime  "+LocalTime);*/
  }

//-----------------------------------OperatingSystem----------------------------//
  // ignore: non_constant_identifier_names
  void OperatingSystem() {
    // Get the operating system as a string.
    String os = Platform.operatingSystem;
    // Or, use a predicate getter.
    if (Platform.isIOS) {
      Os_Version = os;
      /*print("Os_Version  "+os);*/
    } else if (Platform.isAndroid) {
      Os_Version = os;
      /*print("Os_Version  "+os);*/
    } else {}
  }

//-----------------------------------initPlatformState-------------------------//
// Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await GetMac.macAddress;
    } on PlatformException {
      platformVersion = 'Failed to get Device MAC Address.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
      mac_adress = _platformVersion;
      print("Macaddress  " + mac_adress);
    });
    startTimeout();
    /* _getToken();*/
    _getDeviceId();
    getDeviceDetails();
    OperatingSystem();
    _getLocalTime();
  }

//-----------------------------------_getDeviceId------------------------------//
  // ignore: missing_return
  Future<String> _getDeviceId() async {
    String deviceid = await DeviceId.getID;
    Device_id = deviceid;
    print("deviceid  " + deviceid);
  }

//------------------------------------getDeviceDetails------------------------//
  Future<List<String>> getDeviceDetails() async {
    String deviceName;
    String deviceVersion;
    String identifier;
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceName = build.model;
        deviceVersion = build.version.toString();
        identifier = build.androidId; //UUID for Android

        Device_Name = deviceName;
        print("Device_Name  " + Device_Name);
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceName = data.name;
        deviceVersion = data.systemVersion;
        identifier = data.identifierForVendor; //UUID for iOS
      }
    } on PlatformException {
      print('Failed to get platform version');
    }

//if (!mounted) return;
    return [deviceName, deviceVersion, identifier];
  }

//-----------------------------------_getToken--------------------------------//
  /*_getToken() {
    _firebaseMessaging.getToken().then((token) {
      ReciveToken = token;
      _SendDataFromServer();
    });
  }*/
//-----------------------------------_SendDataFromServer----------------------//
  // ignore: non_constant_identifier_names
  Future<void> _SendDataFromServer() async {
    await Future.delayed(Duration(seconds: 10));
    SendDeviceRegisterPost();
  }

//-----------------------------------------dispose()--------------------------//
  @override
  void dispose() {
    super.dispose();
    startTimeout();
  }

//------------------------------------Widget build----------------------------//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: new Form(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                FormLogo(),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: GlobalAppColor.AppBarColorCode,
    );
  }

//-----------------------------------------------------FormLogo---------------//
  // ignore: non_constant_identifier_names
  Widget FormLogo() {
    return new Column(
      children: <Widget>[
        new Container(
          child: new Container(
            child: Image.asset(GlobalImageAssets.AppLogo, fit: BoxFit.contain),
          ),
        ),
      ],
    );
  }

//-------------------------------CouponFormPost--------------------------------//
  // ignore: non_constant_identifier_names
  Future<void> SendDeviceRegisterPost() async {
    setState(() {
      // ignore: unnecessary_statements
      ReciveToken;
      // ignore: unnecessary_statements
      LocalTime;
      // ignore: unnecessary_statements
      Device_Name;
      // ignore: unnecessary_statements
      Os_Version;
      // ignore: unnecessary_statements
      mac_adress;
      // ignore: unnecessary_statements
      Device_id;
    });
    try {
      http.post(DeviceRegisterURL_ServiceUrl, body: {
        "device_name": Device_Name.toString(),
        "os_version": Os_Version.toString(),
        "mac_adress": mac_adress.toString(),
        "device_id": Device_id.toString(),
        "local_time": LocalTime.toString(),
        "user_id": "0".toString(),
        "fcm_token_id": ReciveToken.toString(),
      }).then((resultSignup) {
        setStatus(
            resultSignup.statusCode == 200 ? resultSignup.body : errMessage);
        //print(GlobalFlag.Printjsonresp.toString()+"${resultSignup.body.toString()}");
        /*print("device_name"+Device_Name.toString(),);
        print("os_version"+Os_Version.toString(),);
        print("mac_adress"+mac_adress.toString(),);
        print("device_id"+Device_id.toString(),);
        print("local_time"+LocalTime.toString(),);
        print("user_id"+"0".toString(),);
        print("fcm_token_id"+ReciveToken.toString(),);*/
      }).catchError((error) {
        setStatus(error);
      });
    } catch (e) {
      /* JsonStatusFalseAlert();*/
    }
  }

//-----------------------------setStatus--------------------------------------//
  setStatus(String message) {
    setState(() {
      status = message;
    });
  }
}
//---------------------------------------END----------------------------------//
