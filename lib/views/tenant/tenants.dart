import 'dart:convert';

import 'package:abjalandlord/utils/local_storage.dart';
import 'package:abjalandlord/views/tenant/widget.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_fonts.dart';
import '../../constants/app_images.dart';
import '../../constants/app_routes.dart';
import '../../network/property.dart';
import '../navbar/nav.dart';
import '../property/property.dart';

class Tenants extends StatefulWidget {
  const Tenants({Key? key}) : super(key: key);

  @override
  _TenantsState createState() => _TenantsState();
}

class _TenantsState extends State<Tenants> {
  bool isLoadingProperty = true;
  List property = [];
  List propertyName = [];

  getPropertyNameItems() async {
    isLoadingProperty = true;
    var propertyString = await showPropertyNameItem();
    var m = List<Map<String, dynamic>>.from(jsonDecode(propertyString));
    if (m.isEmpty) {
    } else {
      setState(() {
        propertyName = m;
        isLoadingProperty = false;
        getAllPropertiesTenants(propertyName[0]['propertyID']);
      });
    }
  }

  bool isLoadingTenants = true;
  List tenants = [];
  var pid = '';
  getAllPropertiesTenants(propID) async {
    isLoadingTenants = true;
    await Future.delayed(Duration(seconds: 1));
    var res = await PropertyAPI.getPropertyTenants(propID);

    List gotTenants = res['data'];
    print(gotTenants);
    print("here");
    if (gotTenants.isNotEmpty) {
      setState(() {
        pid = propID;
        tenants = gotTenants;
        isLoadingTenants = false;
      });
    } else {
      setState(() {
        pid = propID;
        isLoadingTenants = false;
        tenants = [];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getPropertyNameItems();
  }

  String extractPropertyID(String unitID) {
    List<String> parts = unitID.split('-');
    if (parts.isNotEmpty) {
      return parts.first;
    } else {
      return ''; // Return an empty string if no hyphen is found
    }
  }

  List<Tab> buildTabs() {
    return propertyName.asMap().entries.map((entry) {
      final index = entry.key;
      final tabName = entry.value;

      return Tab(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 12),
          child: Text(
            tabName['name'],
            style: AppFonts.bodyText, // Replace with your desired text style
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final _getSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFF6F9F5),
      body: SafeArea(
          child: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NavBar(
                                  initialScreen: Property(), initialTab: 2)),
                          (route) => false,
                        );
                      },
                      child: Image.asset(
                        AppImages.back,
                        width: 36,
                      ),
                    ),
                    const Text("Tenants"),
                    const Text("")
                  ],
                ),
              ),
              SizedBox(
                height: _getSize.height * 0.04,
              ),
              SizedBox(
                height: _getSize.height * 0.9,
                child: DefaultTabController(
                  length: propertyName.length,
                  child: Column(
                    children: [
                      ButtonsTabBar(
                        onTap: (p) {
                          isLoadingTenants = true;
                          setState(() {});

                          getAllPropertiesTenants(
                              propertyName[p]['propertyID']);
                        },
                        height: _getSize.height * 0.03,
                        buttonMargin: EdgeInsets.symmetric(
                            horizontal: _getSize.height * 0.025),
                        borderWidth: 0.5,
                        borderColor: Pallete.primaryColor,
                        backgroundColor: Pallete.primaryColor,
                        unselectedBackgroundColor:
                            const Color.fromARGB(255, 255, 255, 255),
                        unselectedLabelStyle:
                            const TextStyle(color: Colors.black),
                        labelStyle: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        tabs: buildTabs(),
                      ),
                      SizedBox(
                                   width: _getSize.width,
                                            height: _getSize.height * 0.86,
                        child: TabBarView(
                          children: propertyName.map((tabName) {
                            return !isLoadingTenants
                                ? tenants.isNotEmpty
                                    ? TenantsContent(
                                        getSize: _getSize,
                                        tenants: tenants,
                                        // Pass any additional data to TenantsContent if needed
                                      )
                                    : 
                                    
                                    
                                    
                                    Container(
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
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Column(
                                                children: [
                                                  Image.asset(
                                                    AppImages.noTenant,
                                                    width: _getSize.width * 0.7,
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        _getSize.height * 0.007,
                                                  ),
                                                  Text(
                                                    "You currently have no tenants in this property",
                                                    style: AppFonts.body1
                                                        .copyWith(
                                                            color: Pallete.text,
                                                            fontSize: 14),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  SizedBox(
                                                    height:
                                                        _getSize.height * 0.01,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pushNamed(
                                                        AppRoutes.propDetails,
                                                        arguments: {
                                                          'data': pid,
                                                        },
                                                      );
                                                    },
                                                    child: Container(
                                                      width:
                                                          _getSize.width * 0.4,
                                                      height: _getSize.height *
                                                          0.045,
                                                      decoration: BoxDecoration(
                                                          color: Pallete
                                                              .primaryColor,
                                                          border: Border.all(
                                                              width: 0.5,
                                                              color: Pallete
                                                                  .primaryColor),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                      child: Center(
                                                        child: Text(
                                                          "Add Tenant",
                                                          style: AppFonts
                                                              .smallWhiteBold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: _getSize.height * 0.01,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ) // Widget to show when many is 0

                                : Container(
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
                                          SpinKitRing(
                                            size: 30,
                                            color: Pallete.primaryColor,
                                            lineWidth: 2.0,
                                          ),
                                          Text(
                                            "Loading Tenants on this property",
                                            style: AppFonts.body1,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
