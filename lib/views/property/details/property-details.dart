import 'package:abjalandlord/constants/app_colors.dart';
import 'package:abjalandlord/constants/app_fonts.dart';
import 'package:abjalandlord/constants/app_images.dart';
import 'package:abjalandlord/constants/app_routes.dart';
import 'package:abjalandlord/constants/resources.dart';
import 'package:abjalandlord/provider/property_provider.dart';
import 'package:abjalandlord/views/property/details/widgets/full_property.dart';
import 'package:abjalandlord/views/property/details/widgets/unit_content.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../network/property.dart';
import '../../../provider/request_provider.dart';
import '../../../utils/backpressed.dart';
import '../../navbar/nav.dart';
import '../property.dart';

class PropertyDetails extends StatefulWidget {
  const PropertyDetails({Key? key}) : super(key: key);

  @override
  _PropertyDetailsState createState() => _PropertyDetailsState();
}

class _PropertyDetailsState extends State<PropertyDetails> {
  List<String> items = List.generate(20, (index) => 'Item $index');

  int _currentIndex = 0;
  List<String> imgList = [];
  final CarouselController _carouselController = CarouselController();
  String formattedDate = "";
  void maind() {
    final DateTime now = DateTime.now();
    formattedDate = formatDate(now);
  }

  int currentIndexs = 0;

  String formatDate(DateTime dateTime) {
    return DateFormat('dd MMMM, y').format(dateTime);
  }

  bool isLoadingProperty = true;
  var property = {};
  int unitIndex = -1;
  String propID = "";
  List allRequest = [];
  bool isUnitAvailable = false;
  List propertyUnits = [];
  getProperties() async {
    await Future.delayed(const Duration(seconds: 1));
    var res = await PropertyAPI.getProperty(propID);

    isLoadingProperty = true;

    var gotproperties = res['data'];

    if (gotproperties.isNotEmpty) {
      property = gotproperties;
      imgList.add(property['photo'] ?? imgHolder);
      propertyUnits = property['unitData'];
      for (var element in property['unitData']) {
        imgList.add(element["photo"]);
      }
      isLoadingProperty = false;
      setState(() {
        property;
      });
    } else {
      setState(() {
        isLoadingProperty = false;
        // property.length = 0;
      });
    }
  }

  @override
  void initState() {
    unitIndex;
    maind();
    getProperties();
    print(unitIndex);
    _scrollController.addListener(() {
      setState(() {
        _currentPage = (_scrollController.offset / 100).round();
      });
    });
    Provider.of<RequestProvider>(context, listen: false).getAllRequest();
    Provider.of<PropertyProvider>(context, listen: false).getAllProperties();
    super.initState();
  }

  ScrollController _scrollController = ScrollController();
  int _currentPage = 0;

  void scrollToNextItem() {
    _scrollController.animateTo(
      _scrollController.offset +
          400, // Adjust this value based on your item size
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
    if (_currentIndex == propertyUnits.length) {
    } else {
      _currentIndex++;
    }
  }

  void scrollToPreviousItem() {
    _scrollController.animateTo(
      _scrollController.offset -
          400, // Adjust this value based on your item size
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
    if (_currentIndex == 0) {
    } else {
      _currentIndex--;
    }
  }

  @override
  Widget build(BuildContext context) {
    final dataFromRoute = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    propID = dataFromRoute["data"];
    allRequest = dataFromRoute["requests"];
    print(allRequest);
    final _getSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => onBackPressed(context, const Property(), 2),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NavBar(
                                    initialScreen: Property(), initialTab: 1)),
                            (route) => false,
                          );
                        },
                        child: Image.asset(
                          AppImages.back,
                          width: 36,
                        ),
                      ),
                      const Text("Property Details"),
                      const Text("")
                    ],
                  ),
                  SizedBox(
                    height: _getSize.height * 0.03,
                  ),
                  !isLoadingProperty
                      ? Column(
                          children: [
                          
                                FullPropertyContent(
                                    getSize: _getSize,
                                    property: property,
                                    propertyUnits: propertyUnits,
                                    unitCount: unitIndex,
                                    request: allRequest,
                                  ),
                             
                              
                          ],
                        )
                      : Container(
                          margin: EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                              color: Color(0xFFF6F9F5),
                              borderRadius: BorderRadius.circular(10)),
                          width: _getSize.width,
                          height: _getSize.height * 0.38,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SpinKitRing(
                                  size: 30,
                                  color: Pallete.primaryColor,
                                  lineWidth: 2.0,
                                ),
                                Text(
                                  "Looking for your property Listing",
                                  style: AppFonts.body1,
                                ),
                              ],
                            ),
                          ),
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDotsIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        imgList.length, // Change this based on your actual item count
        (index) => Container(
          width: 32.0,
          height: 4.0,
          margin: EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            border: Border.all(width: 0.2, color: Pallete.fade),
            borderRadius: BorderRadius.circular(2),
            color: _currentIndex == index ? Colors.white : Pallete.fade,
          ),
        ),
      ),
    );
  }
}
