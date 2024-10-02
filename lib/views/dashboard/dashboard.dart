import 'dart:convert';
import 'package:abjalandlord/constants/resources.dart';
import 'package:abjalandlord/network/property.dart';
import 'package:abjalandlord/provider/property_provider.dart';
import 'package:abjalandlord/provider/request_provider.dart';
import 'package:abjalandlord/provider/user_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_fonts.dart';
import '../../constants/app_images.dart';
import '../../constants/app_routes.dart';

import '../../provider/websocket_provider.dart';
import '../../utils/app_utils.dart';
import '../../utils/local_storage.dart';
import '../../utils/location.dart';
import '../../utils/permissions.dart';
import '../drawer_menu/sidebar.dart';
import '../property/property.dart';
import '../property/utils/filter_properties.dart';
import 'widgets/dashboard_property_content.dart';
import 'widgets/properties_info.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var photo = "https://i.ibb.co/9wX2PQw/download.png";

  static const alarmValueKey = ValueKey('Alarm');
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ValueNotifier<Key> valueNotifier = ValueNotifier<Key>(alarmValueKey);
  void toggleDrawer() {
    setState(() {
      if (_scaffoldKey.currentState!.isDrawerOpen) {
        _scaffoldKey.currentState!.openEndDrawer();
      } else {
        _scaffoldKey.currentState!.openDrawer();
      }
    });
  }

  late WebSocketProvider webSocketProvider;

  var fullname = "";
  var name = "";
  var surname = "";
  var email = "";

  search4Property(v, data) {
    if (v == "" || v == null) {
      propertyData = allproperties;
      setState(() {});
    } else {
      propertyData = [];
      List matchedProperties = searchProperties(data, v);
      for (var filteredProperty in matchedProperties) {
        propertyData.add(filteredProperty);
        setState(() {});
      }
    }
  }

  getphoto() async {
    photo = await showSelfie();
  }

  exp()async {
    var isExpired =
        Provider.of<PropertyProvider>(context, listen: false).isExpired;
    if (isExpired) {
     await saveToken("");
     await savePropertyItem("");
     await saveId("");
     setState(() {
        Navigator.of(context).pushNamed(AppRoutes.loginScreen);
     });
      
    }
  }

  Map<String, dynamic> userData = {};
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
     
      Provider.of<UserProvider>(context, listen: false).initUserData();
      Provider.of<PropertyProvider>(context, listen: false).init();
      propertyData = allproperties;

      Provider.of<RequestProvider>(context, listen: false).getAllRequest();

      Provider.of<WebSocketProvider>(context, listen: false).init();
       exp();
      delayedOperation();
    });

    super.initState();
  }

  delayedOperation() async {
    // Delay for 3 seconds
    await Future.delayed(Duration(seconds: 2));

    propertyData = allproperties;
  }

  var allproperties = [];
  var propertyData = [];
  int many = 0;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // transparent status bar
        statusBarIconBrightness: Brightness.dark // dark text for status bar
        ));
    final _getSize = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      drawer: SideBar(
        email: email,
        fullname: fullname,
        photo: photo,
      ),
      backgroundColor: Pallete.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: SizedBox(
              width: _getSize.width,
              height: _getSize.height,
              child: Column(
                children: [
                  Column(
                    children: [
                      Consumer<UserProvider>(
                          builder: (context, userProvider, child) {
                        userData = userProvider.user;
                        if (userData.isNotEmpty) {
                          email = userData['email'];
                          photo = userData['selfie'];
                          fullname =
                              "${userData['name']} ${userData['surname']}";
                        } else {}

                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        toggleDrawer();
                                      },
                                      child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Image.asset(
                                            "assets/icons/ham.png",
                                            width: 36,
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Hello ',
                                                style: AppFonts.bodyText
                                                    .copyWith(
                                                        color: Pallete
                                                            .primaryColor,
                                                        fontSize: 18),
                                              ),
                                              Text(
                                                userData['name'] ?? "",
                                                style: AppFonts.bodyText
                                                    .copyWith(
                                                        color: Pallete
                                                            .primaryColor,
                                                        fontSize: 18),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                ClipOval(
                                  child: CachedNetworkImage(
                                      width: 46,
                                      height: 48,
                                      progressIndicatorBuilder: (context, url,
                                              progress) =>
                                          Center(
                                            child: CircularProgressIndicator(
                                              value: progress.progress,
                                            ),
                                          ),
                                      imageUrl: photo),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: _getSize.height * 0.003,
                            ),
                            Container(
                              height: _getSize.height * 0.055,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 0.5,
                                  color: const Color(0xFF949494),
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8),
                                      child: TextField(
                                        onChanged: (v) =>
                                            search4Property(v, propertyData),
                                        decoration: const InputDecoration(
                                          hintText: 'Search',
                                          border: InputBorder.none,
                                        ),
                                        style: AppFonts.body1
                                            .copyWith(fontSize: 14),
                                        // Add any necessary event handlers for text changes or submission.
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      AppImages.search,
                                      width: 24,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                  SizedBox(
                    height: _getSize.height * 0.02,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your Properties',
                            style: AppFonts.boldText.copyWith(
                                fontSize: _getSize.height * 0.015,
                                fontWeight: FontWeight.w300,
                                color: Pallete.text),
                          ),
                          Consumer2<PropertyProvider, RequestProvider>(builder:
                              (context, propertyProvider, requestProvider,
                                  child) {
                            allproperties = propertyProvider.property;

                            

                            return Column(
                              children: [
                                SizedBox(
                                  height: _getSize.height * 0.01,
                                ),
                                propertyProvider.isLoadingShowProperty
                                    ? Container(
                                        margin: EdgeInsets.only(bottom: 8),
                                        decoration: BoxDecoration(
                                            color: Color(0xFFF6F9F5),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        width: _getSize.width,
                                        height: _getSize.height * 0.38,
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              const SpinKitChasingDots(
                                                size: 30,
                                                color: Pallete.primaryColor,
                                              ),
                                              Text(
                                                "Looking for your property Listing",
                                                style: AppFonts.body1,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ) // Widget to show when many is 0
                                    : Column(
                                        children: [
                                          propertyData.isEmpty
                                              ? Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 8),
                                                  decoration: BoxDecoration(
                                                      color: Color(0xFFF6F9F5),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  width: _getSize.width,
                                                  height:
                                                      _getSize.height * 0.38,
                                                  child: Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Image.asset(
                                                          AppImages.no_prop,
                                                          width:
                                                              _getSize.width *
                                                                  0.6,
                                                        ),
                                                        Column(
                                                          children: [
                                                            Text(
                                                              "You currently have no added property",
                                                              style: AppFonts
                                                                  .body1,
                                                            ),
                                                            SizedBox(
                                                              height: _getSize
                                                                      .height *
                                                                  0.01,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pushNamed(
                                                                        AppRoutes
                                                                            .addProperty);
                                                              },
                                                              child: Container(
                                                                width: _getSize
                                                                        .width *
                                                                    0.4,
                                                                height: _getSize
                                                                        .height *
                                                                    0.045,
                                                                decoration: BoxDecoration(
                                                                    color: Pallete
                                                                        .primaryColor,
                                                                    border: Border.all(
                                                                        width:
                                                                            0.5,
                                                                        color: Pallete
                                                                            .primaryColor),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5)),
                                                                child: Center(
                                                                  child: Text(
                                                                    "Add Property",
                                                                    style: AppFonts
                                                                        .smallWhiteBold,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              _getSize.height *
                                                                  0.01,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ) // Widget to show when many is 0
                                              : DashoardPropertyData(
                                                  getSize: _getSize,
                                                  requests:
                                                      requestProvider.request,
                                                  howMany: propertyData),
                                        ],
                                      ),
                              ],
                            );
                          }),
                        ],
                      ), //

                      Consumer<PropertyProvider>(
                        builder: (context, propertyProvider, child) {
                          return properyInformations(
                              getSize: _getSize,
                              propertyData: propertyProvider.propertiesInfo);
                        },
                      ),
                      SizedBox(
                        height: _getSize.height * 0.035,
                      ),
                      bottom(getSize: _getSize)
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class bottom extends StatelessWidget {
  const bottom({
    super.key,
    required Size getSize,
  }) : _getSize = getSize;

  final Size _getSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: _getSize.height * 0.25,
        width: _getSize.width,
        decoration: const BoxDecoration(
            color: Pallete.whiteColor,
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(89, 113, 109, 109),
                blurRadius: 7,
                spreadRadius: 1,
                offset: Offset(1, 2),
              )
            ],
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: _getSize.width,
              height: _getSize.height * 0.13,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 88, 108, 84),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Explore our different plans for ",
                    style: AppFonts.body1
                        .copyWith(fontSize: 20, color: Pallete.whiteColor),
                  ),
                  Text(
                    "advanced features and benefits!",
                    style: AppFonts.body1
                        .copyWith(fontSize: 20, color: Pallete.whiteColor),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Abja",
                style: AppFonts.boldText.copyWith(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(49, 40, 54, 36)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
