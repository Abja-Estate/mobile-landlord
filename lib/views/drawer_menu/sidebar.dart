import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_fonts.dart';
import '../../../../constants/app_images.dart';
import '../../../../constants/app_routes.dart';
import '../../../../utils/app_utils.dart';
import '../../utils/local_storage.dart';

class SideBar extends StatelessWidget {
  String email = 'your email';
  String fullname = '';

  var photo;

  SideBar({
    Key? key,
    required this.email,
    required this.fullname,
    required this.photo,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _getSize = MediaQuery.of(context).size;
    return Drawer(
      child: Container(
          color: Pallete.whiteColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    children: [
                      ClipOval(
                          child: Image.network(
                        photo,
                        width: _getSize.width * 0.105,
                        height: _getSize.height * 0.05,
                        fit: BoxFit.cover,
                      )),
                      SizedBox(
                        width: _getSize.width * 0.01,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            fullname,
                            style: AppFonts.body1.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Color(0xFF382D18)),
                          ),
                          Text(
                            email,
                            style: AppFonts.body1.copyWith(
                                fontWeight: FontWeight.w300,
                                fontSize: 12,
                                color: Color(0xFF382D18)),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: _getSize.height * 0.02,
                  ),
                  Container(
                    width: _getSize.width,
                    height: _getSize.height * 0.0007,
                    color: Pallete.fade,
                  ),
                  SizedBox(
                    height: _getSize.height * 0.02,
                  ),
                  Column(
                    children: const [
                      items(
                        text: "Profile",
                        img: AppImages.profile,
                        route: AppRoutes.profile,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      items(
                        text: "My Properties",
                        img: AppImages.estate,
                        route: AppRoutes.propDetails,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      items(
                        text: "My Tenants",
                        img: AppImages.tenant,
                        route: AppRoutes.tenants,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      items(
                        text: "Requests",
                         route: AppRoutes.requestScreen,
                        img: AppImages.request,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      items(
                        text: "Services",
                        img: AppImages.services,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      items(
                        text: "My Cards",
                        img: AppImages.card,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      items(
                        text: "Settings",
                        route: AppRoutes.settings,
                        img: AppImages.settings,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: _getSize.height * 0.02,
                  ),
                  Container(
                    width: _getSize.width,
                    height: _getSize.height * 0.0007,
                    color: Pallete.fade,
                  ),
                  SizedBox(
                    height: _getSize.height * 0.02,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "General",
                        style: AppFonts.body1.copyWith(
                            fontWeight: FontWeight.w900,
                            color: Pallete.primaryColor),
                      ),
                      SizedBox(
                        height: _getSize.height * 0.005,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            AppImages.help,
                            width: 24,
                          ),
                          SizedBox(
                            width: _getSize.width * 0.02,
                          ),
                          Text(
                            "Help and Support",
                            style: AppFonts.body1.copyWith(
                                fontWeight: FontWeight.w900,
                                color: Pallete.primaryColor),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: _getSize.height * 0.02,
                  ),
                  Container(
                    width: _getSize.width,
                    height: _getSize.height * 0.0007,
                    color: Pallete.fade,
                  ),
                  SizedBox(
                    height: _getSize.height * 0.02,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Legal",
                        style: AppFonts.body1.copyWith(
                            fontWeight: FontWeight.w900,
                            color: Pallete.primaryColor),
                      ),
                      SizedBox(
                        height: _getSize.height * 0.005,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            AppImages.tc,
                            width: 24,
                          ),
                          SizedBox(
                            width: _getSize.width * 0.02,
                          ),
                          Text(
                            "Terms and Conditions",
                            style: AppFonts.body1.copyWith(
                                fontWeight: FontWeight.w900,
                                color: Pallete.primaryColor),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: _getSize.height * 0.02,
                  ),
                  Container(
                    width: _getSize.width,
                    height: _getSize.height * 0.0007,
                    color: Pallete.fade,
                  ),
                  SizedBox(
                    height: _getSize.height * 0.02,
                  ),
                  InkWell(
                    onTap: ()async {
                     await clear();
                      
                      Navigator.of(context)
                          .popAndPushNamed(AppRoutes.loginScreen);
                    },
                    child: Container(
                      width:
                          _getSize.width, // Expands to fill the available space
                      child: Row(
                        children: [
                          Image.asset(
                            AppImages.logout,
                            width: 24,
                          ),
                          SizedBox(
                            width: _getSize.width * 0.02,
                          ),
                          Text(
                            "Log Out",
                            style: AppFonts.body1.copyWith(
                                fontWeight: FontWeight.w900,
                                color: Pallete.primaryColor),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}

class items extends StatelessWidget {
  const items({super.key, required this.text, required this.img, this.route});
  final String text;
  final String img;
  final String? route;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(route!);
      },
      child: Container(
        width: double.infinity, // Expands to fill the available space
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              children: [
                Image.asset(
                  img,
                  width: 24,
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  text,
                  style: AppFonts.body1.copyWith(
                      fontWeight: FontWeight.w900, color: Pallete.text),
                )
              ],
            ),
            Icon(
              Icons.chevron_right,
              color: Color(0xFF47893F),
            )
          ],
        ),
      ),
    );
  }
}
