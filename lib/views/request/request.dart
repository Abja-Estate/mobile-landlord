import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_fonts.dart';
import '../../constants/app_images.dart';
import '../../constants/app_routes.dart';
import '../../provider/request_provider.dart';
import 'widget/requestitems.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({Key? key}) : super(key: key);

  @override
  _RequestScreenState createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  late RequestProvider requestProvider;
  int _tabIndex = 0;
  bool loaded = false;
  List request = [];

  @override
  void initState() {
    loaded = true;
    request;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<RequestProvider>(context, listen: false).getAllRequest();
    });

    super.initState();
  }

  Future _fetchContacts() async {
    Provider.of<RequestProvider>(context, listen: false).getAllRequest();
  }

  var photo = 'https://i.pravatar.cc/300';
  @override
  Widget build(BuildContext context) {
    final _getSize = MediaQuery.of(context).size;
    Provider.of<RequestProvider>(context, listen: false).getAllRequest();
    return Scaffold(
        body: RefreshIndicator(
          color: Pallete.primaryColorVariant,
      onRefresh: _fetchContacts,
      child: SafeArea(
        child: SizedBox(
          height: _getSize.height,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(""),
                      Text("Request"),
                      Icon(Icons.filter_list)
                    ],
                  ),
                  SizedBox(
                    height: _getSize.height * 0.035,
                  ),
                  SizedBox(
                    height: _getSize.height * 0.9,
                    child: Consumer<RequestProvider>(
                        builder: (context, requestProvider, child) {
                      var requestData = requestProvider.request;

                      var pendingRq = filterPendingRequest(requestData);
                      var acceptedRq = filterAcceptedRequest(requestData);
                      var completedRq = filterCompletedRequest(requestData);
                      var tenantRq = filterSenderRequest(requestData);

                      var categories = [
                        'Completed (${completedRq.length})',
                        'Accepted (${acceptedRq.length})',
                        'Received (${tenantRq.length})',
                        'Pending (${pendingRq.length})',
                      ];
                      return DefaultTabController(
                        length: 4,
                        child: Column(
                          children: <Widget>[
                            ButtonsTabBar(
                              height: _getSize.height * 0.03,
                              buttonMargin: EdgeInsets.symmetric(
                                  horizontal: _getSize.height * 0.012),
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
                                        vertical: 2.0, horizontal: 9),
                                    child: Text(
                                      category,
                                      textAlign: TextAlign.center,
                                      style: AppFonts.bodyText.copyWith(),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            requestProvider.isFetchingRequest
                                ? Container(
                                    margin: EdgeInsets.only(bottom: 8),
                                    decoration: BoxDecoration(
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
                                            "Looking for your request Listing",
                                            style: AppFonts.body1,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    width: _getSize.width,
                                    height: _getSize.height * 0.85,
                                    child: TabBarView(
                                      children: <Widget>[
                                        tabWithStatus(
                                          text: "Completed",
                                          requestData: completedRq,
                                          getSize: _getSize,
                                          items: completedRq.length,
                                        ),
                                        tabWithStatus(
                                          text: "Accepted",
                                          requestData: acceptedRq,
                                          getSize: _getSize,
                                          items: acceptedRq.length,
                                        ),
                                        tabTenant(
                                          requestData: tenantRq,
                                          getSize: _getSize,
                                          items: tenantRq.length,
                                        ),
                                        tabWithStatus(
                                          text: "Pending",
                                          requestData: pendingRq,
                                          getSize: _getSize,
                                          items: pendingRq.length,
                                        ),
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}

class tabWithStatus extends StatelessWidget {
  tabWithStatus(
      {super.key,
      required Size getSize,
      required this.items,
      required this.text,
      required this.requestData})
      : _getSize = getSize;

  final Size _getSize;
  final int items;
  final String text;
  List requestData;
  var photo = 'https://picsum.photos/200';
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: _getSize.height * 0.27,
        child: requestData.isNotEmpty
            ? ListView.builder(
                itemCount: requestData.length + 1,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) => (index != requestData.length)
                    ? GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(AppRoutes.viewRequest,
                              arguments: {"data": requestData[index]});
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, bottom: 8, right: 8, left: 4),
                          child: Container(
                            height: _getSize.height * 0.07,
                            width: _getSize.width,
                            decoration: BoxDecoration(
                                color: getIconAssetColor(
                                    requestData[index]['agent']),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2.0, horizontal: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Stack(children: [
                                    SizedBox(
                                      width: _getSize.width * 0.145,
                                      height: _getSize.width * 0.17,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ClipOval(
                                          child: Image.network(
                                            requestData[index]['photo'] == ""
                                                ? requestData[index]['photo']
                                                : photo,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 22,
                                      left: 35,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Pallete.whiteColor,
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            border: Border.all(
                                              color: getIconAssetColorDeep(
                                                  requestData[index]['agent']),
                                            )),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Image.asset(
                                            getIconAssetName(
                                                requestData[index]['agent']),
                                            width: requestData[index]
                                                            ['agent'] !=
                                                        "Painter" ||
                                                    requestData[index]
                                                            ['agent'] !=
                                                        "Carpenter"
                                                ? _getSize.width * 0.038
                                                : _getSize.width * 0.017,
                                            height: requestData[index]
                                                            ['agent'] !=
                                                        "Painter" ||
                                                    requestData[index]
                                                            ['agent'] !=
                                                        "Carpenter"
                                                ? _getSize.height * 0.018
                                                : _getSize.height * 0.02,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: _getSize.width * 0.62,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              requestData[index]['agent'],
                                              style: AppFonts.body1.copyWith(
                                                  color: Pallete.text,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              fd(requestData[index]['time']),
                                              style: AppFonts.body1.copyWith(
                                                  color: Pallete.primaryColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: _getSize.height * 0.007,
                                      ),
                                      SizedBox(
                                        width: _getSize.width * 0.6,
                                        child: Text(
                                          requestData[index]['description'],
                                          style: AppFonts.body1.copyWith(
                                              color: Pallete.fade,
                                              fontSize: 12,
                                              overflow: TextOverflow.ellipsis,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : SizedBox(
                        height: _getSize.height * 0.15,
                      ))
            : emptyRequest(
                getSize: _getSize,
                text: text,
              ));
  }
}

class tabTenant extends StatelessWidget {
  tabTenant(
      {super.key,
      required Size getSize,
      required this.items,
      required this.requestData})
      : _getSize = getSize;

  final Size _getSize;
  final int items;
  List requestData;
  var photo = 'https://picsum.photos/200';
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: _getSize.height * 0.25,
        child: requestData.isNotEmpty
            ? ListView.builder(
                itemCount: requestData.length + 1,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) => (index != requestData.length)
                    ? GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(AppRoutes.viewRequest,
                              arguments: {"data": requestData[index]});
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, bottom: 8, right: 8, left: 4),
                          child: Container(
                            height: _getSize.height * 0.097,
                            width: _getSize.width,
                            decoration: BoxDecoration(
                                color: getIconAssetColor(
                                    requestData[index]['agent']),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(44, 85, 80, 80),
                                    blurRadius: 11,
                                    spreadRadius: 1,
                                    offset: Offset(0, 5),
                                  )
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2.0, horizontal: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipOval(
                                    child: Image.network(
                                      requestData[index]['tenantPhoto'],
                                      fit: BoxFit.cover,
                                      width: 52,
                                      height: 52,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  SizedBox(
                                    width: _getSize.width * 0.67,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: _getSize.height * 0.005,
                                            ),
                                            Text(
                                              requestData[index]['fullName'] ??
                                                  "-- --",
                                              style: AppFonts.body1.copyWith(
                                                  color: Pallete.text,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              height: _getSize.height * 0.005,
                                            ),
                                            Row(
                                              children: [
                                                Image.asset(
                                                  AppImages.location,
                                                  height: 10,
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  requestData[index]
                                                      ['propertyLocation'],
                                                  style: AppFonts
                                                      .bodyThinColoured
                                                      .copyWith(
                                                          fontSize: 10,
                                                          color: Pallete.black),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: _getSize.height * 0.005,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Image.asset(
                                                  getIconAssetName(
                                                      requestData[index]
                                                          ['agent']),
                                                  width: requestData[index]
                                                                  ['agent'] !=
                                                              "Painter" ||
                                                          requestData[index]
                                                                  ['agent'] !=
                                                              "Carpenter"
                                                      ? _getSize.width * 0.04
                                                      : _getSize.width * 0.032,
                                                ),
                                                const SizedBox(
                                                  width: 12,
                                                ),
                                                SizedBox(
                                                  width: _getSize.width * 0.4,
                                                  child: Text(
                                                    requestData[index]
                                                        ['description'],
                                                    style: AppFonts.body1
                                                        .copyWith(
                                                            color: Pallete.fade,
                                                            fontSize: 12,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: _getSize.height * 0.01,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: _getSize.height * 0.01,
                                            ),
                                            Text(
                                              fd(requestData[index]['time']),
                                              style: AppFonts.body1.copyWith(
                                                color: Pallete.primaryColor,
                                                fontSize: 11,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: _getSize.height * 0.007,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : SizedBox(
                        height: _getSize.height * 0.05,
                      ))
            : emptyRequest(
                getSize: _getSize,
                text: "Received",
              ));
  }
}

class emptyRequest extends StatelessWidget {
  const emptyRequest({
    super.key,
    required Size getSize,
    required this.text,
  }) : _getSize = getSize;

  final Size _getSize;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
          color: const Color(0xFFF6F9F5),
          borderRadius: BorderRadius.circular(10)),
      width: _getSize.width,
      height: _getSize.height * 0.38,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              AppImages.noRequest,
              width: _getSize.width * 0.6,
            ),
            Column(
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 36),
                    children: <TextSpan>[
                      TextSpan(
                          text: "You currently have no ",
                          style: AppFonts.body1),
                      TextSpan(
                          text: "$text ",
                          style: AppFonts.boldText.copyWith(
                              color: Pallete.primaryColor, fontSize: 14)),
                      TextSpan(text: 'request', style: AppFonts.body1)
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: _getSize.height * 0.01,
            ),
          ],
        ),
      ),
    );
  }
}

_runFilter(String value) {}

class TabNavBar extends StatefulWidget {
  const TabNavBar({
    Key? key,
    required this.tabIndex,
    required this.tabTextList,
    required this.onTap,
  }) : super(key: key);

  final int tabIndex;
  final List<String> tabTextList;
  final Function(int)? onTap;

  @override
  _TabNavBarState createState() => _TabNavBarState();
}

class _TabNavBarState extends State<TabNavBar> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: 40,
      padding: EdgeInsets.symmetric(
        vertical: size.height * 0.00002,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: TabBar(
        physics: const BouncingScrollPhysics(),
        onTap: widget.onTap,
        indicatorColor: Colors.white,
        labelColor: Colors.white,
        unselectedLabelColor: Pallete.fade,
        indicator: BoxDecoration(
          color: Pallete.primaryColor,
          borderRadius: BorderRadius.circular(5),
        ),
        tabs: widget.tabTextList
            .map((tabText) => TabBarItem(
                  text: tabText,
                  count: widget.tabTextList.length,
                ))
            .toList(),
      ),
    );
  }
}

class TabBarItem extends StatelessWidget {
  const TabBarItem({
    Key? key,
    required this.count,
    required this.text,
  }) : super(key: key);

  final String text;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        text,
        style: GoogleFonts.montserrat(
          textStyle: TextStyle(
            fontSize: count == 5 ? 9 : 12,
          ),
        ),
      ),
    );
  }
}

filterPendingRequest(data) {
  List filteredData = data
      .where((obj) =>
          obj['isOwnerApproved'] == true && obj['status'] == "Pending")
      .toList();
  List<Map<String, dynamic>> sortedData =
      List.from(filteredData); // Copy the list
  sortedData.sort(
      (a, b) => DateTime.parse(b['time']).compareTo(DateTime.parse(a['time'])));
  return sortedData;
}

filterAcceptedRequest(data) {
  List filteredData = data.where((obj) => obj['status'] == "Accepted").toList();
  List<Map<String, dynamic>> sortedData =
      List.from(filteredData); // Copy the list
  sortedData.sort(
      (a, b) => DateTime.parse(b['time']).compareTo(DateTime.parse(a['time'])));
  return sortedData;
}

filterCompletedRequest(data) {
  List filteredData =
      data.where((obj) => obj['status'] == "Completed").toList();
  List<Map<String, dynamic>> sortedData =
      List.from(filteredData); // Copy the list
  sortedData.sort(
      (a, b) => DateTime.parse(b['time']).compareTo(DateTime.parse(a['time'])));
  return sortedData;
}

filterSenderRequest(data) {
  List filteredData = data
      .where((obj) =>
          obj['from'] == "tenant" && obj['isOwnerApproved'] == false)
      .toList();
  List<Map<String, dynamic>> sortedData =
      List.from(filteredData); // Copy the list
  sortedData.sort(
      (a, b) => DateTime.parse(b['time']).compareTo(DateTime.parse(a['time'])));
  return sortedData;
}

String formatTimeDifference(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);
  print(difference.inHours);
  if (difference.inDays > 0) {
    return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
  } else if (difference.inHours > 0) {
    return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
  } else if (difference.inSeconds > 0) {
    return '${difference.inSeconds} ${difference.inSeconds == 1 ? 'second' : 'seconds'} ago';
  } else {
    return 'Just now';
  }
}

String fd(time) {
  DateTime dateTime = DateTime.parse(time);
  String formattedTimeDifference = formatTimeDifference(dateTime);

  return formattedTimeDifference;
}
