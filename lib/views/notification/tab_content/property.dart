import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_fonts.dart';
import '../../../constants/app_images.dart';

class PropertyNotifications extends StatelessWidget {
  const PropertyNotifications(
      {super.key, required Size getSize, required this.properties})
      : _getSize = getSize;

  final Size _getSize;
  final List properties;
  @override
  Widget build(BuildContext context) {
    List<Map> propertie = [
      {
        'color': Color(0xFFFCEADA),
        "date": "Today",
        'text': 'Painter',
        'text2': "Painting of Apartment 004",
        'data': [
          {
            'icon': AppImages.agent,
            'color': Color(0xFFFCEADA),
            'text': 'New Successfully Added Property',
            'text2':
                "Agent Emmanuel has received rent payment from Miss Susan for June 2023."
          },
          {
            'icon': AppImages.agent,
            'color': Color(0xFFFCEADA),
            'text': 'New Successfully Added Tenant (Unit 005)',
            'text2':
                "New Tenant, Susan with ID Number 197235 has been onboarded to The Spring Lodge Property."
          },
        ]
      },
    ];
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 16),
      child: 
      
      
    properties.isEmpty?  Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 16),
      child: Container(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: _getSize.height * 0.15,
              ),
              Image.asset(AppImages.noNotification),
              Text("You currently have no property notification")
            ],
          ),
        ),
      ),
    ):  SizedBox(
          width: _getSize.width * 0.9,
          height: _getSize.height * 0.9,
          child: ListView.builder(
              itemCount: properties.length,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, bottom: 8, right: 16, left: 16),
                  child: Container(
                    height: properties[index]['data'].length == 1
                        ? _getSize.height * 0.19 // For length < 2
                        : properties[index]['data'].length == 2
                            ? _getSize.height * 0.29 // For length < 2
                            : properties[index]['data'].length == 3
                                ? _getSize.height * 0.24 // For length < 2
                                : properties[index]['data'].length == 4
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
                           properties[index]['time'],
                            style: AppFonts.boldText.copyWith(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          SizedBox(
                            height: properties[index]['data'].length == 1
                                ? _getSize.height * 0.06 // For length < 2
                                : properties[index]['data'].length == 2
                                    ? _getSize.height * 0.15 // For length < 2
                                    : properties[index]['data'].length == 3
                                        ? _getSize.height *
                                            0.17 // For length < 3
                                        : properties[index]['data'].length == 4
                                            ? _getSize.height *
                                                0.24 // For length < 4
                                            : _getSize.height *
                                                0.24, // For length >= 4
                            child: buildListItem(context,
                                properties[index]['data'], _getSize.width),
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

Widget buildListItem(BuildContext context, List<Map<String, dynamic>> service,
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
                        text: 'New Successfully Added Property',
                        style: TextStyle(
                          color: Colors
                              .black, // Replace with Pallete.black if defined
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: ' - ${service[index]['name']}, ${service[index]['structure']} with ${service[index]['unit']} units located at ${service[index]['location']}',
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
