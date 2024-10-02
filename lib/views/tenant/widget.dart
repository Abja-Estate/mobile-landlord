import 'package:abjalandlord/constants/resources.dart';
import 'package:flutter/material.dart';
import 'package:image_stack/image_stack.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_fonts.dart';
import '../../../constants/app_images.dart';
import '../../components/buttons.dart';
import '../../constants/app_routes.dart';

class TenantsContent extends StatelessWidget {
  const TenantsContent(
      {super.key, required Size getSize, required this.tenants})
      : _getSize = getSize;

  final Size _getSize;
  final List tenants;
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 16),
      child: SizedBox(
          width: _getSize.width * 0.9,
          height: _getSize.height * 0.9,
          child: ListView.builder(
              itemCount: tenants.length,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return TenantContent(
                    getSize: _getSize, tenants: tenants, count: index);
              })),
    );
  }
}

class TenantContent extends StatelessWidget {
  const TenantContent(
      {super.key,
      required Size getSize,
      required this.tenants,
      required this.count})
      : _getSize = getSize;

  final Size _getSize;
  final List tenants;
  final int count;

  String converts(rem) {
    String isOweing = '';
    int week = rem;
    if (week > 6) {
      isOweing = "Paid";
    } else {
      isOweing = "Due in ${week.toString()} weeks";
    }

    return isOweing.toString();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRoutes.tenantsProfile,
          arguments: {
            'tenant': tenants[count],
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
        child: Container(
          height: _getSize.height * 0.18,
          decoration: BoxDecoration(
            border: Border.all(
                width: 0.5, color: Color.fromARGB(255, 138, 189, 133)),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipOval(
                  child: Image.network(
                    tenants[count]['selfie']??photoHolder,
                    width: _getSize.width * 0.14,
                    height: _getSize.height * 0.06,
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: _getSize.width * 0.7,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: _getSize.width * 0.34,
                              child: Text(
                                '${tenants[count]['name']} ${tenants[count]['surname']}',
                                overflow: TextOverflow.ellipsis,
                                style: AppFonts.boldText.copyWith(
                                    fontSize: 12, fontWeight: FontWeight.w400),
                              ),
                            ),
                            SizedBox(
                              width: _getSize.width * 0.05,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: tenants[count]['remainingWeeks'] > 6
                                    ? Color(0xFFC8DCC5)
                                    : Color(0xFFF4B3B3),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4.0, horizontal: 8),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 5,
                                      width: 5,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: tenants[count]
                                                      ['remainingWeeks'] >
                                                  6
                                              ? Color(0xFF47893F)
                                              : Color(0xFFD90001)),
                                    ),
                                    SizedBox(
                                      width: _getSize.width * 0.025,
                                    ),
                                    tenants[count]['remainingWeeks'] == 0
                                        ? Text(
                                            "Expired Rent",
                                            style: AppFonts.smallWhiteBold
                                                .copyWith(
                                                    color: Color(0xFFD90001)),
                                          )
                                        : tenants[count]['remainingWeeks'] > 6
                                            ? Text(
                                                "Paid",
                                                style: AppFonts.smallWhiteBold
                                                    .copyWith(
                                                        color:
                                                            Color(0xFF47893F)),
                                              )
                                            : Text(
                                                "Due in ${tenants[count]['remainingWeeks']} weeks",
                                                style: AppFonts.smallWhiteBold
                                                    .copyWith(
                                                        color:
                                                            Color(0xFFD90001)),
                                              ),
                                  ],
                                ),
                              ),
                            )
                          ]),
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
                            SizedBox(
                              width: _getSize.width * 0.02,
                            ),
                            Text(
                              tenants[count]['propertyStructure'],
                              style: AppFonts.body1.copyWith(fontSize: 14),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: _getSize.height * 0.015,
                    ),
                    Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  AppImages.bedroom,
                                  width: 24,
                                ),
                                SizedBox(
                                  width: _getSize.width * 0.01,
                                ),
                                Text(
                                  tenants[count]["bedroom"],
                                )
                              ],
                            ),
                            SizedBox(
                              height: _getSize.height * 0.001,
                            ),
                            Text(
                              "Bedroom",
                              style: AppFonts.bodyText.copyWith(fontSize: 12),
                            )
                          ],
                        ),
                        SizedBox(
                          width: _getSize.width * 0.05,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  AppImages.toilet,
                                  width: 24,
                                ),
                                SizedBox(
                                  width: _getSize.width * 0.01,
                                ),
                                Text(
                                  tenants[count]['toilet'],
                                )
                              ],
                            ),
                            SizedBox(
                              height: _getSize.height * 0.001,
                            ),
                            Text(
                              'Toilet',
                              style: AppFonts.bodyText.copyWith(fontSize: 12),
                            )
                          ],
                        ),
                        SizedBox(
                          width: _getSize.width * 0.05,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  AppImages.bathroom,
                                  width: 24,
                                ),
                                SizedBox(
                                  width: _getSize.width * 0.01,
                                ),
                                Text(tenants[count]['bathroom'])
                              ],
                            ),
                            SizedBox(
                              height: _getSize.height * 0.001,
                            ),
                            Text(
                              'Bathroom',
                              style: AppFonts.bodyText.copyWith(fontSize: 12),
                            )
                          ],
                        ),
                        SizedBox(
                          width: _getSize.width * 0.05,
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
                                  width: _getSize.width * 0.01,
                                ),
                                Text(tenants[count]['waterMeter'])
                              ],
                            ),
                            SizedBox(
                              height: _getSize.height * 0.001,
                            ),
                            Text(
                              'Water Meter',
                              style: AppFonts.bodyText.copyWith(fontSize: 12),
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
                              width: _getSize.width * 0.02,
                            ),
                            SizedBox(
                              width: _getSize.width * 0.65,
                              child: Text(
                                tenants[count]['propertyLocation'],
                                overflow: TextOverflow.ellipsis,
                                style: AppFonts.body1.copyWith(
                                    color: Pallete.fade,
                                    fontSize: _getSize.height * 0.016),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
