import 'dart:convert';

import 'package:abjalandlord/components/buttons.dart';
import 'package:abjalandlord/utils/request_util/update_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_fonts.dart';
import '../../../constants/app_images.dart';
import '../../../provider/websocket_provider.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/local_storage.dart';
import '../../dashboard/dashboard.dart';
import '../../navbar/nav.dart';
import '../request.dart';
import '../widget/bottom_modal.dart';
import '../widget/requestitems.dart';

class ViewRequest extends StatefulWidget {
  const ViewRequest({Key? key}) : super(key: key);

  @override
  _ViewRequestState createState() => _ViewRequestState();
}

class _ViewRequestState extends State<ViewRequest> {
  var requestData;
  var photo = 'https://i.pravatar.cc/300';
  late WebSocketProvider webSocketProvider;
  var landlordID = '';
  getData() async {
    landlordID = await showId();
  }

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<WebSocketProvider>(context, listen: false).init();
      webSocketProvider =
          Provider.of<WebSocketProvider>(context, listen: false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataFromRoute = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    requestData = dataFromRoute['data'];
    print(requestData);
    final _getSize = MediaQuery.of(context).size;
    DateTime dateTime = DateTime.parse(requestData['time']);
    String formattedTimeDifference = formatTimeDifference(dateTime);

    return Scaffold(
      backgroundColor: Color(0xFFF6F9F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NavBar(
                                    initialScreen: RequestScreen(),
                                    initialTab: 1)),
                            (route) => false,
                          );
                        },
                        child: Image.asset(
                          AppImages.back,
                          width: 36,
                        ),
                      ),
                      Text("Request Details"),
                      SizedBox(
                        width: 24,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: _getSize.height * 0.045,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, bottom: 8, right: 8, left: 4),
                  child: Container(
                    height: _getSize.height * 0.1,
                    width: _getSize.width,
                    decoration: BoxDecoration(
                        color: getIconAssetColor(requestData['agent']),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(44, 85, 80, 80),
                            blurRadius: 11,
                            spreadRadius: 1,
                            offset: Offset(0, 5),
                          )
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2.0, horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: Image.network(
                              requestData['agentPhoto'] ?? photo,
                              fit: BoxFit.cover,
                              width: 52,
                              height: 52,
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          SizedBox(
                            width: _getSize.width * 0.67,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: _getSize.height * 0.005,
                                    ),
                                    Text(
                                      requestData['servicePersonnelName'] ??
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
                                          getIconAssetName(
                                              requestData['agent']),
                                          width: requestData['agent'] ==
                                                      "Painter" ||
                                                  requestData['agent'] ==
                                                      "Carpenter"
                                              ? _getSize.width * 0.035
                                              : _getSize.width * 0.045,
                                        ),
                                        SizedBox(
                                          width: 12,
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          requestData['agent'],
                                          style: AppFonts.bodyThinColoured
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
                                        SizedBox(
                                          width: _getSize.width * 0.4,
                                          child: Text(
                                            requestData['description'],
                                            style: AppFonts.body1.copyWith(
                                                color: Pallete.fade,
                                                fontSize: 12,
                                                overflow: TextOverflow.ellipsis,
                                                fontWeight: FontWeight.w500),
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
                                      fd(requestData['time']),
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
                        ],
                      ),
                    ),
                  ),
                ),
                requestData['servicePersonnelPhone'] != ""
                    ? GestureDetector(
                      onTap: () {
                         _callNumber(requestData['servicePersonnelPhone']);
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: _getSize.height * 0.05,
                            ),
                            Center(
                              child: Container(
                                width: _getSize.width * 0.4,
                                decoration: BoxDecoration(
                                    color: Pallete.primaryColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        AppImages.calls,
                                        width: 24,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Call  ",
                                            style: AppFonts.smallWhiteBold,
                                          ),
                                          Text(
                                            requestData['servicePersonnelName']??"",
                                            style: AppFonts.smallWhiteBold
                                                .copyWith(
                                                    color: Pallete.whiteColor,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w300),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                    )
                    : SizedBox(),
                SizedBox(
                  height: _getSize.height * 0.05,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(),
                      Container(
                        decoration: BoxDecoration(
                            color: requestData['status'] == "Pending"
                                ? Color(0xFFFCE1BA)
                                : Color(0xFFC8DCC6),
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: _getSize.width * 0.014,
                                height: _getSize.height * 0.007,
                                decoration: BoxDecoration(
                                    color: requestData['status'] == "Pending"
                                        ? Color(0xFFF29B18)
                                        : Colors.green,
                                    borderRadius: BorderRadius.circular(100)),
                              ),
                              SizedBox(
                                width: _getSize.width * 0.01,
                              ),
                              Text(
                                requestData['status'],
                                style: AppFonts.body1.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: requestData['status'] == "Pending"
                                        ? Color(0xFFF29B18)
                                        : Colors.green),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: _getSize.height * 0.025,
                ),
                Row(
                  children: [
                    Text(
                      "Service needed:",
                      style: AppFonts.bodyText.copyWith(
                          color: Pallete.text,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: _getSize.width * 0.25,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          getIconAssetName(requestData['agent']),
                          width: requestData['agent'] == "Painter" ||
                                  requestData['agent'] == "Carpenter"
                              ? _getSize.width * 0.055
                              : _getSize.width * 0.065,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          requestData['agent'],
                          style: AppFonts.body1.copyWith(
                              color: Pallete.text,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: _getSize.height * 0.025,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Request:",
                      style: AppFonts.bodyText.copyWith(
                          color: Pallete.text,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: _getSize.height * 0.008,
                    ),
                    SizedBox(
                        height: requestData['problems'].length == 1
                            ? _getSize.height * 0.055
                            : requestData['problems'].length == 2
                                ? _getSize.height * 0.115
                                : _getSize.height * 0.07,
                        width: _getSize.width,
                        child: ListView.builder(
                            itemCount: requestData['problems'].length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Container(
                                    decoration: const BoxDecoration(
                                        color: Pallete.whiteColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 8),
                                      child:
                                          Text(requestData['problems'][index]),
                                    )),
                              );
                            }))
                  ],
                ),
                SizedBox(
                  height: _getSize.height * 0.025,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Request Description",
                      style: AppFonts.bodyText.copyWith(
                          color: Pallete.text,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: _getSize.height * 0.005,
                    ),
                    Text(
                      requestData['description'],
                      style: AppFonts.body1.copyWith(
                        color: Pallete.text,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: _getSize.height * 0.025,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Timeline:",
                      style: AppFonts.bodyText.copyWith(
                          color: Pallete.text,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: _getSize.height * 0.005,
                    ),
                    SizedBox(
                      width: _getSize.width * 0.45,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                AppImages.calender2,
                                width: 24,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                requestData['day'],
                                style: AppFonts.body1.copyWith(
                                  color: Pallete.text,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: _getSize.height * 0.015,
                          ),
                          SizedBox(
                            width: _getSize.width * 0.6,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.alarm),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      requestData['period'],
                                      style: AppFonts.body1.copyWith(
                                        color: Pallete.text,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: _getSize.height * 0.025,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Contact:",
                      style: AppFonts.bodyText.copyWith(
                          color: Pallete.text,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: _getSize.height * 0.005,
                    ),
                    SizedBox(
                      width: _getSize.width * 0.45,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                AppImages.call,
                                width: 24,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                requestData['phone'],
                                style: AppFonts.body1.copyWith(
                                  color: Pallete.text,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: _getSize.height * 0.015,
                          ),
                          Row(
                            children: [
                              Image.asset(
                                AppImages.inboxFilled,
                                width: 24,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              SizedBox(
                                width: _getSize.width * 0.35,
                                child: Text(
                                  requestData['email'],
                                  overflow: TextOverflow.ellipsis,
                                  style: AppFonts.body1.copyWith(
                                    color: Pallete.text,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: _getSize.height * 0.045,
                ),
                requestData['from'] == "tenant" &&
                        !requestData['isLandlordApproved']
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ButtonWithFuction(
                            text: 'Forward Request',
                            onPressed: () async {
                              await saveToken(false);
                              requestData['from'] = "landlord-admin";
                              Map<String, dynamic> data = {
                                "target_id": "abja2024Admin",
                                "message": jsonEncode(requestData),
                                "sender_id": landlordID
                              };
                              print(data);

                              AppUtils.showLoader(context);
                              webSocketProvider.sendMessage(jsonEncode(data));
                              await Future.delayed(Duration(seconds: 2));
                              var m = await showToken();
                              setState(() {});
                              print(m);
                              Navigator.of(context).pop();
                              if (m) {
                                requestData['from'] = "tenant";
                                UpdateRequestUtil.update(
                                    context, requestData['ticket']);
                                showModalBottomSheet(
                                  context: context,
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  builder: (BuildContext context) {
                                    return const ReusableBottomSheetContent();
                                  },
                                ).then((value) {
                                  // This block will be executed when the bottom sheet is dismissed
                                  if (value == null) {
                                    // User dismissed the bottom sheet by clicking outside

                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => NavBar(
                                                initialScreen: RequestScreen(),
                                                initialTab: 1,
                                              )),
                                      (route) => false,
                                    );
                                  }
                                });
                              } else {
                                // ignore: use_build_context_synchronously
                                AppUtils.ErrorDialog(
                                  context,
                                  'Request Failed',
                                  "Your request failed to deliver",
                                  'Try Again',
                                  const Icon(
                                    Icons.error_rounded,
                                    color: Color.fromARGB(255, 213, 10, 10),
                                    size: 30,
                                  ),
                                );
                              }
                            }),
                      )
                    : SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

_callNumber(String number) async {
  //set the number here
  await FlutterPhoneDirectCaller.callNumber(number);
}
