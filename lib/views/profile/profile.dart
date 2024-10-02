import 'package:abjalandlord/provider/property_provider.dart';
import 'package:abjalandlord/provider/request_provider.dart';
import 'package:abjalandlord/provider/user_provider.dart';
import 'package:abjalandlord/utils/local_storage.dart';
import 'package:abjalandlord/views/dashboard/dashboard.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart' as imgpika;
import 'package:image_stack/image_stack.dart';
import 'package:provider/provider.dart';
import '../../components/buttons.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_fonts.dart';
import '../../constants/app_images.dart';
import '../../constants/app_routes.dart';
import '../request/time_formatter.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int _tabIndex = 0;

  imgpika.XFile? image; //this is the state variable
  int tenantCount = 5;

  String about = "";
  @override
  void initState() {
    Provider.of<UserProvider>(context, listen: false).initUserData();
    Provider.of<PropertyProvider>(context, listen: false).allTenantSelfies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _getSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Pallete.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(child:
            Consumer3<UserProvider, PropertyProvider, RequestProvider>(builder:
                (context, userProvider, propertyProvider, requestProvider,
                    child) {
          var totalProperty = propertyProvider.property.length;
          var totalRequest = requestProvider.request.length;
          var selfieUrls = propertyProvider.tenantSelfies;
          print(selfieUrls);
          var userData = userProvider.user;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Image.asset(
                        AppImages.back,
                        width: 36,
                      ),
                    ),
                    Text("My Profile"),
                    Text("")
                  ],
                ),
              ),
              SizedBox(
                height: _getSize.height * 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: _getSize.width * 0.35,
                    height: _getSize.height * 0.0007,
                    color: Pallete.primaryColor,
                  ),
                  GestureDetector(
                    onTap: () async {
                      final imgpika.ImagePicker _picker = imgpika.ImagePicker();
                      final img = await _picker.pickImage(
                          source: imgpika.ImageSource.gallery);
                      setState(() {
                        image = img;
                      });
                    },
                    child: DottedBorder(
                      borderType: BorderType.Circle,
                      strokeWidth: 2,
                      color: Color(0xFF47893F),
                      dashPattern: [10, 16],
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: ClipOval(
                          child: Image.network(
                            userData['selfie'],
                            fit: BoxFit.cover,
                            width: _getSize.width * 0.22,
                            height: _getSize.height * 0.1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: _getSize.width * 0.35,
                    height: _getSize.height * 0.0007,
                    color: Pallete.primaryColor,
                  ),
                ],
              ),
              SizedBox(
                height: _getSize.height * 0.04,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${userData['name']} ${userData['surname']}",
                    style: AppFonts.boldText
                        .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppImages.joined,
                        width: 24,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        formatTZDate(userData['createdAt']),
                        style: AppFonts.body1
                            .copyWith(color: Pallete.text, fontSize: 14),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: _getSize.height * 0.02,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.editProfile);
                },
                child: Container(
                  width: _getSize.width * 0.3,
                  decoration: BoxDecoration(
                      color: Color(0xFF382D18),
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: Text(
                        "Edit Profile",
                        style: AppFonts.smallWhiteBold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: _getSize.height * 0.02,
              ),
              Container(
                width: _getSize.width,
                height: _getSize.height * 0.0007,
                color: Pallete.primaryColor,
              ),
              SizedBox(
                height: _getSize.height * 0.02,
              ),
              middle(
                getSize: _getSize,
                totalProperty: totalProperty,
                totalRequest: totalRequest,
              ),
              SizedBox(
                height: _getSize.height * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                    height: _getSize.height * 0.32,
                    child: DefaultTabController(
                      length: 2,
                      child: Column(
                        children: [
                          TabNavBar(
                            tabIndex: _tabIndex,
                            tabTextList: const [
                              'About',
                              'Reviews',
                            ],
                            onTap: (index) {
                              setState(() {
                                _tabIndex = index;
                              });
                            },
                          ),
                          SizedBox(
                            height: _getSize.height * 0.2,
                            child: TabBarView(
                              // physics: const NeverScrollableScrollPhysics(),
                              children: <Widget>[
                                SizedBox(
                                  child: Column(
                                    children: [
                                      Text(
                                        userData['about'],
                                        style: AppFonts.body1
                                            .copyWith(color: Pallete.text),
                                      ),
                                      SizedBox(
                                        height: _getSize.height * 0.02,
                                      ),
                                      selfieUrls.isNotEmpty
                                          ? Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.of(context)
                                                        .pushNamed(
                                                            AppRoutes.tenants);
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      ImageStack(
                                                        imageList: selfieUrls,
                                                        backgroundColor:
                                                            Color.fromARGB(49,
                                                                209, 209, 209),
                                                        extraCountTextStyle:
                                                            AppFonts.body1.copyWith(
                                                                color: Pallete
                                                                    .primaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                        totalCount:
                                                            selfieUrls.length, // If larger than images.length, will show extra empty circle
                                                        imageRadius:
                                                            45, // Radius of each images
                                                        imageCount: selfieUrls.length >
                                                                3
                                                            ? 3
                                                            : tenantCount, // Maximum number of images to be shown in stack
                                                        imageBorderWidth:
                                                            0.6, // Border width around the images
                                                      ),
                                                      SizedBox(
                                                        width: _getSize.width *
                                                            0.02,
                                                      ),
                                                      Text(
                                                        "See More",
                                                        style: AppFonts.body1
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Pallete
                                                                    .secondaryColor),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )
                                          : Text(
                                              "You don't have any tenants yet"),
                                    ],
                                  ),
                                ),
                                bottom(getSize: _getSize)
                              ],
                            ),
                          )
                        ],
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 80),
                child: ButtonWithFuction(
                    text: 'Logout',
                    onPressed: () {
                      setState(() {
                        clear();
                      });
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          AppRoutes.welcomeScreen, (route) => false);
                    }),
              ),
              SizedBox(
                height: _getSize.height * 0.05,
              ),
            ],
          );
        })),
      ),
    );
  }
}

class middle extends StatelessWidget {
  const middle({
    super.key,
    required Size getSize,
    required this.totalProperty,
    required this.totalRequest,
  }) : _getSize = getSize;

  final Size _getSize;

  final int totalProperty;
  final int totalRequest;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: _getSize.height * 0.075,
          width: totalProperty < 99
              ? _getSize.width * 0.28
              : _getSize.width * 0.32,
          decoration: BoxDecoration(
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
                    Text(totalProperty.toString(),
                        style: AppFonts.boldText.copyWith(
                          fontSize: _getSize.height * 0.02,
                          color: Color(0xFF1D5A67),
                        )),
                    Image.asset(
                      AppImages.estate,
                      height: _getSize.height * 0.02,
                      color: Color(0xFF1D5A67),
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
                          color: Color(0xFF1D5A67),
                          fontSize: _getSize.height * 0.017,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Property",
                      style: AppFonts.body1.copyWith(
                          color: Color(
                            0xFF1D5A67,
                          ),
                          fontSize: _getSize.height * 0.017,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        SizedBox(
          width: _getSize.width * 0.04,
        ),
        Container(
          height: _getSize.height * 0.075,
          width:
              totalRequest < 99 ? _getSize.width * 0.28 : _getSize.width * 0.32,
          decoration: BoxDecoration(
              color: Color(0xFFCDF7FD),
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
                    Text(totalRequest.toString(),
                        style: AppFonts.boldText.copyWith(
                            fontSize: _getSize.height * 0.02,
                            color: Pallete.text)),
                    Image.asset(
                      AppImages.request,
                      width: 18,
                      color: Pallete.text,
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
                      "Request",
                      style: AppFonts.body1.copyWith(
                          color: Color(0xFF07D9F5),
                          fontSize: _getSize.height * 0.017,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Recieved",
                      style: AppFonts.body1.copyWith(
                          color: Color(
                            0xFF07D9F5,
                          ),
                          fontSize: _getSize.height * 0.017,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class bottom extends StatelessWidget {
  const bottom({super.key, required Size getSize}) : _getSize = getSize;

  final Size _getSize;

  @override
  Widget build(BuildContext context) {
    List<Map> services = [
      {
        'img': AppImages.agent,
        'icon': AppImages.electrician,
        'color': Color(0xFFFCEADA),
        'color2': Color(0xFFEF9645),
        'text': 'Bryan Umar',
        'job': 'Electrician',
        'desc':
            'I was very impressed with Bryan’s work. He was prompt, professional, and did a great job fixing the electrical problem in my tenant\'s apartment. I would highly recommend him to anyone who needs an electrician.'
      },
      {
        'img': AppImages.agent,
        'icon': AppImages.plumber,
        'color': Color(0xFFEADAFF),
        'color2': Color(0xFF9747FF),
        'text': 'Bryan Umar',
        'job': 'Plumber',
        'desc':
            'I was very impressed with Bryan’s work. He was prompt, professional, and did a great job fixing the electrical problem in my tenant\'s apartment. I would highly recommend him to anyone who needs an electrician.'
      },
    ];
    return SizedBox(
        width: _getSize.width * 0.9,
        height: _getSize.height * 0.2,
        child: ListView.builder(
            itemCount: 0,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, bottom: 8, right: 8, left: 4),
                child: Container(
                  height: _getSize.height * 0.11,
                  width: _getSize.width,
                  decoration: BoxDecoration(
                      color: services[index]['color'],
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(44, 85, 80, 80),
                          blurRadius: 11,
                          spreadRadius: 1,
                          offset: Offset(0, 5),
                        )
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          services[index]['img'],
                          width: _getSize.width * 0.15,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  services[index]['text'],
                                  style: AppFonts.body1.copyWith(
                                      color: Pallete.text,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  width: _getSize.width * 0.42,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star_rate,
                                      size: 18,
                                      color: Color.fromARGB(255, 255, 203, 17),
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      "4/5",
                                      style: AppFonts.body1.copyWith(
                                          color: Pallete.fade,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: _getSize.height * 0.007,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  services[index]['icon'],
                                  color: services[index]['color2'],
                                  width: 24,
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  services[index]['job'],
                                  style: AppFonts.body1.copyWith(
                                    color: Pallete.text,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: _getSize.height * 0.005,
                            ),
                            SizedBox(
                              width: _getSize.width * 0.6,
                              child: Text(
                                services[index]['desc'],
                                style: AppFonts.body1.copyWith(
                                  color: Pallete.text,
                                  fontSize: 12,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}

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
      margin: EdgeInsets.only(bottom: size.height * 0.02),
      decoration: BoxDecoration(
        color: Pallete.backgroundColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: TabBar(
        physics: BouncingScrollPhysics(),
        onTap: widget.onTap,
        indicatorColor: Pallete.primaryColor,
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: Pallete.text,
        labelStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        unselectedLabelColor: Pallete.fade,
        indicatorWeight: 1,
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
            fontSize: count == 5 ? 9 : 16,
          ),
        ),
      ),
    );
  }
}
