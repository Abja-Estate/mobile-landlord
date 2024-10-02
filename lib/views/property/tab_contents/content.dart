import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_fonts.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_routes.dart';

class tabContent extends StatelessWidget {
  tabContent(
      {super.key,
      required Size getSize,
      required this.items,
      required this.type,
      required this.requests,
      required this.propertyData})
      : _getSize = getSize;

  final Size _getSize;
  final int items;
  final String type;
  List requests;
  List propertyData;

  /**
   *     PersistentNavBarNavigator.pushNewScreen(
        context,
        screen: MainScreen(),
        withNavBar: true, // OPTIONAL VALUE. True by default.
        pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
   */
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: _getSize.height * 0.25,
        child: propertyData.isEmpty
            ? Container(
                margin: EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                    color: Color(0xFFF6F9F5),
                    borderRadius: BorderRadius.circular(10)),
                width: _getSize.width,
                height: _getSize.height * 0.38,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset(
                        AppImages.no_prop,
                        width: _getSize.width * 0.6,
                      ),
                      Column(
                        children: [
                          Text(
                            "You currently have no $type property",
                            style: AppFonts.body1,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: _getSize.height * 0.01,
                      ),
                    ],
                  ),
                ),
              )
            : ListView.builder(
                itemCount: propertyData.length + 1,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) => (index != propertyData.length)
                    ? GestureDetector(
                        onTap: () => Navigator.of(context).pushNamed(
                          AppRoutes.propDetails,
                          arguments: {
                            'data': propertyData[index]['propertyID'],
                            "requests": requests
                          },
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Image.network(
                                    propertyData[index]['photo'],
                                    fit: BoxFit.cover,
                                    width: _getSize.width * 0.45,
                                    height: _getSize.width * 0.35,
                                  ),
                                  Positioned(
                                    left: _getSize.width * 0.03,
                                    bottom: _getSize.height * 0.105,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              137, 246, 249, 245),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color.fromARGB(
                                                  104, 246, 249, 245),
                                              blurRadius: 11,
                                              spreadRadius: 1,
                                              offset: Offset(0, 5),
                                            )
                                          ],
                                          border: Border.all(
                                              width: 0.3, color: Pallete.fade),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(3))),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4.0, horizontal: 14),
                                        child: Row(
                                          children: [
                                            Text(
                                              propertyData[index]
                                                          ['structure'] ==
                                                      "Standalone"
                                                  ? "Standalone"
                                                  : propertyData[index]
                                                          ['unitData']
                                                      .length
                                                      .toString(),
                                              style: AppFonts.body1.copyWith(
                                                color: Pallete.primaryColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize:
                                                    _getSize.height * 0.017,
                                              ),
                                            ),
                                            SizedBox(
                                                width: _getSize.width * 0.01),
                                            Text(
                                                propertyData[index]
                                                            ['structure'] ==
                                                        "Standalone"
                                                    ? ""
                                                    : "Unit",
                                                style: AppFonts.body1.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  color: Pallete.primaryColor,
                                                  fontSize:
                                                      _getSize.height * 0.017,
                                                ))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: _getSize.width * 0.03,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        propertyData[index]['name'],
                                        style: AppFonts.boldText.copyWith(
                                            fontSize: _getSize.height * 0.017,
                                            fontWeight: FontWeight.w900,
                                            color: Color.fromARGB(
                                                255, 12, 12, 12)),
                                      ),
                                      SizedBox(
                                        height: _getSize.height * 0.005,
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            AppImages.estate,
                                            width: _getSize.width * 0.04,
                                          ),
                                          SizedBox(
                                            width: _getSize.width * 0.008,
                                          ),
                                          Text(
                                            propertyData[index]['type'],
                                            style: AppFonts.body1.copyWith(
                                                color: Pallete.fade,
                                                fontSize:
                                                    _getSize.height * 0.015),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: _getSize.height * 0.01,
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            AppImages.location,
                                            width: _getSize.width * 0.04,
                                            color: Pallete.primaryColor,
                                          ),
                                          SizedBox(
                                            width: _getSize.width * 0.008,
                                          ),
                                          SizedBox(
                                            width: _getSize.width * 0.38,
                                            child: Text(
                                              propertyData[index]['location'],
                                              overflow: TextOverflow.ellipsis,
                                              style: AppFonts.body1.copyWith(
                                                  color: Pallete.fade,
                                                  fontSize:
                                                      _getSize.height * 0.015),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: _getSize.height * 0.01,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Description",
                                          style: AppFonts.boldText.copyWith(
                                              fontSize: _getSize.height * 0.017,
                                              fontWeight: FontWeight.w900,
                                              color: Color(0xFF333436))),
                                      SizedBox(
                                        height: _getSize.height * 0.0025,
                                      ),
                                      SizedBox(
                                        width: _getSize.width * 0.38,
                                        child: Text(
                                          propertyData[index]['description'],
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: AppFonts.body1.copyWith(
                                              fontSize:
                                                  _getSize.height * 0.015),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    : SizedBox(
                        height: _getSize.height * 0.15,
                      )));
  }
}

_runFilter(String value) {}


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

