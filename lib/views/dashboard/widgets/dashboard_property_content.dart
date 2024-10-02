import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_fonts.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_routes.dart';

class DashoardPropertyData extends StatelessWidget {
  const DashoardPropertyData(
      {super.key,
      required Size getSize,
      required this.requests,
      required this.howMany})
      : _getSize = getSize;

  final Size _getSize;
  final List howMany;
  final List requests;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: _getSize.width,
        height: _getSize.height * 0.40,
        child: ListView.builder(
            itemCount: howMany.length,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.propDetails,
                    arguments: {
                      'data': howMany[index]['propertyID'],
                      "requests": requests
                    },
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(right: _getSize.width * 0.02),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Image.network(
                            howMany[index]['photo'],
                            fit: BoxFit.fitWidth,
                            height: _getSize.height * 0.18,
                            width: _getSize.width * 0.5,
                          ),
                          Positioned(
                            left: _getSize.width * 0.03,
                            bottom: _getSize.height * 0.11,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(137, 246, 249, 245),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromARGB(113, 246, 249, 245),
                                      blurRadius: 11,
                                      spreadRadius: 1,
                                      offset: Offset(0, 5),
                                    )
                                  ],
                                  border: Border.all(
                                      width: 0.3, color: Pallete.fade),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3))),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8.0,
                                    horizontal: _getSize.height * 0.018),
                                child: Row(
                                  children: [
                                    Text(
                                      howMany[index]['structure'] ==
                                              "Standalone"
                                          ? "Standalone"
                                          : howMany[index]['unitData']
                                              .length
                                              .toString(),
                                      style: AppFonts.body1.copyWith(
                                        color: Pallete.primaryColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: _getSize.height * 0.018,
                                      ),
                                    ),
                                    SizedBox(width: _getSize.width * 0.01),
                                    Text(
                                        howMany[index]['structure'] ==
                                                "Standalone"
                                            ? ""
                                            : "Unit",
                                        style: AppFonts.body1.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: Pallete.primaryColor,
                                            fontSize: _getSize.height * 0.018))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: _getSize.height * 0.01,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            howMany[index]['name'],
                            style: AppFonts.boldText.copyWith(
                                fontSize: _getSize.height * 0.016,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF333436)),
                          ),
                          SizedBox(
                            height: _getSize.height * 0.005,
                          ),
                          Row(
                            children: [
                              Image.asset(AppImages.estate,
                                  width: _getSize.width * 0.04),
                              SizedBox(
                                width: _getSize.width * 0.008,
                              ),
                              Text(
                                howMany[index]['type'],
                                style: AppFonts.body1.copyWith(
                                    color: Pallete.fade,
                                    fontSize: _getSize.height * 0.016),
                              )
                            ],
                          ),
                          SizedBox(
                            height: _getSize.height * 0.008,
                          ),
                          SizedBox(
                            height: _getSize.height * 0.04,
                            child: Row(
                              children: [
                                Image.asset(AppImages.location,
                                    width: _getSize.width * 0.037),
                                SizedBox(
                                  width: _getSize.width * 0.008,
                                ),
                                SizedBox(
                                  width: _getSize.width * 0.4,
                                  child: Text(
                                    howMany[index]['location'],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: AppFonts.body1.copyWith(
                                        color: Pallete.fade,
                                        fontSize: _getSize.height * 0.0125),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: _getSize.height * 0.008,
                          ),
                          Text("Description",
                              style: AppFonts.boldText.copyWith(
                                  fontSize: _getSize.height * 0.016,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF333436))),
                          SizedBox(
                            height: _getSize.height * 0.0025,
                          ),
                          SizedBox(
                            width: _getSize.width * 0.5,
                            child: Text(
                              howMany[index]["description"],
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: AppFonts.body1
                                  .copyWith(fontSize: _getSize.height * 0.015),
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
              );
            }));
  }
}
