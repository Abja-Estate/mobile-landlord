import 'package:abjalandlord/utils/property_util/delete_property_utils.dart';
import 'package:abjalandlord/views/request/widget/requestitems.dart';
import 'package:flutter/material.dart';
import 'package:image_stack/image_stack.dart';

import '../../../../components/buttons.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_fonts.dart';
import '../../../../constants/app_images.dart';
import '../../../../constants/app_routes.dart';
import '../../../../constants/resources.dart';
import 'main_page.dart';
import 'unit_content.dart';

class FullPropertyContent extends StatelessWidget {
  const FullPropertyContent({
    super.key,
    required Size getSize,
    required this.property,
    required this.unitCount,
    required this.propertyUnits,
    required this.request,
  }) : _getSize = getSize;

  final Size _getSize;
  final Map property;
  final int unitCount;
  final List request;
  final List propertyUnits;

  int getTenantCount(List<dynamic> unitData) {
    int tenantCount = 0;

    for (var unit in unitData) {
      if (unit.containsKey('tenantInfo')) {
        tenantCount++;
      }
    }

    return tenantCount;
  }

  List<String> getSelfieUrls(List<dynamic> unitData) {
    List<String> selfieUrls = [];

    for (var unit in unitData) {
      if (unit.containsKey('tenantInfo') &&
          unit['tenantInfo'].containsKey('selfie')) {
        selfieUrls.add(unit['tenantInfo']['selfie']);
      }
    }

    return selfieUrls;
  }

  @override
  Widget build(BuildContext context) {
    print(property['photo']);
    int tenantCount = getTenantCount(property['unitData']);
    List<String> selfieUrls = getSelfieUrls(property['unitData']);
    List tenantRequest = request
        .where((d) =>
            d["from"] == "tenant" && d["propertyName"] == property['name'])
        .toList();

    List propertyRequest =
        request.where((d) => d["propertyName"] == property['name']).toList();

    int m = property['unitData'].length;
    return Column(
      children: [
        SizedBox(
          height: _getSize.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.network(
                        height: _getSize.height * 0.25,
                        width: _getSize.width * 0.92,
                        property['photo'].toString(),
                        fit: BoxFit.fill),
                    property['structure'] != "Standalone"
                        ? Positioned(
                            left: _getSize.width * 0.08,
                            bottom: _getSize.height * 0.18,
                            child: Container(
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        137, 246, 249, 245),
                                    boxShadow: const [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(113, 246, 249, 245),
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
                                        horizontal: _getSize.height * 0.018),
                                    child: Row(
                                      children: [
                                        Text(
                                          property['unitData']
                                              .length
                                              .toString(),
                                          style: AppFonts.body1.copyWith(
                                            color: Pallete.primaryColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: _getSize.height * 0.018,
                                          ),
                                        ),
                                        SizedBox(width: _getSize.width * 0.01),
                                        Text("Unit",
                                            style: AppFonts.body1.copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: Pallete.primaryColor,
                                                fontSize:
                                                    _getSize.height * 0.018))
                                      ],
                                    ))),
                          )
                        : SizedBox(),
                    property['structure'] != "Standalone"
                        ? Positioned(
                            top: 130, // adjust position as needed
                            left: 30,
                            child: SizedBox(
                              width: _getSize.width * 0.8,
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: _getSize.height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          property['name'],
                          style: AppFonts.boldText.copyWith(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          property['created_at'],
                          style: AppFonts.body1,
                        )
                      ],
                    ),
                    SizedBox(
                      height: _getSize.height * 0.005,
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
                              property['structure'],
                              style: AppFonts.body1.copyWith(fontSize: 14),
                            )
                          ],
                        ),
                        SizedBox(
                          width: _getSize.width * 0.05,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star_rounded,
                              size: 18,
                              color: Color.fromARGB(255, 252, 212, 51),
                            ),
                            Text(
                              "4.7",
                              style: AppFonts.body1,
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: _getSize.height * 0.005,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(AppImages.location,
                                width: _getSize.width * 0.037),
                            SizedBox(
                              width: _getSize.width * 0.008,
                            ),
                            SizedBox(
                              width: _getSize.width * 0.55,
                              child: Text(
                                property['location'],
                                overflow: TextOverflow.ellipsis,
                                style: AppFonts.body1.copyWith(
                                    color: Pallete.fade,
                                    fontSize: _getSize.height * 0.016),
                              ),
                            )
                          ],
                        ),
                        // int.parse(property['unit']) == property["unitData"].length
                        property['structure'] == "Standalone"
                            ? GestureDetector(
                                onTap: () {
                                  var tenantInfo = {
                                    "propertyID": property['propertyID'],
                                    "unitID": property["unitData"][0]['unitID']
                                  };
                                  Navigator.of(context).pushNamed(
                                    AppRoutes.addTenant,
                                    arguments: {
                                      'tenant': tenantInfo,
                                    },
                                  );
                                },
                                child: !property["unitData"][0]['isTaken']
                                    ? Container(
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
                                      )
                                    : SizedBox())
                            : GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    AppRoutes.addMoreUnit,
                                    arguments: {
                                      'data': property,
                                    },
                                  );
                                },
                                child: m >= int.parse(property["unit"])
                                    ? SizedBox()
                                    : Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Color(0xFF91B88C),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 16),
                                          child: Text(
                                            "Add More Unit",
                                            style: AppFonts.smallWhiteBold
                                                .copyWith(
                                                    color:
                                                        Pallete.primaryColor),
                                          ),
                                        ),
                                      ))
                      ],
                    ),
                    SizedBox(
                      height: _getSize.height * 0.006,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Description",
                          style: AppFonts.boldText.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Pallete.text,
                              fontSize: 14),
                        ),
                        Text(
                          property['description'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppFonts.body1,
                        )
                      ],
                    ),
                    SizedBox(
                      height: _getSize.height * 0.015,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Features",
                          style: AppFonts.boldText.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Pallete.text,
                              fontSize: 14),
                        ),
                        SizedBox(
                          height: _getSize.height * 0.005,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                property['football']
                                    ? PropertyMainprops(
                                        type: "Football",
                                        width: _getSize.width * 0.025,
                                        img: AppImages.football)
                                    : Container(),
                                property['pool']
                                    ? PropertyMainprops(
                                        type: "Pool",
                                        width: _getSize.width * 0.025,
                                        img: AppImages.swim)
                                    : SizedBox(),
                                property['wifi']
                                    ? PropertyMainprops(
                                        width: _getSize.width * 0.025,
                                        type: "Wifi",
                                        img: AppImages.wifi)
                                    : Container(),
                                SizedBox(
                                  width: _getSize.width * 0.025,
                                ),
                                property['laundry']
                                    ? PropertyMainprops(
                                        type: "Laundry",
                                        width: _getSize.width * 0.025,
                                        img: AppImages.laundry)
                                    : Container(),
                                property['garden']
                                    ? PropertyMainprops(
                                        type: "Garden",
                                        width: _getSize.width * 0.025,
                                        img: AppImages.flower)
                                    : SizedBox(),
                              ],
                            ),
                            SizedBox(
                              height: _getSize.height * 0.012,
                            ),
                            Row(
                              children: [
                                property['fitness']
                                    ? PropertyMainprops(
                                        type: "Fitness",
                                        width: _getSize.width * 0.025,
                                        img: AppImages.weightlifting)
                                    : SizedBox(),
                                property['power']
                                    ? PropertyMainprops(
                                        type: "24 hrs Power",
                                        width: _getSize.width * 0.025,
                                        img: AppImages.power)
                                    : SizedBox(),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: _getSize.height * 0.015,
                    ),
                    Column(
                      children: [],
                    ),
                    SizedBox(
                      height: _getSize.height * 0.015,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          property['structure'] != "Standalone"
                              ? "Tenants"
                              : "Tenant",
                          style: AppFonts.boldText.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Pallete.text,
                              fontSize: 14),
                        ),
                        SizedBox(
                          height: _getSize.height * 0.005,
                        ),
                        selfieUrls.isNotEmpty
                            ? GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(AppRoutes.tenants);
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ImageStack(
                                      imageList: selfieUrls,
                                      backgroundColor:
                                          Color.fromARGB(49, 209, 209, 209),
                                      extraCountTextStyle: AppFonts.body1
                                          .copyWith(
                                              color: Pallete.primaryColor,
                                              fontWeight: FontWeight.w600),
                                      totalCount:
                                          tenantCount, // If larger than images.length, will show extra empty circle
                                      imageRadius: 45, // Radius of each images
                                      imageCount: tenantCount > 3
                                          ? 3
                                          : tenantCount, // Maximum number of images to be shown in stack
                                      imageBorderWidth:
                                          0.6, // Border width around the images
                                    ),
                                    Text(
                                      "See More",
                                      style: AppFonts.body1.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: Pallete.secondaryColor),
                                    )
                                  ],
                                ),
                              )
                            : Center(
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xFFC8DCC5),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "No Tenant has been added",
                                        style: AppFonts.body1.copyWith(
                                            color: Pallete.primaryColor),
                                      ),
                                    ))),
                      ],
                    ),
                    SizedBox(
                      height: _getSize.height * 0.025,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Units",
                              style: AppFonts.boldText.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Pallete.text,
                                  fontSize: 14),
                            ),
                            SizedBox(
                              width: _getSize.width * 0.015,
                            ),
                            Text(
                              "-  Click to enter into any unit",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppFonts.body1,
                            )
                          ],
                        ),   SizedBox(
                      height: _getSize.height * 0.005,
                    ),
                        SizedBox(
                          height: m < 4
                              ? _getSize.height * 0.05
                              : m < 7
                                  ? _getSize.height * 0.1
                                  : m >= 7
                                      ? _getSize.height * 0.15
                                      : _getSize.height * 0.19,
                          width: _getSize.width,
                          child: GridView.builder(
                              scrollDirection: Axis.vertical,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisExtent: 35,
                                childAspectRatio:
                                    1, // This value needs to be adjusted
                                crossAxisSpacing: 26,
                                mainAxisSpacing: 12,
                              ),
                              itemCount: m,
                              itemBuilder: (BuildContext ctx, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => UnitContent(
                                                getSize: _getSize,
                                                property: property,
                                                request: request,
                                                propertyUnits: propertyUnits,
                                                unitCount: index,
                                              )),
                                    );
                                    // if (property['unitData'][index]['isTaken']) {
                                    // } else {
                                    //   var tenantInfo = {
                                    //     "propertyID": property['propertyID'],
                                    //     "unitID": property['unitData'][index]
                                    //         ['unitID']
                                    //   };
                                    //   Navigator.of(context).pushNamed(
                                    //     AppRoutes.addTenant,
                                    //     arguments: {
                                    //       'tenant': tenantInfo,
                                    //     },
                                    //   );
                                    // }
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: property['unitData'][index]
                                                ['isTaken']
                                            ? Pallete.primaryColorVariant
                                            : Pallete.whiteColor,
                                        border: Border.all(
                                          width: 0.3,
                                          color: property['unitData'][index]
                                                  ['isTaken']
                                              ? Pallete.primaryColorVariant
                                              : Pallete.fade,
                                        ),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          // Image.asset(AppImages.agent,
                                          //     width: 16,
                                          //     color: property['unitData'][index]
                                          //             ['isTaken']
                                          //         ? Pallete.whiteColor
                                          //         : Pallete.primaryColorVariant),
                                          // const SizedBox(
                                          //   width: 4,
                                          // ),
                                          SizedBox(
                                            width: _getSize.width * 0.1,
                                            child: Text(
                                              property['unitData'][index]
                                                      ['nick'] ??
                                                  "Unit ${index + 1}",
                                              overflow: TextOverflow.ellipsis,
                                              style: AppFonts.bodyText.copyWith(
                                                  fontSize: 10,
                                                  color: property['unitData']
                                                          [index]['isTaken']
                                                      ? Pallete.whiteColor
                                                      : Pallete
                                                          .primaryColorVariant),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: _getSize.height * 0.025,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              style: AppFonts.body1
                                  .copyWith(color: Pallete.secondaryColor),
                            )
                          ],
                        ),
                        SizedBox(
                          height: _getSize.height * 0.010,
                        ),
                        SizedBox(
                            height: _getSize.height * 0.1,
                            child: propertyRequest.isNotEmpty
                                ? ListView.builder(
                                    itemCount: propertyRequest.length,
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 6.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              getIconAssetName(
                                                  propertyRequest[index]
                                                      ['agent']),
                                              width: 24,
                                            ),
                                            SizedBox(
                                              width: _getSize.width * 0.03,
                                            ),
                                            Text(
                                              propertyRequest[index]['agent'],
                                              style: AppFonts.bodyText.copyWith(
                                                fontSize: 12,
                                                color: Pallete.text,
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
                                                BorderRadius.circular(5)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "No Repair has been done",
                                            style: AppFonts.body1.copyWith(
                                                color: Pallete.primaryColor),
                                          ),
                                        ))))
                      ],
                    ),
                    SizedBox(
                      height: _getSize.height * 0.025,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              style: AppFonts.body1
                                  .copyWith(color: Pallete.secondaryColor),
                            )
                          ],
                        ),
                        SizedBox(
                            height: _getSize.height * 0.09,
                            child: tenantRequest.isNotEmpty
                                ? ListView.builder(
                                    itemCount: tenantRequest.length,
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 6.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              getIconAssetName(
                                                  tenantRequest[index]
                                                      ['agent']),
                                              width: 24,
                                            ),
                                            SizedBox(
                                              width: _getSize.width * 0.03,
                                            ),
                                            SizedBox(
                                              width: _getSize.width * 0.75,
                                              child: RichText(
                                                text: TextSpan(
                                                  style: DefaultTextStyle.of(
                                                          context)
                                                      .style,
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: tenantRequest[index]
                                                          ['agent'],
                                                      style: const TextStyle(
                                                        color: Colors
                                                            .black, // Replace with Pallete.black if defined
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const TextSpan(
                                                      text: ' - ',
                                                      style: TextStyle(
                                                        color: Colors
                                                            .grey, // Replace with Pallete.fade if defined
                                                        fontSize: 10,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          ' ${request[index]['fullName']} - ${request[index]['description']}',
                                                      style: const TextStyle(
                                                        color: Pallete
                                                            .text, // Replace with Pallete.fade if defined
                                                        fontSize: 11,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 24),
                                          ],
                                        ),
                                      );
                                    })
                                : Center(
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: Color(0xFFC8DCC5),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "No Tenant has made a request",
                                            style: AppFonts.body1.copyWith(
                                                color: Pallete.primaryColor),
                                          ),
                                        ))))
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: _getSize.height * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          DeletePropertyUtil.delete(
                              context, property['propertyID']);
                        },
                        child: Container(
                          height: _getSize.height * 0.05,
                          decoration: BoxDecoration(
                            color: Color(0xFFFCEBEB),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                AppImages.dustbin,
                                color: Color(0xFFE23A3B),
                                width: 18,
                              ),
                              SizedBox(
                                width: _getSize.width * 0.03,
                              ),
                              Text(
                                "Delete Property",
                                style: AppFonts.bodyText.copyWith(
                                    color: Color(0xFFE23A3B),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: _getSize.height * 0.015,
                      ),
                      ButtonWithFuction(
                          text: "Request Service Provider",
                          onPressed: () {
                            var noTenantData = {
                              "tenantPhoto": property["photo"],
                              "location": property["location"],
                              "tenantUnit": property["propertyID"],
                              "fullName": "",
                              "email": "",
                              "phone": "",
                              "propertyName": property["name"],
                              "propertyStructure": property["structure"],
                            };

                            Navigator.of(context).pushNamed(
                                AppRoutes.createRequest,
                                arguments: {"property": noTenantData});
                          }),
                      SizedBox(
                        height: _getSize.height * 0.15,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
