import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:reonapp/Animation/FadeAnimation.dart';
import 'package:reonapp/Drawer/HomeDrawer.dart';
import 'package:reonapp/GlobalComponents/GlobalAppColor/GlobalAppColor.dart';
import 'package:reonapp/GlobalComponents/GlobalFlag/GlobalFlag.dart';
import 'package:reonapp/GlobalComponents/GlobalImageAssets/GlobalImageAssets.dart';
import 'package:reonapp/GlobalComponents/GlobalNavigationRoute/GlobalNavigationRoute.dart';
import 'package:reonapp/GlobalComponents/GlobalServiceURL/GlobalServiceURL.dart';
import 'package:reonapp/Model/HomeListModel/CouponModel/CouponModel.dart';
import 'package:reonapp/Model/HomeListModel/HomeListModel.dart';
import 'package:reonapp/SubCategory/SubCategory.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';

//---------------------------------START--------------------------------------//
class HomeView extends StatefulWidget {
  static String tag = GlobalNavigationRoute.TagHomeView.toString();
  @override
  HomeViewState createState() => new HomeViewState();
}

//------------------------------HomeScreenState-------------------------------//
class HomeViewState extends State<HomeView> {
//----------------------------------------ServiceUrl--------------------------//
  // ignore: non_constant_identifier_names
  String HomeListUrl_ServiceUrl = GlobalServiceURL.HomeUrl.toString();
  // ignore: non_constant_identifier_names
  String read_offersUrl_ServiceUrl = GlobalServiceURL.read_offersUrl.toString();
  // ignore: non_constant_identifier_names
  String CoupnFormUrl_ServiceUrl = GlobalServiceURL.CoupnFormUrl.toString();
//----------------------------------------Global-Variable----------------------//
  String errMessage = GlobalFlag.ErrorSendData;
  String status = '';
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  // ignore: non_constant_identifier_names
  List<HomeListData> _HomeList = [];
  // ignore: non_constant_identifier_names
  List<HomeListData> _SearchList = [];
  // ignore: non_constant_identifier_names
  bool NoListData = false;
  // ignore: non_constant_identifier_names
  bool ShowListData = false;
  // ignore: non_constant_identifier_names
  ProgressDialog pr;
  // ignore: non_constant_identifier_names
  var OfferID;
  // ignore: non_constant_identifier_names
  var Offeroffer_name;
  // ignore: non_constant_identifier_names
  var offer_details;
  // ignore: non_constant_identifier_names
  var message;
  // ignore: non_constant_identifier_names
  var image;
  // ignore: non_constant_identifier_names
  var created_by;
  // ignore: non_constant_identifier_names
  var created_at;
  // ignore: non_constant_identifier_names
  var updated_by;
  // ignore: non_constant_identifier_names
  var updated_at;
  // ignore: non_constant_identifier_names
  var GetImage;
  // ignore: non_constant_identifier_names
  bool OfferImage = false;
  // ignore: non_constant_identifier_names
  TextEditingController controller = new TextEditingController();
  // ignore: non_constant_identifier_names
  List<Data> imgList = List();
  // ignore: non_constant_identifier_names
  bool _validate = false;
  // ignore: non_constant_identifier_names
  GlobalKey<FormState> _Formkey = new GlobalKey();
  // ignore: non_constant_identifier_names
  TextEditingController Namecontroller = new TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController Mobilecontroller = new TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController Emailcontroller = new TextEditingController();
// ignore: non_constant_identifier_names
  final FocusNode myFocusNodeName = FocusNode();
  // ignore: non_constant_identifier_names
  final FocusNode myFocusNodeMobile = FocusNode();
  // ignore: non_constant_identifier_names
  final FocusNode myFocusNodeEmail = FocusNode();
  // ignore: non_constant_identifier_names
  String Name, Email, Mobile;
//---------------------------_checkInternetConnectivity-----------------------//
  void _checkInternetConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      _showDialog(GlobalFlag.NoInternet, GlobalFlag.InternetNotConnected);
    } else {
      pr.show();
    }
  }

//-------------------------initState()----------------------------------------//
  @override
  void initState() {
    this._checkInternetConnectivity();
    FetchHomeListFromServer();
    this.fetchImagePost();
    super.initState();
    GetImage = GlobalServiceURL.ImageURL;
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
    pr.style(
      message: GlobalFlag.PleaseWait.toString(),
    );
//----------------------------------------Image-Slider-coupon------------------//
    // ignore: non_constant_identifier_names
    final Coupon = new Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        new SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    if (imgList.length > 0)
                      CarouselSlider(
                        height: 150.0,
                        initialPage: 0,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        reverse: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        enableInfiniteScroll: false,
                        pauseAutoPlayOnTouch: Duration(seconds: 1),
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (index) {},
                        items: imgList.map((imgUrl) {
                          return Builder(
                            builder: (BuildContext context) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    // ignore: unnecessary_statements
                                    imgUrl.id;
                                    // ignore: unnecessary_statements
                                    imgUrl.offerName;
                                    // ignore: unnecessary_statements
                                    imgUrl.offerDetails;
                                    // ignore: unnecessary_statements
                                    imgUrl.message;
                                    // ignore: unnecessary_statements
                                    imgUrl.image;
                                    // ignore: unnecessary_statements
                                    imgUrl.status;
                                    // ignore: unnecessary_statements
                                    imgUrl.createdBy;
                                    // ignore: unnecessary_statements
                                    imgUrl.createdAt;
                                    // ignore: unnecessary_statements
                                    imgUrl.updatedBy;
                                    // ignore: unnecessary_statements
                                    imgUrl.updatedAt;
                                    var OfferName = imgUrl.offerName;
                                    _openFormView(context, OfferName);
                                  });
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin:
                                      EdgeInsets.symmetric(horizontal:5.0),
                                  decoration: BoxDecoration(
                                      //color: Colors.green,
                                      ),
                                  child: Image.network(
                                    GlobalServiceURL.ImageURL +
                                        '${imgUrl.image}',
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
//-----------------------------------WillPopScope-----------------------------//
    return new WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        drawer: _drawer(),
        key: _globalKey,
        appBar: new AppBar(
          backgroundColor: GlobalAppColor.AppBarColorCode,
          iconTheme: new IconThemeData(color: GlobalAppColor.AppIcon),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                GlobalFlag.ReonTechnologies.toString().toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: GlobalFlag.FontCode,
                  fontSize: 16,
                  color: GlobalAppColor.AppIcon,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                GlobalFlag.DigitalMarketingCompany.toString().toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: GlobalFlag.FontCode,
                  fontSize: 12,
                  color: GlobalAppColor.AppIcon,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          centerTitle: true,
        ),
     backgroundColor: Colors.grey[200],
//--------------------------------------body----------------------------------//
        body: SafeArea(
            child: ListView(children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height /
                1.5, // Also Including Tab-bar height.
            child: Container(
              child: Visibility(
                visible: ShowListData,
                child: new Column(
                  children: <Widget>[
//------------------------------Search-Product--------------------------------//
                    new Container(
                      height: 75,
                      color: Theme.of(context).primaryColor,
                      child: new Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Card(
                          child: new ListTile(
                            leading: new Icon(Icons.search),
                            title: new TextField(
                              textAlign: TextAlign.center,
                              controller: controller,
                              decoration: new InputDecoration(
                                  hintText: 'Search', border: InputBorder.none),
                              onChanged: onSearchTextChanged,
                            ),
                            trailing: new IconButton(
                              icon: new Icon(Icons.cancel),
                              onPressed: () {
                                controller.clear();
                                onSearchTextChanged('');
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
//------------------------------List-Product-----------------------------------//
                    new Expanded(
                      child: _SearchList.length != 0 ||
                              controller.text.isNotEmpty
                          ? new GridView.builder(
                              padding: EdgeInsets.only(
                                  left: 20.0, right: 20.0,),
                              itemCount:
                                  _SearchList == null ? 0 : _SearchList.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1.0,
                              ),
                              itemBuilder: (context, index) {
                                return new GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      // ignore: unnecessary_statements
                                      _SearchList[index].id;
                                      var route = new MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            new SubCategory(
                                          SendUserID:
                                              "${_SearchList[index].id.toString()}",
                                        ),
                                      );
                                      Navigator.of(context).push(route);
                                    });
                                  },
                                  child: Card(
                                      elevation: 5.0,
                                      margin: EdgeInsets.all(5.0),
                                      shape: new RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.circular(
                                          5.0,
                                        ),
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.all(3.0),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    GlobalServiceURL.ImageURL +
                                                        _SearchList[index]
                                                            .image
                                                            .toString(),
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover),
                                                  ),
                                                ),
                                                placeholder: (context, url) =>
                                                    CircularProgressIndicator(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            _SearchList[index].categoryName,
                                            style: TextStyle(
                                                fontFamily: GlobalFlag.FontCode
                                                    .toString(),
                                                color: GlobalAppColor.AppIcon,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            _SearchList[index].updatedAt,
                                            style: TextStyle(
                                                fontFamily: GlobalFlag.FontCode
                                                    .toString(),
                                                color: GlobalAppColor.AppIcon,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                        ],
                                      )),
                                );
                              },
                            )
                          : GridView.builder(
                              padding: EdgeInsets.only(
                                  left: 10.0, right: 10.0,),
                              itemCount:
                                  _HomeList == null ? 0 : _HomeList.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1,
                              ),
                              itemBuilder: (context, index) {
                                return new GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      // ignore: unnecessary_statements
                                      _HomeList[index].id;
                                      var route = new MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            new SubCategory(
                                          SendUserID:
                                              "${_HomeList[index].id.toString()}",
                                        ),
                                      );
                                      Navigator.of(context).push(route);
                                    });
                                  },
                                  child: Card(
                                      elevation: 5.0,
                                      margin: EdgeInsets.all(5.0),
                                      shape: new RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.circular(
                                          5.0,
                                        ),
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.all(3.0),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    GlobalServiceURL.ImageURL +
                                                        _HomeList[index]
                                                            .image
                                                            .toString(),
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover),
                                                  ),
                                                ),
                                                placeholder: (context, url) =>
                                                    CircularProgressIndicator(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            _HomeList[index].categoryName,
                                            style: TextStyle(
                                                fontFamily: GlobalFlag.FontCode
                                                    .toString(),
                                                color: GlobalAppColor.AppIcon,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            _HomeList[index].updatedAt,
                                            style: TextStyle(
                                                fontFamily: GlobalFlag.FontCode
                                                    .toString(),
                                                color: GlobalAppColor.AppIcon,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                        ],
                                      )),
                                );
                              },
                            ),
                    ),
//------------------------------List-Product----------------------------------//
                  ],
                ),
              ),
            ),
          ),
          Container(
            /*height: MediaQuery.of(context).size.height / 0.5,*/
            child: Container(
                color: Colors.white,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Coupon,
                )),
          ),
        ])),
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
          title: Text(
            GlobalFlag.InternetWarning,
            textAlign: TextAlign.center,
            style: new TextStyle(
                fontSize: 15.0,
                color: GlobalAppColor.AppIcon,
                fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  title.toString(),
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                      fontSize: 12.0,
                      color: GlobalAppColor.AppIcon,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                _dismissDialog(context);
                Navigator.of(context);
              },
              child: Text(
                GlobalFlag.Ok,
                style: new TextStyle(
                    fontSize: 15.0,
                    color: GlobalAppColor.AppIcon,
                    fontWeight: FontWeight.bold),
              ),
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

//-----------------------_onBackPressed---------------------------------------//
  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text(
              GlobalFlag.Areyousure,
              style: TextStyle(
                color: GlobalAppColor.AppIcon,
              ),
            ),
            content: new Text(
              GlobalFlag.exitanApp,
              style: TextStyle(
                color: GlobalAppColor.AppIcon,
              ),
            ),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: roundedButton(GlobalFlag.No, const Color(0xFF696969),
                    const Color(0xFFFFFFFF)),
              ),
              new GestureDetector(
                onTap: () => exit(0),
                child: roundedButton(GlobalFlag.Yes, const Color(0xFF696969),
                    const Color(0xFFFFFFFF)),
              ),
            ],
          ),
        ) ??
        false;
  }

//---------------------------------------roundedButton------------------------//
  Widget roundedButton(String buttonLabel, Color bgColor, Color textColor) {
    var loginBtn = new Container(
      padding: EdgeInsets.all(5.0),
      alignment: FractionalOffset.center,
      decoration: new BoxDecoration(
        color: bgColor,
        borderRadius: new BorderRadius.all(const Radius.circular(10.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFFcff1c0),
            offset: Offset(1.0, 6.0),
            blurRadius: 0.001,
          ),
        ],
      ),
      child: Text(
        buttonLabel,
        style: new TextStyle(
            color: textColor, fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    );
    return loginBtn;
  }

//----------------------------------FetchHomeListFromServer-------------------//
  // ignore: non_constant_identifier_names
  Future<void> FetchHomeListFromServer() async {
    // ignore: non_constant_identifier_names
    var ReciveGroupList;
    // ignore: non_constant_identifier_names
    var RecivedStatus;
    try {
      http.post(HomeListUrl_ServiceUrl.toString(), body: {
        // ignore: non_constant_identifier_names
      }).then((resultHomeList) {
        setStatus(resultHomeList.statusCode == 200
            ? resultHomeList.body
            : errMessage);
        // ignore: non_constant_identifier_names
        ReciveGroupList = json.decode(resultHomeList.body);
        //print(GlobalFlag.Printjsonresp.toString()+"${resultHomeList.body.toString()}");
        // ignore: non_constant_identifier_names
        RecivedStatus = ReciveGroupList[GlobalFlag.jsonrespstatus];
        if (RecivedStatus == 200) {
          // ignore: non_constant_identifier_names
          var ExtractData = ReciveGroupList[GlobalFlag.jsondata];
          setState(() {
            for (Map i in ExtractData) {
              _HomeList.add(HomeListData.fromJson(i));
              ShowListData = true;
              NoListData = false;
              OfferImage = true;
              pr.hide();
            }
          });
          pr.hide();
        } else {
          ShowListData = false;
          NoListData = true;
        }
      }).catchError((error) {
        setStatus(error);
      });
    } catch (e) {}
  }

//-----------------------------setStatus--------------------------------------//
  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

//-----------------------------JsonReciveStatusFalseAlert----------------------//
  // ignore: non_constant_identifier_names
  Future<void> JsonReciveStatusFalseAlert() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            GlobalFlag.WarningMessage,
            textAlign: TextAlign.center,
            style: new TextStyle(
              fontSize: 15.0,
              color: GlobalAppColor.AppBarColorCode,
              fontWeight: FontWeight.bold,
              fontFamily: GlobalFlag.FontCode.toString(),
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  GlobalFlag.NoDataAdata.toString(),
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    fontSize: 15.0,
                    color: GlobalAppColor.AppBarColorCode,
                    fontWeight: FontWeight.bold,
                    fontFamily: GlobalFlag.FontCode.toString(),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                pr.hide();
                _dismissDialog(context);
                Navigator.of(context);
              },
              child: Text(
                GlobalFlag.TryAgain,
                style: new TextStyle(
                  fontSize: 15.0,
                  color: GlobalAppColor.AppBarColorCode,
                  fontWeight: FontWeight.bold,
                  fontFamily: GlobalFlag.FontCode.toString(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

//-----------------------------onSearchTextChanged----------------------------//
  // ignore: non_constant_identifier_names
  onSearchTextChanged(String text) async {
    _SearchList.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    // ignore: non_constant_identifier_names
    _HomeList.forEach((_HomeList) {
      if (_HomeList.categoryName.toLowerCase().contains(text) ||
          _HomeList.categoryName.toLowerCase().contains(text))
        _SearchList.add(_HomeList);
    });

    setState(() {});
  }

//------------------------------fetchImagePost--------------------------------//
  fetchImagePost() {
    http.post(read_offersUrl_ServiceUrl, body: {}).then((resultImagePost) {
      setStatus(resultImagePost.statusCode == 200
          ? resultImagePost.body
          : errMessage);
      var dataImagePost = json.decode(resultImagePost.body);
      CouponModel model = CouponModel.fromJson(dataImagePost);
      final extractdata = jsonDecode(resultImagePost.body);
      dataImagePost = extractdata[GlobalFlag.jsonrespstatus];
      setState(() {
        imgList.addAll(model.data);
      });
    }).catchError((error) {
      setStatus(error);
    });
  }

//------------------------------Offer-Form------------------------------------//
  void _openFormView(BuildContext context, OfferName) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      clipBehavior: Clip.hardEdge,
      elevation: 0,
      context: context,
      builder: (BuildContext context) {
        return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
                height: 600,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(GlobalImageAssets.OfferBackground),
                    fit: BoxFit.cover,
                  ),
                ),
                padding: EdgeInsets.all(10),
                child: ListView(
                  children: <Widget>[
//=========================View-TextField-Container============================//
                    Form(
                      autovalidate: _validate,
                      key: _Formkey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(
                            height: 85,
                          ),
//----------------------------------SpecialOfferText--------------------------//
                          Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Center(
                              child: Text(
                                GlobalFlag.OfferTexr.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white,
                                    decoration: TextDecoration.none),
                              ),
                            ),
                          ),
//============================Name-controller=================================//
                          Padding(
                            padding: EdgeInsets.all(15.0),
                            child: TextFormField(
                              style: TextStyle(color: Colors.black),
                              focusNode: myFocusNodeName,
                              controller: Namecontroller,
                              validator: validateName,
                              textInputAction: TextInputAction.next,
                              onSaved: (String val) {
                                Name = val;
                              },
                              decoration: new InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                  // width: 0.0 produces a thin "hairline" border
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.0),
                                ),
                                errorStyle: TextStyle(
                                    fontSize: 10.0,
                                    color: GlobalAppColor.AppBarColorCode),
                                border: new OutlineInputBorder(),
                                hintText: GlobalFlag.EnterName.toString(),
                                hintStyle: TextStyle(
                                  fontSize: 14.0,
                                  color: GlobalAppColor.BlackColorCode,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: GlobalFlag.FontCode.toString(),
                                ),
                              ),
                            ),
                          ),
//============================Mobile-controller===============================//
                          Padding(
                            padding: EdgeInsets.all(15.0),
                            child: TextFormField(
                              style: TextStyle(color: Colors.black),
                              focusNode: myFocusNodeMobile,
                              controller: Mobilecontroller,
                              validator: validateMOBILE,
                              keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.next,
                              onSaved: (String val) {
                                Mobile = val;
                              },
                              decoration: new InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                  // width: 0.0 produces a thin "hairline" border
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.0),
                                ),
                                errorStyle: TextStyle(
                                    fontSize: 10.0,
                                    color: GlobalAppColor.AppBarColorCode),
                                border: new OutlineInputBorder(),
                                hintText: GlobalFlag.EnterMobile.toString(),
                                hintStyle: TextStyle(
                                  fontSize: 14.0,
                                  color: GlobalAppColor.BlackColorCode,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: GlobalFlag.FontCode.toString(),
                                ),
                              ),
                            ),
                          ),
//============================Email-controller================================//
                          Padding(
                            padding: EdgeInsets.all(15.0),
                            child: TextFormField(
                              style: TextStyle(color: Colors.black),
                              focusNode: myFocusNodeEmail,
                              controller: Emailcontroller,
                              validator: validateEmail,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              onSaved: (String val) {
                                Email = val;
                              },
                              decoration: new InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                  // width: 0.0 produces a thin "hairline" border
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.0),
                                ),
                                errorStyle: TextStyle(
                                    fontSize: 10.0,
                                    color: GlobalAppColor.AppBarColorCode),
                                border: new OutlineInputBorder(),
                                hintText: GlobalFlag.Enteremail.toString(),
                                hintStyle: TextStyle(
                                  fontSize: 14.0,
                                  color: GlobalAppColor.BlackColorCode,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: GlobalFlag.FontCode.toString(),
                                ),
                              ),
                            ),
                          ),
//----------------------Offer-Submit------------------------------------------//
                          new Center(
                            child: Container(
                              child: RaisedButton(
                                onPressed: () {
                                  setState(() {
                                    _sendToServer(OfferName);
                                  });
                                },
                                color: GlobalAppColor.OfferBtn,
                                child: Text(
                                  GlobalFlag.GetOffers.toUpperCase(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
//============================PollDescController==============================//
                        ],
                      ),
                    ),
//============================================================================//
                  ],
                )));
      },
    );
  }

//-----------------------------------validateName-----------------------------//
  String validateName(String value) {
    String patttern = r'';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return GlobalFlag.NameRequired.toString();
    } else if (!regExp.hasMatch(value)) {
      return GlobalFlag.NameRmust.toString();
    }
    return null;
  }

//--------------------------validateAdminEmployeMOBILE------------------------//
  String validateMOBILE(String value) {
    String patttern = GlobalFlag.PattternNumber.toString();
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return GlobalFlag.MobileisRequired.toString();
    } else if (value.length != 10) {
      return GlobalFlag.Mobilenumbermust10digits.toString();
    } else if (!regExp.hasMatch(value)) {
      return GlobalFlag.MobileNumbermustbedigits.toString();
    }
    return null;
  }

//--------------------------validateEmail-------------------------------------//
  String validateEmail(String value) {
    String pattern = GlobalFlag.PattternEmail.toString();
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return GlobalFlag.EmailRequired.toString();
    } else if (!regExp.hasMatch(value)) {
      return GlobalFlag.InvalidEmail.toString();
    } else {
      return null;
    }
  }

//-----------------_sendToServer----------------------------------------------//
  _sendToServer(OfferName) async {
    if (_Formkey.currentState.validate()) {
      _Formkey.currentState.save();
      pr.show();
      CouponFormPost(OfferName);
    } else {
      setState(() {
        _validate = true;
      });
    }
  }

//-------------------------------CouponFormPost--------------------------------//
  // ignore: non_constant_identifier_names
  Future<void> CouponFormPost(OfferName) async {
    try {
      http.post(CoupnFormUrl_ServiceUrl, body: {
        "name": Namecontroller.text.toString(),
        "email": Emailcontroller.text.toString(),
        "mobile": Mobilecontroller.text.toString(),
      }).then((resultSignup) {
        setStatus(
            resultSignup.statusCode == 200 ? resultSignup.body : errMessage);
        //print(GlobalFlag.Printjsonresp.toString()+"${resultSignup.body.toString()}");
        // ignore: non_constant_identifier_names
        var Data = json.decode(resultSignup.body);
        // ignore: non_constant_identifier_names
        var RecivedStatus = Data["status"];
        if (RecivedStatus == 200) {
          pr.hide();
          Navigator.pop(context);
          var Name = Namecontroller.text;
          var Email = Emailcontroller.text;
          var Mobile = Mobilecontroller.text;
          var OffName = OfferName;
          FlutterOpenWhatsapp.sendSingleMessage("+971565602357",
              "Hi Reon ,  \n OfferName:  $OffName.\n Name:  $Name. \n Email:  $Email \n Mobile: $Mobile  \n Thanks!");
          Namecontroller.clear();
          Emailcontroller.clear();
          Mobilecontroller.clear();
        } else {
          pr.hide();
          _FormFailedAlert();
          Namecontroller.clear();
          Emailcontroller.clear();
          Mobilecontroller.clear();
        }
        pr.hide();
      }).catchError((error) {
        setStatus(error);
      });
    } catch (e) {
      /* JsonStatusFalseAlert();*/
    }
  }

//--------------------------------_FormFailedAlert-----------------------------//
  // ignore: non_constant_identifier_names
  Future<void> _FormFailedAlert() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            GlobalFlag.WarningMessage,
            textAlign: TextAlign.center,
            style: new TextStyle(
              fontSize: 15.0,
              color: GlobalAppColor.AppBarColorCode,
              fontWeight: FontWeight.bold,
              fontFamily: GlobalFlag.FontCode.toString(),
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  GlobalFlag.oncemore.toString(),
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    fontSize: 15.0,
                    color: GlobalAppColor.AppBarColorCode,
                    fontWeight: FontWeight.bold,
                    fontFamily: GlobalFlag.FontCode.toString(),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                pr.hide();
                Navigator.of(context).pop();
              },
              child: Text(
                GlobalFlag.TryAgain.toString(),
                style: new TextStyle(
                  fontSize: 15.0,
                  color: GlobalAppColor.AppBarColorCode,
                  fontWeight: FontWeight.bold,
                  fontFamily: GlobalFlag.FontCode.toString(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
//----------------------------------END---------------------------------------//
