import 'package:abjalandlord/views/request/widget/requestitems.dart';
import 'package:flutter/material.dart';

import '../../../../components/buttons.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_fonts.dart';
import '../../../../constants/app_images.dart';
import '../../../../constants/app_routes.dart';

class UnitContent extends StatefulWidget {
  const UnitContent({
    super.key,
    required Size getSize,
    required this.property,
    required this.propertyUnits,
    required this.unitCount,
    required this.request,
  }) : _getSize = getSize;

  final Size _getSize;
  final Map property;
  final List propertyUnits;
  final List request;
  final int unitCount;

  @override
  State<UnitContent> createState() => _UnitContentState();
}

class _UnitContentState extends State<UnitContent> {
  @override
  Widget build(BuildContext context) {
    List unitRequest = widget.request
        .where((d) =>
            d['tenantUnit'] == widget.propertyUnits[widget.unitCount]['unitID'])
        .toList();
    List tenantRequest = widget.request
        .where((d) =>
            d['tenantUnit'] ==
                widget.propertyUnits[widget.unitCount]['unitID'] &&
            d['from'] == "tenant")
        .toList();
    return PopScope(
      onPopInvoked: ((didPop) => Navigator.of(context).pushNamed(
                                AppRoutes.propDetails,
                                arguments: {
                                  'data': widget.property['propertyID'],
                                  "requests": widget.request
                                },
                              )),
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            height: widget._getSize.height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                AppRoutes.propDetails,
                                arguments: {
                                  'data': widget.property['propertyID'],
                                  "requests": widget.request
                                },
                              );
                            },
                            child: Image.asset(
                              AppImages.back,
                              width: 36,
                            ),
                          ),
                          const Text("Unit Details"),
                          const Text("")
                        ],
                      ),
                    ),
                  ),
                 
                  Column(
                    children: [
                      SizedBox(
                        height: widget._getSize.height * 0.025,
                      ),
                      Stack(
                        children: [
                          Image.network(
                              height: widget._getSize.height * 0.25,
                              width: widget._getSize.width * 0.92,
                              widget.propertyUnits[widget.unitCount]['photo']
                                  .toString(),
                              fit: BoxFit.fill),
                          Positioned(
                            left: widget._getSize.width * 0.08,
                            bottom: widget._getSize.height * 0.18,
                            child: Container(
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(137, 246, 249, 245),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color.fromARGB(113, 246, 249, 245),
                                        blurRadius: 11,
                                        spreadRadius: 2,
                                        offset: Offset(0, 5),
                                      )
                                    ],
                                    border: Border.all(
                                        width: 0.3, color: Pallete.fade),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5))),
                                child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8.0,
                                        horizontal:
                                            widget._getSize.height * 0.018),
                                    child: Column(
                                      children: [
                                        !widget.propertyUnits[widget.unitCount]
                                                ['isTaken']
                                            ? Text(
                                                "Available",
                                                style: AppFonts.smallWhiteBold
                                                    .copyWith(
                                                        color:
                                                            Pallete.primaryColor),
                                              )
                                            : Text(
                                                "Occupied",
                                                style: AppFonts.smallWhiteBold
                                                    .copyWith(color: Colors.red),
                                              ),
                                      ],
                                    ))),
                          ),
                          widget.property['structure'] != "Standalone"
                              ? Positioned(
                                  top: 130, // adjust position as needed
                                  left: 30,
                                  child: SizedBox(
                                    width: widget._getSize.width * 0.8,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [],
                                    ),
                                  ),
                                )
                              : Text(''),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: widget._getSize.height * 0.025,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.propertyUnits[widget.unitCount]['nick'],
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppFonts.body1.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Pallete.primaryColorVariant),
                                )
                              ],
                            ),
                            SizedBox(
                              height: widget._getSize.height * 0.005,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.property['name'],
                                  style: AppFonts.boldText.copyWith(
                                      fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  widget.property['created_at'],
                                  style: AppFonts.body1,
                                )
                              ],
                            ),
                            SizedBox(
                              height: widget._getSize.height * 0.005,
                            ),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      AppImages.estate,
                                      width: 18,
                                      color: Pallete.primaryColor,
                                    ),
                                    Text(
                                      widget.property['structure'],
                                      style:
                                          AppFonts.body1.copyWith(fontSize: 14),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: widget._getSize.height * 0.005,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(AppImages.location,
                                        width: widget._getSize.width * 0.037),
                                    SizedBox(
                                      width: widget._getSize.width * 0.008,
                                    ),
                                    SizedBox(
                                      width: widget._getSize.width * 0.55,
                                      child: Text(
                                        widget.property['location'],
                                        overflow: TextOverflow.ellipsis,
                                        style: AppFonts.body1.copyWith(
                                            color: Pallete.fade,
                                            fontSize:
                                                widget._getSize.height * 0.016),
                                      ),
                                    )
                                  ],
                                ),
                                !widget.propertyUnits[widget.unitCount]['isTaken']
                                    ? GestureDetector(
                                        onTap: () {
                                          var tenantInfo = {
                                            "propertyID":
                                                widget.property['propertyID'],
                                            "unitID": widget.propertyUnits[
                                                widget.unitCount]['unitID']
                                          };
                                          Navigator.of(context).pushNamed(
                                            AppRoutes.addTenant,
                                            arguments: {
                                              'tenant': tenantInfo,
                                            },
                                          );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Color(0xFF91B88C),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0, horizontal: 16),
                                            child: Text(
                                              "Add Tenant",
                                              style: AppFonts.smallWhiteBold
                                                  .copyWith(
                                                      color:
                                                          Pallete.primaryColor),
                                            ),
                                          ),
                                        ),
                                      )
                                    : SizedBox()
                              ],
                            ),
                            SizedBox(
                              height: widget._getSize.height * 0.012,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Description",
                                  style: AppFonts.boldText.copyWith(
                                      fontWeight: FontWeight.w300,
                                      color: Pallete.text,
                                      fontSize: 14),
                                ),
                                Text(
                                  widget.property['description'],
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppFonts.body1,
                                )
                              ],
                            ),
                            SizedBox(
                              height: widget._getSize.height * 0.015,
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: widget._getSize.height * 0.015,
                                ),
                                Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              AppImages.bedroom,
                                              width: 24,
                                            ),
                                            SizedBox(
                                              width: widget._getSize.width * 0.01,
                                            ),
                                            Text(widget.propertyUnits[
                                                widget.unitCount]['bedroom'])
                                          ],
                                        ),
                                        SizedBox(
                                          height: widget._getSize.height * 0.001,
                                        ),
                                        Text(
                                          "Bedroom",
                                          style: AppFonts.bodyText
                                              .copyWith(fontSize: 12),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: widget._getSize.width * 0.05,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              AppImages.toilet,
                                              width: 24,
                                            ),
                                            SizedBox(
                                              width: widget._getSize.width * 0.01,
                                            ),
                                            Text(
                                              widget.propertyUnits[
                                                  widget.unitCount]['toilet'],
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: widget._getSize.height * 0.001,
                                        ),
                                        Text(
                                          "Toilet",
                                          style: AppFonts.bodyText
                                              .copyWith(fontSize: 12),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: widget._getSize.width * 0.05,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              AppImages.bathroom,
                                              width: 24,
                                            ),
                                            SizedBox(
                                              width: widget._getSize.width * 0.01,
                                            ),
                                            Text(widget.propertyUnits[
                                                widget.unitCount]['bathroom'])
                                          ],
                                        ),
                                        SizedBox(
                                          height: widget._getSize.height * 0.001,
                                        ),
                                        Text(
                                          "Bathroom",
                                          style: AppFonts.bodyText
                                              .copyWith(fontSize: 12),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: widget._getSize.width * 0.05,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              AppImages.store,
                                              width: 24,
                                            ),
                                            SizedBox(
                                              width: widget._getSize.width * 0.01,
                                            ),
                                            Text(widget.propertyUnits[
                                                widget.unitCount]['store'])
                                          ],
                                        ),
                                        SizedBox(
                                          height: widget._getSize.height * 0.001,
                                        ),
                                        Text(
                                          "Store",
                                          style: AppFonts.bodyText
                                              .copyWith(fontSize: 12),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: widget._getSize.width * 0.05,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              AppImages.nepa,
                                              width: 24,
                                            ),
                                            SizedBox(
                                              width: widget._getSize.width * 0.01,
                                            ),
                                            Text(widget.propertyUnits[
                                                widget.unitCount]['waterMeter'])
                                          ],
                                        ),
                                        SizedBox(
                                          height: widget._getSize.height * 0.001,
                                        ),
                                        Text(
                                          "Water Meter No.",
                                          style: AppFonts.bodyText
                                              .copyWith(fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: widget._getSize.height * 0.005,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          AppImages.nepa,
                                          width: 24,
                                        ),
                                        SizedBox(
                                          width: widget._getSize.width * 0.01,
                                        ),
                                        Text(
                                            widget.propertyUnits[widget.unitCount]
                                                ['lightMeter'])
                                      ],
                                    ),
                                    SizedBox(
                                      height: widget._getSize.height * 0.003,
                                    ),
                                    Text(
                                      "Light Meter No.",
                                      style: AppFonts.bodyText
                                          .copyWith(fontSize: 12),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: widget._getSize.height * 0.015,
                                    ),
                                    Text(
                                      "Features",
                                      style: AppFonts.boldText.copyWith(
                                          fontWeight: FontWeight.w300,
                                          color: Pallete.text,
                                          fontSize: 14),
                                    ),
                                    SizedBox(
                                      height: widget._getSize.height * 0.005,
                                    ),
                                    Row(
                                      children: [
                                        widget.propertyUnits[widget.unitCount]
                                                ['wifi']
                                            ? Row(
                                                children: [
                                                  Image.asset(
                                                    AppImages.wifi,
                                                    width: 20,
                                                  ),
                                                  SizedBox(
                                                    width: widget._getSize.width *
                                                        0.015,
                                                  ),
                                                  Text(
                                                    "Wifi",
                                                    style: AppFonts.body1,
                                                  ),
                                                  SizedBox(
                                                    width: widget._getSize.width *
                                                        0.02,
                                                  ),
                                                ],
                                              )
                                            : SizedBox(),
                                        widget.propertyUnits[widget.unitCount]
                                                ['power']
                                            ? Row(
                                                children: [
                                                  Image.asset(
                                                    AppImages.power,
                                                    width: 24,
                                                  ),
                                                  SizedBox(
                                                    width: widget._getSize.width *
                                                        0.005,
                                                  ),
                                                  Text(
                                                    "24hrs Power",
                                                    style: AppFonts.body1,
                                                  )
                                                ],
                                              )
                                            : SizedBox()
                                      ],
                                    )
                                  ],
                                ),
                                widget.propertyUnits[widget.unitCount]['isTaken']
                                    ? GestureDetector(
                                        onTap: () {
                                          var tenantInfoData = widget
                                                  .propertyUnits[widget.unitCount]
                                              ['tenantInfo'];
                                          tenantInfoData['lightMeter'] = widget
                                                  .propertyUnits[widget.unitCount]
                                              ['lightMeter'];
                                          tenantInfoData['waterMeter'] = widget
                                                  .propertyUnits[widget.unitCount]
                                              ['waterMeter'];
                                          tenantInfoData['propertyName'] =
                                              widget.property['name'];
                                          tenantInfoData['propertyLocation'] =
                                              widget.property['location'];
                                          print(widget
                                              .propertyUnits[widget.unitCount]);
                                          Navigator.of(context).pushNamed(
                                            AppRoutes.tenantsProfile,
                                            arguments: {
                                              'tenant': tenantInfoData,
                                            },
                                          );
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height:
                                                  widget._getSize.height * 0.015,
                                            ),
                                            Text(
                                              "Tenant",
                                              style: AppFonts.boldText.copyWith(
                                                  fontWeight: FontWeight.w300,
                                                  color: Pallete.text,
                                                  fontSize: 14),
                                            ),
                                            SizedBox(
                                              height:
                                                  widget._getSize.height * 0.005,
                                            ),
                                            Row(
                                              children: [
                                                ClipOval(
                                                  child: Image.network(
                                                    widget.propertyUnits[
                                                            widget.unitCount]
                                                        ['tenantInfo']['selfie'],
                                                    width: widget._getSize.width *
                                                        0.14,
                                                    height:
                                                        widget._getSize.height *
                                                            0.065,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: widget._getSize.width *
                                                      0.03,
                                                ),
                                                Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        width: widget
                                                                ._getSize.width *
                                                            0.7,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              ' ${widget.propertyUnits[widget.unitCount]['tenantInfo']['name']} ${widget.propertyUnits[widget.unitCount]['tenantInfo']['surname']}',
                                                              style: AppFonts
                                                                  .boldText
                                                                  .copyWith(
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400),
                                                            ),
                                                            Text(
                                                              "20 June 2023",
                                                              style: AppFonts
                                                                  .body1
                                                                  .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: widget
                                                                ._getSize.width *
                                                            0.25,
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6),
                                                          color:
                                                              Color(0xFFC8DCC5),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 4.0,
                                                                  horizontal: 8),
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                height: 5,
                                                                width: 5,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                100),
                                                                    color: Color(
                                                                        0xFF47893F)),
                                                              ),
                                                              SizedBox(
                                                                width: widget
                                                                        ._getSize
                                                                        .width *
                                                                    0.025,
                                                              ),
                                                              Text(
                                                                "Paid",
                                                                style: AppFonts
                                                                    .smallWhiteBold
                                                                    .copyWith(
                                                                        color: Color(
                                                                            0xFF47893F)),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ]),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(
                                        margin: EdgeInsets.only(bottom: 8),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        width: widget._getSize.width,
                                        height: widget._getSize.height * 0.3,
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Column(
                                                children: [
                                                  Image.asset(
                                                    AppImages.noTenant,
                                                    width: widget._getSize.width *
                                                        0.5,
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        widget._getSize.height *
                                                            0.007,
                                                  ),
                                                  Text(
                                                    "No tenants in this unit",
                                                    style: AppFonts.body1
                                                        .copyWith(
                                                            color: Pallete.text,
                                                            fontSize: 14),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                SizedBox(
                                  height: widget._getSize.height * 0.025,
                                ),
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Total Service Requests",
                                          style: AppFonts.boldText.copyWith(
                                              fontWeight: FontWeight.w400,
                                              color: Pallete.text,
                                              fontSize: 14),
                                        ),
                                        Text(
                                          "View Details",
                                          style: AppFonts.body1.copyWith(
                                              color: Pallete.secondaryColor),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: widget._getSize.height * 0.005,
                                    ),
                                    SizedBox(
                                        height: widget._getSize.height * 0.1,
                                        child: unitRequest.isNotEmpty
                                            ? ListView.builder(
                                                itemCount: unitRequest.length,
                                                physics: BouncingScrollPhysics(),
                                                scrollDirection: Axis.vertical,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 6.0),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Image.asset(
                                                          getIconAssetName(
                                                              unitRequest[index]
                                                                  ['agent']),
                                                          width: 24,
                                                        ),
                                                        SizedBox(
                                                          width: widget._getSize
                                                                  .width *
                                                              0.03,
                                                        ),
                                                        SizedBox(
                                                          width: widget._getSize
                                                                  .width *
                                                              0.7,
                                                          child: Text(
                                                            unitRequest[index]
                                                                ["agent"],
                                                            maxLines: 2,
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                            style: AppFonts
                                                                .bodyText
                                                                .copyWith(
                                                              fontSize: 12,
                                                              color: Pallete.text,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                })
                                            : Center(
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Color(0xFFC8DCC5),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                5)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        "No Repair has been done",
                                                        style: AppFonts.body1
                                                            .copyWith(
                                                                color: Pallete
                                                                    .primaryColor),
                                                      ),
                                                    )))),
                                    SizedBox(
                                      height: widget._getSize.height * 0.025,
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Tenant Requests",
                                              style: AppFonts.boldText.copyWith(
                                                  fontWeight: FontWeight.w400,
                                                  color: Pallete.text,
                                                  fontSize: 14),
                                            ),
                                            Text(
                                              "View Details",
                                              style: AppFonts.body1.copyWith(
                                                  color: Pallete.secondaryColor),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                            height: widget._getSize.height * 0.09,
                                            child: tenantRequest.isNotEmpty
                                                ? ListView.builder(
                                                    itemCount:
                                                        tenantRequest.length,
                                                    physics:
                                                        const BouncingScrollPhysics(),
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Padding(
                                                        padding: const EdgeInsets
                                                            .symmetric(
                                                            vertical: 6.0),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Image.asset(
                                                              getIconAssetName(
                                                                  tenantRequest[
                                                                          index]
                                                                      ['agent']),
                                                              width: 24,
                                                            ),
                                                            SizedBox(
                                                              width: widget
                                                                      ._getSize
                                                                      .width *
                                                                  0.03,
                                                            ),
                                                            SizedBox(
                                                              width: widget
                                                                      ._getSize
                                                                      .width *
                                                                  0.75,
                                                              child: RichText(
                                                                text: TextSpan(
                                                                  style: DefaultTextStyle.of(
                                                                          context)
                                                                      .style,
                                                                  children: <TextSpan>[
                                                                    TextSpan(
                                                                      text: tenantRequest[
                                                                              index]
                                                                          [
                                                                          'agent'],
                                                                      style:
                                                                          const TextStyle(
                                                                        color: Colors
                                                                            .black, // Replace with Pallete.black if defined
                                                                        fontSize:
                                                                            11,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                      ),
                                                                    ),
                                                                    const TextSpan(
                                                                      text: ' - ',
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .grey, // Replace with Pallete.fade if defined
                                                                        fontSize:
                                                                            10,
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                      ),
                                                                    ),
                                                                    TextSpan(
                                                                      text:
                                                                          ' ${widget.request[index]['fullName']} - ${widget.request[index]['description']}',
                                                                      style:
                                                                          const TextStyle(
                                                                        color: Pallete
                                                                            .text, // Replace with Pallete.fade if defined
                                                                        fontSize:
                                                                            11,
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                width: 24),
                                                          ],
                                                        ),
                                                      );
                                                    })
                                                : Center(
                                                    child: Container(
                                                        decoration: BoxDecoration(
                                                            color:
                                                                Color(0xFFC8DCC5),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(5)),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            "This Tenant has not made any request",
                                                            style: AppFonts.body1
                                                                .copyWith(
                                                                    color: Pallete
                                                                        .primaryColor),
                                                          ),
                                                        ))))
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: widget._getSize.height * 0.0005,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: widget._getSize.height * 0.015,
                        ),
                        ButtonWithFuction(
                            text: "Request Service Provider",
                            onPressed: () {
                              if (widget.propertyUnits[widget.unitCount]
                                  ['isTaken']) {
                                var tenantData = {
                                  "tenantPhoto": widget.property["unitData"]
                                      [widget.unitCount]["tenantInfo"]['selfie'],
                                  "location": widget.property["location"],
                                  "tenantUnit": widget.property["unitData"]
                                      [widget.unitCount]["unitID"],
                                  "email": widget.property["unitData"]
                                      [widget.unitCount]["tenantInfo"]['email'],
                                  "phone": widget.property["unitData"]
                                      [widget.unitCount]["tenantInfo"]['phone'],
                                  "fullName":
                                      "${widget.property["unitData"][widget.unitCount]["tenantInfo"]['name']} ${widget.property["unitData"][widget.unitCount]["tenantInfo"]['surname']}",
                                  "propertyName": widget.property["name"],
                                  "propertyStructure":
                                      widget.property["structure"],
                                };
                                print("Somebody is here$tenantData");
                                Navigator.of(context).pushNamed(
                                    AppRoutes.createRequest,
                                    arguments: {"property": tenantData});
                              } else {
                                var noTenantData = {
                                  "tenantPhoto": widget.property["photo"],
                                  "location": widget.property["location"],
                                  "tenantUnit": widget.property["unitData"]
                                      [widget.unitCount]["unitID"],
                                  "fullName": "",
                                  "email": "",
                                  "phone": "",
                                  "propertyName": widget.property["name"],
                                  "propertyStructure":
                                      widget.property["structure"],
                                };
                                print("Nobody is here$noTenantData");
                                Navigator.of(context).pushNamed(
                                    AppRoutes.createRequest,
                                    arguments: {"property": noTenantData});
                              }
                            }),
                        SizedBox(
                          height: widget._getSize.height * 0.05,
                        ),
                      ],
                    ),
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
