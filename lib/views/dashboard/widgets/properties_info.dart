import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_fonts.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_routes.dart';

class properyInformations extends StatelessWidget {
  const properyInformations({super.key, required Size getSize, required this.propertyData})
      : _getSize = getSize;

  final Size _getSize;
  final propertyData;
  @override
  Widget build(BuildContext context) {
    return propertyData != null
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: _getSize.height * 0.073,
                  width: _getSize.width * 0.28,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(97, 29, 89, 103),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(68, 85, 80, 80),
                          blurRadius: 11,
                          spreadRadius: 1,
                          offset: Offset(0, 5),
                        )
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(propertyData['totalProperties'].toString(),
                                style: AppFonts.boldText.copyWith(
                                  fontSize: _getSize.height * 0.02,
                                  color: const Color(0xFF1D5A67),
                                )),
                            Image.asset(
                              AppImages.estate,
                              width: 24,
                              height: _getSize.height * 0.02,
                              color: const Color(0xFF1D5A67),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: _getSize.width * 0.04,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Total",
                              style: AppFonts.body1.copyWith(
                                  color: const Color(0xFF1D5A67),
                                  fontSize: _getSize.height * 0.015,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "Property",
                              style: AppFonts.body1.copyWith(
                                  color: const Color(
                                    0xFF1D5A67,
                                  ),
                                  fontSize: _getSize.height * 0.015,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: _getSize.height * 0.073,
                  width: _getSize.width * 0.28,
                  decoration: const BoxDecoration(
                      color: Color(0xFFFCDBB5),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(68, 85, 80, 80),
                          blurRadius: 11,
                          spreadRadius: 1,
                          offset: Offset(0, 5),
                        )
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                                propertyData['totalVacantProperties']
                                    .toString(),
                                style: AppFonts.boldText.copyWith(
                                    fontSize: _getSize.height * 0.02,
                                    color: Color(0xFFF58807))),
                            Image.asset(
                              AppImages.house,
                              height: _getSize.height * 0.02,
                              color: Color(0xFFF58807),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: _getSize.width * 0.04,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Vacant",
                              style: AppFonts.body1.copyWith(
                                  color: Color(0xFFF58807),
                                  fontSize: _getSize.height * 0.015,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "Unit(s)",
                              style: AppFonts.body1.copyWith(
                                  color: Color(
                                    0xFFF58807,
                                  ),
                                  fontSize: _getSize.height * 0.015,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoutes.tenants);
                  },
                  child: Container(
                    height: _getSize.height * 0.073,
                    width: _getSize.width * 0.28,
                    decoration: const BoxDecoration(
                        color: Color(0xFFD6B5DE),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(68, 85, 80, 80),
                            blurRadius: 11,
                            spreadRadius: 1,
                            offset: Offset(0, 5),
                          )
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(propertyData['totalTenants'].toString(),
                                  style: AppFonts.boldText.copyWith(
                                      fontSize: _getSize.height * 0.02,
                                      color: Color(0xFF750790))),
                              Image.asset(
                                AppImages.rent,
                                height: _getSize.height * 0.02,
                                color: Color(0xFF750790),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: _getSize.width * 0.04,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Total",
                                style: AppFonts.body1.copyWith(
                                    color: Color(0xFF750790),
                                    fontSize: _getSize.height * 0.017,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "Tenant",
                                style: AppFonts.body1.copyWith(
                                    color: Color(
                                      0xFF750790,
                                    ),
                                    fontSize: _getSize.height * 0.017,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ))
            ],
          )
        : SpinKitChasingDots(
            color: Pallete.primaryColor,
            size: 35,
          );
  }
}
