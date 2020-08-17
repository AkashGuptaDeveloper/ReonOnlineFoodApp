import 'dart:async';
import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:reonapp/Animation/FadeAnimation.dart';
import 'package:reonapp/Drawer/HomeDrawer.dart';
import 'package:reonapp/GlobalComponents/GlobalAppColor/GlobalAppColor.dart';
import 'package:reonapp/GlobalComponents/GlobalFlag/GlobalFlag.dart';
import 'package:reonapp/GlobalComponents/GlobalNavigationRoute/GlobalNavigationRoute.dart';
import 'package:reonapp/GlobalComponents/GlobalServiceURL/GlobalServiceURL.dart';
import 'package:reonapp/Model/HomeListModel/AllSubCategoryModel/AllSubCategoryModel.dart';
import 'package:reonapp/Model/HomeListModel/SearchSubCategory/SearchSubCategory.dart';
import 'package:reonapp/Model/HomeListModel/SubCategoryModel/SubCategoryModel.dart';
//---------------------------------START--------------------------------------//
class SubCategory extends StatefulWidget {
  static String tag = GlobalNavigationRoute.TagSubCategory.toString();
  // ignore: unnecessary_statements, non_constant_identifier_names
  final String SendUserID;
  SubCategory({
    Key key,
    // ignore: unnecessary_statements, non_constant_identifier_names
    this.SendUserID,
  }) : super(key: key);
  @override
  SubCategoryState createState() => new SubCategoryState();
}
//------------------------------HomeScreenState-------------------------------//
class SubCategoryState extends State<SubCategory> {
//----------------------------------------ServiceUrl--------------------------//
// ignore: non_constant_identifier_names
  String Sub_categoryUrl_ServiceUrl =
      GlobalServiceURL.Sub_categoryUrl.toString();
  // ignore: non_constant_identifier_names
  String Sub_categoryBottomListUrl_ServiceUrl =
      GlobalServiceURL.Sub_categoryBottomListUrl.toString();
//----------------------------------------Global-Variable---------------------//
  String errMessage = GlobalFlag.ErrorSendData;
  String status = '';
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  ProgressDialog pr;
  // ignore: non_constant_identifier_names
  List<SubCategoryData> _SubCategoryDataList = [];
  // ignore: non_constant_identifier_names
  List<SearchSubCategoryData> _SearchSubCategoryDataList = [];
  // ignore: non_constant_identifier_names
  List<SearchSubCategoryData> _SearchTextSubCategoryDataList = [];
  // ignore: non_constant_identifier_names
  List<AllSubCategoryData> _AllSubCategoryDataList = [];
  // ignore: non_constant_identifier_names
  List<AllSubCategoryData> _SearchAllSubCategoryDataList = [];
  static const kListHeight = 100.0;
  String platformVersion = 'Unknown';
  // ignore: non_constant_identifier_names
  bool ShowRealList = false;
  // ignore: non_constant_identifier_names
  bool ShowSubCategoryList = false;
  // ignore: non_constant_identifier_names
  bool NoList = false;
  // ignore: non_constant_identifier_names
  bool selected = false;
  // ignore: non_constant_identifier_names
  TextEditingController controller = new TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController Searchcontroller = new TextEditingController();
  // ignore: non_constant_identifier_names
  List AddProduct = [];
  // ignore: non_constant_identifier_names
  List<bool> _selected = List.generate(200, (i) => false);
  // ignore: non_constant_identifier_names
  var Model;
  // ignore: non_constant_identifier_names
  var AddProductItems;
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
    initPlatformState();
    this._checkInternetConnectivity();
    super.initState();
    FetchSubCategoryListFromServer();
    FetchSubAllCategoryListFromServer();
  }
//--------------------------------------------initPlatformState---------------//
  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await FlutterOpenWhatsapp.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      platformVersion = platformVersion;
    });
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
//-----------------------------------WillPopScope-----------------------------//
    return Scaffold(
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
      backgroundColor: Colors.grey[100],
//--------------------------------------body----------------------------------//
      body:new FadeAnimation (
        2, new Container(
        color:Colors.grey[300],
        padding: const EdgeInsets.all(1.0),
        child: new Stack(
          //alignment:new Alignment(x, y)
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: <Widget>[
//----------------------------------------------------------------------------//
                  Expanded(
                    child: Container(
                      child: Visibility(
                        child:new Column(
                          children: <Widget>[
//------------------------------Search-Product--------------------------------//
                            Container(
                              height: 30,
                              color: Colors.white,
                              child: new Container(
                                  padding: EdgeInsets.only(left: 10, top: 10),
                                  color: Colors.white,
                                  child: new Column(
                                    children: <Widget>[
                                      new Align(
                                          alignment: Alignment.centerLeft,
                                          child: new Text(
                                            GlobalFlag.Categories.toString(),
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontFamily: GlobalFlag.FontCode.toString(),
                                                color: GlobalAppColor.BlackColorCode,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )),
                                    ],
                                  )),
                            ),
//------------------------------List-Sub-Category-Product---------------------//
                            Container(
                              child: new Container(
                                color: Colors.white,
                                child: SizedBox(
                                  height: kListHeight,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _SubCategoryDataList == null
                                        ? 0
                                        : _SubCategoryDataList.length,
                                    itemBuilder: (_, index) => GestureDetector(
                                      onTap: () {
                                        // ignore: unnecessary_statements
                                        _SubCategoryDataList[index].id;
                                        // ignore: non_constant_identifier_names
                                        var SubCategoryID = _SubCategoryDataList[index].id;
                                        FetchSearchSubAllCategoryListFromServer(
                                            SubCategoryID);
                                      },
                                      child: Card(
                                          elevation: 3.0,
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
                                                  child: Container(
                                                      child: Image.network(
                                                        GlobalServiceURL.ImageURL +
                                                            _SubCategoryDataList[index].image,
                                                        fit: BoxFit.cover,
                                                      ),
                                                      height: 130),
                                                ),
                                              ),
                                              Text(
                                                _SubCategoryDataList[index].subCategoryName,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily:
                                                    GlobalFlag.FontCode.toString(),
                                                    color: GlobalAppColor.AppIcon,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                              SizedBox(
                                                height: 8.0,
                                              ),
                                            ],
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                            ),
//-----------------------------Search-List-Product----------------------------//
                            Visibility(
                             visible: ShowRealList,
                             child:new Container(
                               height:75,
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
                                           hintText: 'Search',
                                           border: InputBorder.none),
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
                           ),
                            Visibility(
                              visible: ShowSubCategoryList,
                              child:new Container(
                                height:75,
                                color: Theme.of(context).primaryColor,
                                child: new Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: new Card(
                                    child: new ListTile(
                                      leading: new Icon(Icons.search),
                                      title: new TextField(
                                        textAlign: TextAlign.center,
                                        controller: Searchcontroller,
                                        decoration: new InputDecoration(
                                            hintText: 'Search',
                                            border: InputBorder.none),
                                        onChanged: onSearchChanged,
                                      ),
                                      trailing: new IconButton(
                                        icon: new Icon(Icons.cancel),
                                        onPressed: () {
                                          Searchcontroller.clear();
                                          onSearchChanged('');
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
//------------------------------Real-Product----------------------------------//
                            new Visibility(
                              visible: ShowRealList,
                              child: Expanded(
                                child: _SearchAllSubCategoryDataList.length != 0 ||
                                    controller.text.isNotEmpty
                                    ? new ListView.builder(
                                  padding: EdgeInsets.only(left:5.0,right:5.0,),
                                  itemCount: _SearchAllSubCategoryDataList == null
                                      ? 0
                                      : _SearchAllSubCategoryDataList.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      color: GlobalAppColor.AppBarColorCode,
                                      margin: new EdgeInsets.only(top: 5.0),
                                      padding: const EdgeInsets.symmetric(vertical: 1.0),
                                      child: SizedBox(
                                        height: 100,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.white,
                                                  width: 0.5,
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        5.0) //                 <--- border radius here
                                                ),
                                              ),
                                              child: AspectRatio(
                                                aspectRatio: 1.0,
                                                child: CachedNetworkImage(
                                                  imageUrl: GlobalServiceURL.ImageURL +
                                                      _SearchAllSubCategoryDataList[index].image,
                                                  imageBuilder: (context, imageProvider) =>
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                              image: imageProvider,
                                                              fit: BoxFit.cover),
                                                        ),
                                                      ),
                                                  placeholder: (context, url) =>
                                                      CircularProgressIndicator(),
                                                  errorWidget: (context, url, error) =>
                                                      Icon(Icons.error),
                                                ),
                                              ),
                                            ),
//----------------------------------------------------------------------------//
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.fromLTRB(
                                                    10.0, 0.0, 2.0, 0.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 2,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                        children: <Widget>[
//----------------------------------------------------------------------------//
                                                          SizedBox(
                                                            height: 5.0,
                                                          ),
                                                          Text(
                                                            _SearchAllSubCategoryDataList[index]
                                                                .productName,
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: const TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 15,
                                                              color:
                                                              const Color(0xFF696969),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 3.0,
                                                          ),
//----------------------------------------------------------------------------//
                                                          const Padding(
                                                              padding: EdgeInsets.only(
                                                                  bottom: 2.0)),
                                                          Row(
                                                            children: <Widget>[
                                                              Expanded(
                                                                child: Text(
                                                                  _SearchAllSubCategoryDataList[index]
                                                                      .labeling,
                                                                  style: TextStyle(
                                                                    fontWeight:
                                                                    FontWeight.w400,
                                                                    fontSize: 12,
                                                                    color: const Color(
                                                                        0xFF585858),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 5.0,
                                                          ),
                                                          new Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  "Rs." +
                                                                      _SearchAllSubCategoryDataList[
                                                                      index]
                                                                          .price,
                                                                  maxLines: 1,
                                                                  overflow:
                                                                  TextOverflow.ellipsis,
                                                                  style: const TextStyle(
                                                                    fontWeight:
                                                                    FontWeight.bold,
                                                                    fontSize: 12,
                                                                    color: const Color(
                                                                        0xFF000000),
                                                                  ),
                                                                ),
 //----------------------------------------------------OrderNow----------------//
                                                                GestureDetector(
                                                                  onTap: (){
                                                                    setState(() {
                                                                      _selected[index] = !_selected[index];
                                                                      // ignore: unnecessary_statements
                                                                      Model = _SearchAllSubCategoryDataList[index];
                                                                      var AddItem =  Model.productName;
                                                                      if(_selected[index]){
                                                                        AddProduct.addAll([AddItem]);
                                                                        AddProductItems = AddProduct.join(" + ");
                                                                      }
                                                                      if(!_selected[index]){
                                                                        AddProduct.remove("$AddItem");
                                                                        AddProductItems = AddProduct.join(" + ");
                                                                      }
                                                                    });
                                                                  },
                                                                  child:Container(
                                                                    color: _selected[index] ? Colors.lightGreen : Colors.amber ,
                                                                    padding: EdgeInsets.all(5),
                                                                    width: 100,
                                                                    child: GestureDetector(
                                                                      child: Text(_selected[index] ? "ADDED" : "ORDER",style: const TextStyle(
                                                                        fontWeight: FontWeight.bold,
                                                                        fontSize: 15,
                                                                        color:Colors.white,
                                                                      ),textAlign: TextAlign.center,),
                                                                    ),
                                                                    margin: EdgeInsets.only(left:80),
                                                                  ),
                                                                ),
                                                              ]),
                                                          SizedBox(
                                                            height: 3.0,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                )
                                    : ListView.builder(
                                  padding: EdgeInsets.only(left:5.0,right:5.0),
                                  itemCount: _AllSubCategoryDataList == null
                                      ? 0
                                      : _AllSubCategoryDataList.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      color: GlobalAppColor.AppBarColorCode,
                                      margin: new EdgeInsets.only(top: 5.0),
                                      padding: const EdgeInsets.symmetric(vertical: 1.0),
                                      child: SizedBox(
                                        height: 100,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.white,
                                                  width: 0.5,
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        5.0) //                 <--- border radius here
                                                ),
                                              ),
                                              child: AspectRatio(
                                                aspectRatio: 1.0,
                                                child: CachedNetworkImage(
                                                  imageUrl: GlobalServiceURL.ImageURL +
                                                      _AllSubCategoryDataList[index].image,
                                                  imageBuilder: (context, imageProvider) =>
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                              image: imageProvider,
                                                              fit: BoxFit.cover),
                                                        ),
                                                      ),
                                                  placeholder: (context, url) =>
                                                      CircularProgressIndicator(),
                                                  errorWidget: (context, url, error) =>
                                                      Icon(Icons.error),
                                                ),
                                              ),
                                            ),
//----------------------------------------------------------------------------//
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.fromLTRB(
                                                    10.0, 0.0, 2.0, 0.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 2,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                        children: <Widget>[
//----------------------------------------------------------------------------//
                                                          SizedBox(
                                                            height: 5.0,
                                                          ),
                                                          Text(
                                                            _AllSubCategoryDataList[index]
                                                                .productName,
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: const TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 15,
                                                              color:
                                                              const Color(0xFF696969),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 3.0,
                                                          ),
//----------------------------------------------------------------------------//
                                                          const Padding(
                                                              padding: EdgeInsets.only(
                                                                  bottom: 2.0)),
                                                          Row(
                                                            children: <Widget>[
                                                              Expanded(
                                                                child: Text(
                                                                  _AllSubCategoryDataList[index]
                                                                      .labeling,
                                                                  style: TextStyle(
                                                                    fontWeight:
                                                                    FontWeight.w400,
                                                                    fontSize: 12,
                                                                    color: const Color(
                                                                        0xFF585858),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 5.0,
                                                          ),
                                                          new Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  "Rs." +
                                                                      _AllSubCategoryDataList[
                                                                      index]
                                                                          .price,
                                                                  maxLines: 1,
                                                                  overflow:
                                                                  TextOverflow.ellipsis,
                                                                  style: const TextStyle(
                                                                    fontWeight:
                                                                    FontWeight.bold,
                                                                    fontSize: 12,
                                                                    color: const Color(
                                                                        0xFF000000),
                                                                  ),
                                                                ),
//----------------------------------------------------OrderNow----------------//
                                                                GestureDetector(
                                                                  onTap: (){
                                                                    setState(() {
                                                                      _selected[index] = !_selected[index];
                                                                      // ignore: unnecessary_statements
                                                                      Model = _AllSubCategoryDataList[index];
                                                                      var AddItem =  Model.productName;
                                                                      if(_selected[index]){
                                                                        AddProduct.addAll([AddItem]);
                                                                        AddProductItems = AddProduct.join(" + ");
                                                                      }
                                                                      if(!_selected[index]){
                                                                        AddProduct.remove("$AddItem");
                                                                        AddProductItems = AddProduct.join(" + ");
                                                                      }
                                                                    });
                                                                  },
                                                                  child:Container(
                                                                    color: _selected[index] ? Colors.lightGreen : Colors.amber ,
                                                                    padding: EdgeInsets.all(5),
                                                                    width: 100,
                                                                    child: GestureDetector(
                                                                      child: Text(_selected[index] ? "ADDED" : "ORDER",style: const TextStyle(
                                                                        fontWeight: FontWeight.bold,
                                                                        fontSize: 15,
                                                                        color:Colors.white,
                                                                      ),textAlign: TextAlign.center,),
                                                                    ),
                                                                    margin: EdgeInsets.only(left:80),
                                                                  ),
                                                                ),
                                                              ]),
                                                          SizedBox(
                                                            height: 3.0,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
//-------------------------Show-Click-SubCategory-List------------------------//
                            new Visibility(
                              visible: ShowSubCategoryList,
                              child: Expanded(
                                child: _SearchTextSubCategoryDataList.length != 0 ||
                                    controller.text.isNotEmpty
                                    ? new ListView.builder(
                                  padding: EdgeInsets.only(left:5.0,right:5.0,),
                                  itemCount: _SearchTextSubCategoryDataList == null
                                      ? 0
                                      : _SearchTextSubCategoryDataList.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      color: GlobalAppColor.AppBarColorCode,
                                      margin: new EdgeInsets.only(top: 5.0),
                                      padding: const EdgeInsets.symmetric(vertical: 1.0),
                                      child: SizedBox(
                                        height: 100,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.white,
                                                  width: 0.5,
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        5.0) //                 <--- border radius here
                                                ),
                                              ),
                                              child: AspectRatio(
                                                aspectRatio: 1.0,
                                                child: CachedNetworkImage(
                                                  imageUrl: GlobalServiceURL.ImageURL +
                                                      _SearchTextSubCategoryDataList[index].image,
                                                  imageBuilder: (context, imageProvider) =>
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                              image: imageProvider,
                                                              fit: BoxFit.cover),
                                                        ),
                                                      ),
                                                  placeholder: (context, url) =>
                                                      CircularProgressIndicator(),
                                                  errorWidget: (context, url, error) =>
                                                      Icon(Icons.error),
                                                ),
                                              ),
                                            ),
//----------------------------------------------------------------------------//
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.fromLTRB(
                                                    10.0, 0.0, 2.0, 0.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 2,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                        children: <Widget>[
//----------------------------------------------------------------------------//
                                                          SizedBox(
                                                            height: 5.0,
                                                          ),
                                                          Text(
                                                            _SearchTextSubCategoryDataList[index]
                                                                .productName,
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: const TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 15,
                                                              color:
                                                              const Color(0xFF696969),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 3.0,
                                                          ),
//----------------------------------------------------------------------------//
                                                          const Padding(
                                                              padding: EdgeInsets.only(
                                                                  bottom: 2.0)),
                                                          Row(
                                                            children: <Widget>[
                                                              Expanded(
                                                                child: Text(
                                                                  _SearchTextSubCategoryDataList[index]
                                                                      .labeling,
                                                                  style: TextStyle(
                                                                    fontWeight:
                                                                    FontWeight.w400,
                                                                    fontSize: 12,
                                                                    color: const Color(
                                                                        0xFF585858),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 5.0,
                                                          ),
                                                          new Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  "Rs." +
                                                                      _SearchTextSubCategoryDataList[
                                                                      index]
                                                                          .price,
                                                                  maxLines: 1,
                                                                  overflow:
                                                                  TextOverflow.ellipsis,
                                                                  style: const TextStyle(
                                                                    fontWeight:
                                                                    FontWeight.bold,
                                                                    fontSize: 12,
                                                                    color: const Color(
                                                                        0xFF000000),
                                                                  ),
                                                                ),
//----------------------------------------------------OrderNow----------------//
                                                          GestureDetector(
                                                                  onTap: (){
                                                                    setState(() {
                                                                      _selected[index] = !_selected[index];
                                                                      // ignore: unnecessary_statements
                                                                      Model = _SearchTextSubCategoryDataList[index];
                                                                      var AddItem =  Model.productName;
                                                                      if(_selected[index]){
                                                                        AddProduct.addAll([AddItem]);
                                                                        AddProductItems = AddProduct.join(" + ");
                                                                      }
                                                                      if(!_selected[index]){
                                                                        AddProduct.remove("$AddItem");
                                                                        AddProductItems = AddProduct.join(" + ");
                                                                      }
                                                                    });
                                                                  },
                                                                  child:Container(
                                                                    color: _selected[index] ? Colors.lightGreen : Colors.amber ,
                                                                    padding: EdgeInsets.all(5),
                                                                    width: 100,
                                                                    child: GestureDetector(
                                                                      child: Text(_selected[index] ? "ADDED" : "ORDER",style: const TextStyle(
                                                                        fontWeight: FontWeight.bold,
                                                                        fontSize: 15,
                                                                        color:Colors.white,
                                                                      ),textAlign: TextAlign.center,),
                                                                    ),
                                                                    margin: EdgeInsets.only(left:80),
                                                                  ),
                                                                ),
                                                              ]),
                                                          SizedBox(
                                                            height: 3.0,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                )
                                    : ListView.builder(
                                  padding: EdgeInsets.only(left:5.0,right:5.0),
                                  itemCount: _SearchSubCategoryDataList == null
                                      ? 0
                                      : _SearchSubCategoryDataList.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      color: GlobalAppColor.AppBarColorCode,
                                      margin: new EdgeInsets.only(top:5.0),
                                      padding: const EdgeInsets.symmetric(vertical: 1.0),
                                      child: SizedBox(
                                        height: 100,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.white,
                                                  width: 0.5,
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        5.0) //                 <--- border radius here
                                                ),
                                              ),
                                              child: AspectRatio(
                                                aspectRatio: 1.0,
                                                child: CachedNetworkImage(
                                                  imageUrl: GlobalServiceURL.ImageURL +
                                                      _SearchSubCategoryDataList[index].image,
                                                  imageBuilder: (context, imageProvider) =>
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                              image: imageProvider,
                                                              fit: BoxFit.cover),
                                                        ),
                                                      ),
                                                  placeholder: (context, url) =>
                                                      CircularProgressIndicator(),
                                                  errorWidget: (context, url, error) =>
                                                      Icon(Icons.error),
                                                ),
                                              ),
                                            ),
//----------------------------------------------------------------------------//
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.fromLTRB(
                                                    10.0, 0.0, 2.0, 0.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 2,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                        children: <Widget>[
//----------------------------------------------------------------------------//
                                                          SizedBox(
                                                            height: 5.0,
                                                          ),
                                                          Text(
                                                            _SearchSubCategoryDataList[index]
                                                                .productName,
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: const TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 15,
                                                              color:
                                                              const Color(0xFF696969),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 3.0,
                                                          ),
//----------------------------------------------------------------------------//
                                                          const Padding(
                                                              padding: EdgeInsets.only(
                                                                  bottom: 2.0)),
                                                          Row(
                                                            children: <Widget>[
                                                              Expanded(
                                                                child: Text(
                                                                  _SearchSubCategoryDataList[index]
                                                                      .labeling,
                                                                  style: TextStyle(
                                                                    fontWeight:
                                                                    FontWeight.w400,
                                                                    fontSize: 12,
                                                                    color: const Color(
                                                                        0xFF585858),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 5.0,
                                                          ),
                                                          new Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  "Rs." +
                                                                      _SearchSubCategoryDataList[
                                                                      index]
                                                                          .price,
                                                                  maxLines: 1,
                                                                  overflow:
                                                                  TextOverflow.ellipsis,
                                                                  style: const TextStyle(
                                                                    fontWeight:
                                                                    FontWeight.bold,
                                                                    fontSize: 12,
                                                                    color: const Color(
                                                                        0xFF000000),
                                                                  ),
                                                                ),
//----------------------------------------------------OrderNow----------------//
                                                       GestureDetector(
                                                                  onTap: (){
                                                                    setState(() {
                                                                      _selected[index] = !_selected[index];
                                                                      // ignore: unnecessary_statements
                                                                      Model = _SearchSubCategoryDataList[index];
                                                                      var AddItem =  Model.productName;
                                                                      if(_selected[index]){
                                                                        AddProduct.addAll([AddItem]);
                                                                        AddProductItems = AddProduct.join(" + ");
                                                                      }
                                                                      if(!_selected[index]){
                                                                        AddProduct.remove("$AddItem");
                                                                        AddProductItems = AddProduct.join(" + ");
                                                                      }
                                                                    });
                                                                  },
                                                                  child:Container(
                                                                    color: _selected[index] ? Colors.lightGreen : Colors.amber ,
                                                                    padding: EdgeInsets.all(5),
                                                                    width: 100,
                                                                    child: GestureDetector(
                                                                      child: Text(_selected[index] ? "ADDED" : "ORDER",style: const TextStyle(
                                                                        fontWeight: FontWeight.bold,
                                                                        fontSize: 15,
                                                                        color:Colors.white,
                                                                      ),textAlign: TextAlign.center,),
                                                                    ),
                                                                    margin: EdgeInsets.only(left:80),
                                                                  ),
                                                                ),
                                                              ]),
                                                          SizedBox(
                                                            height: 3.0,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
//----------------------------------------------------------------------------//
                ],
              ),
            )
//----------------------END---------------------------------------------------//
          ],
        ),
      ),
      ),
//-------------------------floatingActionButton--------------------------------//
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            // ignore: unnecessary_statements
            print(AddProductItems);
            // ignore: unnecessary_statements
            AddProductItems;
            if(AddProductItems == null || AddProductItems == ""){
              AddOneProductAlert();
            }else{
              FlutterOpenWhatsapp.sendSingleMessage("+971565602357", "I am Intreste "+AddProductItems);
            }
          });
        },
        child: Icon(FontAwesomeIcons.truck,color: Colors.white,),
        backgroundColor: Colors.amber,
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
//----------------------------------FetchHomeListFromServer-------------------//
  // ignore: non_constant_identifier_names
  Future<void> FetchSubCategoryListFromServer() async {
    try {
      http.post(Sub_categoryUrl_ServiceUrl.toString(), body: {
        "category_id": widget.SendUserID.toString(),
        // ignore: non_constant_identifier_names
      }).then((resultHomeList) {
        setStatus(resultHomeList.statusCode == 200
            ? resultHomeList.body
            : errMessage);
        // ignore: non_constant_identifier_names
        var ReciveGroupList = json.decode(resultHomeList.body);
        //print(GlobalFlag.Printjsonresp.toString()+"${resultHomeList.body.toString()}");
        // ignore: non_constant_identifier_names
        var RecivedStatus = ReciveGroupList[GlobalFlag.jsonrespstatus];
        if (RecivedStatus == 200) {
          // ignore: non_constant_identifier_names
          var ExtractData = ReciveGroupList[GlobalFlag.jsondata];
          setState(() {
            for (Map i in ExtractData) {
              _SubCategoryDataList.add(SubCategoryData.fromJson(i));

              pr.hide();
            }
          });
        } else {}
      }).catchError((error) {
        setStatus(error);
      });
    } catch (e) {
      pr.hide();
      JsonReciveStatusFalseAlert();
    }
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
//----------------------------------FetchSubAllCategoryListFromServer--------//
  // ignore: non_constant_identifier_names
  Future<void> FetchSubAllCategoryListFromServer() async {
    try {
      http.post(Sub_categoryBottomListUrl_ServiceUrl.toString(), body: {
        "category_id": widget.SendUserID.toString(),
        // ignore: non_constant_identifier_names
      }).then((resultAllCategoryList) {
        setStatus(resultAllCategoryList.statusCode == 200
            ? resultAllCategoryList.body
            : errMessage);
        // ignore: non_constant_identifier_names
        var ReciveGroupList = json.decode(resultAllCategoryList.body);
        //print(GlobalFlag.Printjsonresp.toString()+"${resultAllCategoryList.body.toString()}");
        // ignore: non_constant_identifier_names
        var RecivedStatus = ReciveGroupList[GlobalFlag.jsonrespstatus];
        if (RecivedStatus == 200) {
          // ignore: non_constant_identifier_names
          var ExtractData = ReciveGroupList[GlobalFlag.jsondata];
          setState(() {
            for (Map i in ExtractData) {
              _AllSubCategoryDataList.add(AllSubCategoryData.fromJson(i));
              ShowRealList = true;
              ShowSubCategoryList = false;
              NoList = false;
            }
          });
          pr.hide();
        } else {
          ShowRealList = false;
          ShowSubCategoryList = false;
          NoList = true;
        }
      }).catchError((error) {
        setStatus(error);
      });
    } catch (e) {
      pr.hide();
      JsonReciveStatusFalseAlert();
    }
  }
//----------------------------------FetchSearchSubAllCategoryListFromServer---//
  // ignore: non_constant_identifier_names
  Future<void> FetchSearchSubAllCategoryListFromServer(SubCategoryID) async {
    _SearchSubCategoryDataList.clear();
    setState(() {
      // ignore: unnecessary_statements
      SubCategoryID;
      //print(SubCategoryID);
    });
    try {
      http.post(Sub_categoryBottomListUrl_ServiceUrl.toString(), body: {
        "category_id": widget.SendUserID.toString(),
        "sub_category_id": SubCategoryID.toString(),
        // ignore: non_constant_identifier_names
      }).then((resultList) {
        setStatus(resultList.statusCode == 200 ? resultList.body : errMessage);
        // ignore: non_constant_identifier_names
        var ReciveList = json.decode(resultList.body);
        //print(GlobalFlag.Printjsonresp.toString()+"${resultList.body.toString()}");
        // ignore: non_constant_identifier_names
        var Status = ReciveList[GlobalFlag.jsonrespstatus];
        if (Status == 200) {
          // ignore: non_constant_identifier_names
          var ExtractDatas = ReciveList[GlobalFlag.jsondata];
          setState(() {
            for (Map i in ExtractDatas) {
              _SearchSubCategoryDataList.add(SearchSubCategoryData.fromJson(i));
              ShowRealList = false;
              ShowSubCategoryList = true;
              NoList = false;
            }
          });
          pr.hide();
        } else {
          ShowRealList = false;
          ShowSubCategoryList = false;
          NoList = true;
        }
      }).catchError((error) {
        setStatus(error);
      });
    } catch (e) {
      pr.hide();
      JsonReciveStatusFalseAlert();
    }
  }
//-----------------------------onSearchTextChanged----------------------------//
  // ignore: non_constant_identifier_names
  onSearchTextChanged(String text) async {
    _SearchAllSubCategoryDataList.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    // ignore: non_constant_identifier_names
    _AllSubCategoryDataList.forEach((_AllSubCategoryDataList) {
      if (_AllSubCategoryDataList.productName.toLowerCase().contains(text) ||
          _AllSubCategoryDataList.productName.toLowerCase().contains(text))
        _SearchAllSubCategoryDataList.add(_AllSubCategoryDataList);
    });

    setState(() {});
  }
//-----------------------------onSearchChanged--------------------------------//
  // ignore: non_constant_identifier_names
  onSearchChanged(String text) async {
    _SearchTextSubCategoryDataList.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    // ignore: non_constant_identifier_names
    _SearchSubCategoryDataList.forEach((_SearchSubCategoryDataList) {
      if (_SearchSubCategoryDataList.productName.toLowerCase().contains(text) ||
          _SearchSubCategoryDataList.productName.toLowerCase().contains(text))
        _SearchTextSubCategoryDataList.add(_SearchSubCategoryDataList);
    });

    setState(() {});
  }
//-----------------------------AddOneProductAlert-----------------------------//
  // ignore: non_constant_identifier_names
  Future<void> AddOneProductAlert() async {
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
              color: GlobalAppColor.BlackColorCode,
              fontWeight: FontWeight.bold,
              fontFamily: GlobalFlag.FontCode.toString(),
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  GlobalFlag.atleast.toString(),
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    fontSize: 15.0,
                    color: GlobalAppColor.BlackColorCode,
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
                GlobalFlag.Ok,
                style: new TextStyle(
                  fontSize: 15.0,
                  color: GlobalAppColor.BlackColorCode,
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
