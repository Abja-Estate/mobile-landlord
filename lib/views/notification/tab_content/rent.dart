import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_fonts.dart';
import '../../../constants/app_images.dart';

class RentNotifications extends StatelessWidget {
  const RentNotifications(
      {super.key, required Size getSize, required this.services})
      : _getSize = getSize;

  final Size _getSize;
  final List services;
  @override
  Widget build(BuildContext context) {
 return 
 
   services.isEmpty?  Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 16),
      child: Container(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: _getSize.height * 0.15,
              ),
              Image.asset(AppImages.noNotification),
              Text("You currently have no rentage notification")
            ],
          ),
        ),
      ),
    ): 
 
 Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 16),
      child: SizedBox(
          width: _getSize.width * 0.9,
          height: _getSize.height * 0.9,
          child: ListView.builder(
              itemCount: services.length,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, bottom: 8, right: 16, left: 16),
                  child: Container(
                    height: services[index]['data'].length == 1
                        ? _getSize.height * 0.12 // For length < 2
                        : services[index]['data'].length == 2
                            ? _getSize.height * 0.17 // For length < 2
                            : services[index]['data'].length == 3
                                ? _getSize.height * 0.24 // For length < 2
                                : services[index]['data'].length == 4
                                    ? _getSize.height * 0.3
                                    : _getSize.height * 0.3,
                    width: _getSize.width,
                    decoration: BoxDecoration(
                        color: Pallete.backgroundColor,
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Color.fromARGB(44, 85, 80, 80),
                        //     blurRadius: 11,
                        //     spreadRadius: 1,
                        //     offset: Offset(0, 5),
                        //   )
                        // ],
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            services[index]['time'],
                            style: AppFonts.boldText.copyWith(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          SizedBox(
                            height: services[index]['data'].length == 1
                                ? _getSize.height * 0.06 // For length < 2
                                : services[index]['data'].length == 2
                                    ? _getSize.height * 0.11 // For length < 2
                                    : services[index]['data'].length == 3
                                        ? _getSize.height *
                                            0.17 // For length < 3
                                        : services[index]['data'].length == 4
                                            ? _getSize.height *
                                                0.24 // For length < 4
                                            : _getSize.height *
                                                0.24, // For length >= 4
                            child: buildListItem(context,services[index]['type'],
                                services[index]['data'], _getSize.width),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              })),
    );
  }
}

Widget buildListItem(BuildContext context,String type, List<Map<String, dynamic>> service,
    double getSizeWidth) {
  // Assuming AppFonts and Pallete are defined elsewhere in your project.
  return ListView.builder(
      itemCount: service.length,
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                service[index]['icon'],
                width: 24,
              ),
              const SizedBox(width: 12),
              SizedBox(
                width: getSizeWidth * 0.6,
                child: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                              text:"New Tenant",
                              style: TextStyle(
                                color: "Tenant Added" != 'paid'
                                    ? Colors.black
                                    : Color.fromARGB(255, 224, 10,
                                        10), // Replace with Pallete.black if defined
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ,
                       TextSpan(
                            text: ' -${service[index]['name']} ${service[index]['surname']}',
                              style: TextStyle(
                                color: Colors
                                    .black, // Replace with Pallete.black if defined
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                         ,
                      TextSpan(
                        text: ' has been added to',
                        style: TextStyle(
                          color: Colors
                              .black, // Replace with Pallete.black if defined
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: ' unit-${service[index]['unitID']}',
                        style: TextStyle(
                          color: Colors
                              .grey, // Replace with Pallete.fade if defined
                          fontSize: 10,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 24),
              const Icon(Icons.more_vert),
            ],
          ),
        );
      });
}
