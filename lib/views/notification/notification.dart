import 'package:abjalandlord/views/notification/tab_content/rent.dart';
import 'package:abjalandlord/views/notification/tab_content/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_fonts.dart';
import '../../constants/app_images.dart';
import '../../provider/user_provider.dart';
import '../request/widget/requestitems.dart';
import 'tab_content/property.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool isLoaded = false;
  late UserProvider userProvider;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false).getAllHistory();
    });
    super.initState();
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
                    const Text(""),
                    const Text("Notifications"),
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
                  length: 3,
                  child: Column(
                    children: <Widget>[
                      ButtonsTabBar(
                        height: _getSize.height * 0.03,
                        buttonMargin:
                            const EdgeInsets.symmetric(horizontal: 16),
                        borderWidth: 0.5,
                        borderColor: Pallete.primaryColor,
                        backgroundColor: Pallete.primaryColor,
                        unselectedBackgroundColor:
                            const Color.fromARGB(255, 255, 255, 255),
                        unselectedLabelStyle:
                            const TextStyle(color: Colors.black),
                        labelStyle: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        tabs: [
                          // Tab(
                          //   child: Padding(
                          //     padding:
                          //         const EdgeInsets.symmetric(horizontal: 12),
                          //     child: Text(
                          //       "All",
                          //       style: AppFonts.bodyText,
                          //     ),
                          //   ),
                          // ),
                          Tab(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2.0, horizontal: 12),
                              child: Text(
                                "Rent",
                                style: AppFonts.bodyText,
                              ),
                            ),
                          ),     Tab(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2.0, horizontal: 12),
                              child: Text(
                                "Request",
                                style: AppFonts.bodyText,
                              ),
                            ),
                          ),
                          Tab(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2.0, horizontal: 12),
                              child: Text(
                                "Property",
                                style: AppFonts.bodyText,
                              ),
                            ),
                          ),
                     
                        ],
                      ),
                      Consumer<UserProvider>(
                          builder: (context, userProvider, child) {
                        // print(userProvider.fetchingHistory);

                        var rentHistory =
                            filterRentNotifications(userProvider.history);

                        var propertyHistory =
                            filterPropertyNotifications(userProvider.history);
                              var requestHistory =
                            filterRequestNotifications(userProvider.history);
                        return !userProvider.fetchingHistory
                            ? SizedBox(
                                         width: _getSize.width,
                                            height: _getSize.height * 0.73,
                                child: TabBarView(
                                  children: <Widget>[
                                    RentNotifications(
                                      getSize: _getSize,
                                      services: rentHistory,
                                    ),  ServicesNotifications(
                                      getSize: _getSize,
                                      services: requestHistory,
                                    ),
                                    PropertyNotifications(
                                        getSize: _getSize,
                                        properties: propertyHistory)
                                  ],
                                ),
                              )
                            : Container(
                                child: Center(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: _getSize.height * 0.15,
                                      ),
                                      SpinKitRing(
                                        size: 40,
                                        lineWidth: 2.5,
                                        color: Pallete.primaryColor,
                                      ),
                                      Text("Loading")
                                    ],
                                  ),
                                ),
                              );
                      }),
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

List<Map<String, dynamic>> filterPropertyNotifications(data) {
  // Filter the list to get all objects with type "request"
  List<Map<String, dynamic>> requestList = data
      .where((request) =>
          request['type'] == "propertyCreation")
      .toList();
 requestList.sort((a, b) => DateTime.parse(b['data']['created_at']).compareTo(DateTime.parse(a['data']['created_at'])));
  // Group the requests by time frame
  Map<String, List<Map<String, dynamic>>> groupedByTime =
      groupByTime(requestList);

  // Create the final result list
  List<Map<String, dynamic>> finalResult = [];

  // Convert groupedByTime to the desired data structure
  groupedByTime.forEach((timeFrame, requests) {
    List<Map<String, dynamic>> data = [];

    for (var request in requests) {
      data.add({
        'icon': AppImages.agent,
        ...request['data'],
      });
    }

    finalResult.add({
      'type': 'property',
      'time': timeFrame,
      'data': data,
    });
  });

  // Sort final result list by time frame
  finalResult.sort((a, b) {
    if (a['time'] == 'Today') {
      return -1; // Move 'Today' to the beginning
    } else if (b['time'] == 'Today') {
      return 1;
    } else {
      // Compare other time frames
      return a['time'].compareTo(b['time']);
    }
  });

  // Print the final result
  print(finalResult);
  return finalResult;
}

List<Map<String, dynamic>> filterRequestNotifications(data) {
  // Filter the list to get all objects with type "request"
  List<Map<String, dynamic>> requestList =
      data.where((request) => request['type'] == "request").toList();
 requestList.sort((a, b) => DateTime.parse(b['data']['created_at']).compareTo(DateTime.parse(a['data']['created_at'])));
  // Group the requests by time frame
  Map<String, List<Map<String, dynamic>>> groupedByTime =
      groupByTime(requestList);

  // Create the final result list
  List<Map<String, dynamic>> finalResult = [];

  // Convert groupedByTime to the desired data structure
  groupedByTime.forEach((timeFrame, requests) {
    List<Map<String, dynamic>> data = [];

    for (var request in requests) {
      data.add({
        'icon': request['data']['agent'],
        ...request['data'],
      });
    }

    finalResult.add({
      'type': 'rent',
      'time': timeFrame,
      'data': data,
    });
  });

  // Sort final result list by time frame
  finalResult.sort((a, b) {
    if (a['time'] == 'Today') {
      return -1; // Move 'Today' to the beginning
    } else if (b['time'] == 'Today') {
      return 1;
    } else {
      // Compare other time frames
      return a['time'].compareTo(b['time']);
    }
  });

  // Print the final result
  print(finalResult);
  return finalResult;
}

List<Map<String, dynamic>> filterRentNotifications(data) {
  // Filter the list to get all objects with type "request"
  List<Map<String, dynamic>> requestList =
      data.where((request) => request['type'] == "tenantAdded").toList();
 requestList.sort((a, b) => DateTime.parse(b['data']['created_at']).compareTo(DateTime.parse(a['data']['created_at'])));
  // Group the requests by time frame
  Map<String, List<Map<String, dynamic>>> groupedByTime =
      groupByTime(requestList);

  // Create the final result list
  List<Map<String, dynamic>> finalResult = [];

  // Convert groupedByTime to the desired data structure
  groupedByTime.forEach((timeFrame, requests) {
    List<Map<String, dynamic>> data = [];

    for (var request in requests) {
      data.add({
        'icon': AppImages.agent,
        ...request['data'],
      });
    }

    finalResult.add({
      'type': 'rent',
      'time': timeFrame,
      'data': data,
    });
  });

  // Sort final result list by time frame
  finalResult.sort((a, b) {
    if (a['time'] == 'Today') {
      return -1; // Move 'Today' to the beginning
    } else if (b['time'] == 'Today') {
      return 1;
    } else {
      // Compare other time frames
      return a['time'].compareTo(b['time']);
    }
  });

  // Print the final result
  print(finalResult);
  return finalResult;
}

Map<String, List<Map<String, dynamic>>> groupByTime(
    List<Map<String, dynamic>> requestList) {
  Map<String, List<Map<String, dynamic>>> groupedByTime = {};

  for (var request in requestList) {
    DateTime requestTime = DateTime.parse(request['data']['created_at']);
    String timeFrame = getTimeFrame(requestTime);

    if (!groupedByTime.containsKey(timeFrame)) {
      groupedByTime[timeFrame] = [];
    }

    groupedByTime[timeFrame]?.add(request);
  }

  return groupedByTime;
}

String getTimeFrame(DateTime requestTime) {
  DateTime now = DateTime.now();
  Duration difference = now.difference(requestTime);

  if (difference.inDays == 0) {
    return 'Today';
  } else if (difference.inDays == 1) {
    return 'Tomorrow';
  } else if (difference.inDays <= 7) {
    return 'A Week Ago';
  } else if (difference.inDays <= 14) {
    return '2 Weeks Ago';
  } else if (difference.inDays <= 30) {
    return '1 Month Ago';
  } else if (difference.inDays <= 60) {
    return '2 Month Ago';
  } else {
    return 'Old Request';
  }
}
