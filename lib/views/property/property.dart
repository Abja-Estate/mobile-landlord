import 'dart:convert';

import 'package:abjalandlord/components/buttons.dart';
import 'package:abjalandlord/constants/app_images.dart';
import 'package:abjalandlord/provider/property_provider.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_fonts.dart';
import '../../constants/app_routes.dart';
import '../../provider/request_provider.dart';
import '../../utils/app_utils.dart';
import '../../utils/local_storage.dart';
import 'tab_contents/content.dart';
import 'utils/filter_properties.dart';

class Property extends StatefulWidget {
  const Property({Key? key}) : super(key: key);

  @override
  _PropertyState createState() => _PropertyState();
}

class _PropertyState extends State<Property> {
  int _tabIndex = 0;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<PropertyProvider>(context, listen: false).init();
      Provider.of<RequestProvider>(context, listen: false).getAllRequest();
      propertyData = allproperties;
    });
    super.initState();
  }

  search4Property(v, data) {
    if (v == "" || v == null) {
      propertyData = allproperties;
        setState(() {
        
      });
    } else {
      propertyData = [];
      List matchedProperties = searchProperties(data, v);
      for (var filteredProperty in matchedProperties) {
        propertyData.add(filteredProperty);
        setState(() {});
      }
    }
  }

  var allproperties = [];
  var propertyData = [];
  @override
  Widget build(BuildContext context) {
    Provider.of<PropertyProvider>(context, listen: false);
    final _getSize = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [Text(""), Icon(Icons.filter_list)],
              ),
              SizedBox(
                height: _getSize.height * 0.035,
              ),
              Container(
                height: _getSize.height * 0.055,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.5,
                    color: Color(0xFF949494),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: TextField(
                          onChanged: (v) => search4Property(v, propertyData),
                          decoration: const InputDecoration(
                            hintText: 'Search',
                            border: InputBorder.none,
                          ),
                          style: AppFonts.body1.copyWith(fontSize: 14),
                          // Add any necessary event handlers for text changes or submission.
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        var searchItem;
                        if (searchItem.isEmpty) {
                          AppUtils.showSnackBarMessage(
                              'Enter an item to search for', context);
                        } else {
                          Navigator.of(context).pushNamed(
                            AppRoutes.randomSearch,
                            arguments: {
                              'search': searchItem,
                            },
                          );
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Image.asset(AppImages.search),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: _getSize.height * 0.02,
              ),
              SizedBox(
                height: _getSize.height * 0.76,
                child: Stack(children: [
                  Consumer2<PropertyProvider, RequestProvider>(builder:
                      (context, propertyProvider, requestProvider, child) {
                    allproperties = propertyProvider.property;
                    // propertyData = allproperties;
                    // List< dynamic> sortedData =
                    //     List.from(propertyData); // Copy the list
                    // sortedData.sort((a, b) => DateTime.parse(b['time'])
                    //     .compareTo(DateTime.parse(a['time'])));

                    var vacantProperty = filterProperty(propertyData, false);
                    var rentedProperty = filterProperty(propertyData, true);

                    var categories = [
                      'Vacant Units (${propertyCount(propertyData, false).toString()})',
                      'Rented Units (${propertyCount(propertyData, true).toString()})',
                    ];
                    return DefaultTabController(
                      length: 2,
                      child: Column(
                        children: <Widget>[
                          ButtonsTabBar(
                            height: _getSize.height * 0.03,

                            buttonMargin: EdgeInsets.symmetric(
                                horizontal: _getSize.height * 0.005),
                            borderWidth: 0.5,
                            borderColor: Pallete.primaryColor,
                            backgroundColor: Pallete.primaryColor,
                            unselectedBackgroundColor:
                                const Color.fromARGB(255, 255, 255, 255),
                            unselectedLabelStyle:
                                const TextStyle(color: Colors.black),
                            labelStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            tabs: categories.map((category) {
                              return Tab(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 2.0, horizontal: 8),
                                  child: Text(
                                    category,
                                    style: AppFonts.bodyText.copyWith(),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          propertyProvider.isLoadingShowProperty
                              ? Container(
                                  margin: EdgeInsets.only(bottom: 8),
                                  decoration: BoxDecoration(
                                      color: Color(0xFFF6F9F5),
                                      borderRadius: BorderRadius.circular(10)),
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
                                          "Looking for your property Listing",
                                          style: AppFonts.body1,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Column(
                                  children: [
                                    propertyData.isEmpty
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
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Image.asset(
                                                    AppImages.no_prop,
                                                    width: _getSize.width * 0.6,
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        "You currently have no added property",
                                                        style: AppFonts.body1,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        _getSize.height * 0.01,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ) // Widget to show when many is 0
                                        : SizedBox(
                                            width: _getSize.width,
                                            height: _getSize.height * 0.73,
                                            child: TabBarView(
                                              children: <Widget>[
                                                tabContent(
                                                  requests:
                                                      requestProvider.request,
                                                  propertyData: vacantProperty,
                                                  getSize: _getSize,
                                                  items: vacantProperty.length,
                                                  type: "vacant",
                                                ),
                                                tabContent(
                                                  requests:
                                                      requestProvider.request,
                                                  propertyData: rentedProperty,
                                                  getSize: _getSize,
                                                  type: "rented",
                                                  items: rentedProperty.length,
                                                ),
                                              ],
                                            ),
                                          ),
                                  ],
                                ),
                        ],
                      ),
                    );
                  }),
                  Positioned(
                    bottom: 60,
                    child: ButtonWithFuction(
                        text: 'Add Property',
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(AppRoutes.addProperty);
                        }),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

