import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:abjalandlord/components/buttons.dart';
import 'package:abjalandlord/components/input_field.dart';
import 'package:abjalandlord/constants/app_colors.dart';
import 'package:abjalandlord/constants/app_fonts.dart';
import 'package:abjalandlord/constants/app_routes.dart';
import 'package:abjalandlord/network/property.dart';
import 'package:abjalandlord/utils/app_utils.dart';
import 'package:abjalandlord/utils/property_util/add_property_utils.dart';
import 'package:abjalandlord/views/dashboard/dashboard.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart' as imgpika;
import '../../../constants/app_images.dart';
import '../../../utils/local_storage.dart';
import 'add-unit.dart';

class AddProperty extends StatefulWidget {
  const AddProperty({Key? key}) : super(key: key);

  @override
  _AddPropertyState createState() => _AddPropertyState();
}

class _AddPropertyState extends State<AddProperty> {
  int unitCount = 0;
  var name = '';
  var landlordid = '';
  var surname = '';
  var pID = "";
  String randomString = generateRandomString(5, "a");

  getData() async {
    landlordid = await showId();
    name = await showName();
    surname = await showSurname();
    setState(() {
      name;
      surname;
      landlordid;
    });
  }

  final Map<String, dynamic> _propertyData = {
    "landlordID": "",
    "name": "",
    "description": "",
    "unit": "",
    "category": "",
    "structure": "",
    "type": "",
    "location": "",
    "photo": "",
    "unitData": [],
    "football": false,
    "pool": false,
    "wifi": false,
    "laundry": false,
    "garden": false,
    "fitness": false,
    "power": false
  };
  final Map<String, dynamic> _unitData = {
    "info": "",
    "bedrooom": "",
    "landlordID": "",
    "propertyID": "",
    "id": "",
    "bathroom": "",
    "toilet": "",
    "wifi": false,
    "power": false,
    "monthlyCost": "",
    "extraWages": "",
    "tax": "",
    "photo": ""
  };
  bool containsEmptyValue(final Map<String, dynamic> propertyData) {
    // Check if any value in the map is an empty string
    return propertyData.values.any((value) => value == "" || value == false);
  }

  bool isFetchingImage = false;
  bool isuploaded = false;
  String photo = '';
  imgpika.XFile? image; //this is the state variable
  upload(selfie) async {
    isFetchingImage = true;

    var res = await PropertyAPI.uploadImage(selfie);

    print(res);

    setState(() {
      photo = res['data']['selfie'];
      isFetchingImage = false;
      isuploaded = true;
      _propertyData['photo'] = photo;
    });
  }

  bool isStandalone = false;
  String typeItemvalue = 'Residential';
  String structureItemsValue = 'Duplex';
  String categoryItemsValue = 'Lease';
  // List of items in our dropdown menu
  var typeItems = ['Residential', 'Commercial'];
  var structureItems = ['Standalone', 'Duplex', 'Semi-Detached', 'Apartments'];
  var categoryItems = ['Lease', 'Rent', 'Sale', 'Rent to own'];
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final _getSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Row(
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
                  Text("Add Property"),
                  Text("")
                ],
              ),
              SizedBox(
                height: _getSize.height * 0.03,
              ),
              NewWidget(
                data: (value) {
                  _propertyData['name'] = value!;
                },
                data2: (value) {
                  _propertyData['location'] = value;
                },
                getSize: _getSize,
                label: "Name",
                hint: "ex: The Spring lounge",
                label2: "Location",
                hint2: "ex: 42, Awolokun, Gbagada",
              ),
              SizedBox(
                height: _getSize.height * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: _getSize.width * 0.4,
                      child: DropdownButtonFormField<String>(
                        // Initial Value
                        value: typeItemvalue,
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Pallete
                                    .hintColor), // Change the underline color
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Pallete
                                    .hintColor), // Change the underline color when focused
                          ),
                        ),
                        isExpanded: true,
                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),
                        elevation: 0,
                        focusColor: Pallete.text,
                        style: AppFonts.body1,
                        // Array list of items
                        items: typeItems.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            typeItemvalue = newValue!;
                            _propertyData['type'] = newValue;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: _getSize.width * 0.44,
                      child: DropdownButtonFormField<String>(
                        // Initial Value
                        value: structureItemsValue,
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Pallete
                                    .hintColor), // Change the underline color
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Pallete
                                    .hintColor), // Change the underline color when focused
                          ),
                        ),
                        isExpanded: true,
                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),
                        elevation: 0,
                        focusColor: Pallete.text,
                        style: AppFonts.body1,
                        // Array list of items
                        items: structureItems.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            structureItemsValue = newValue!;
                            _propertyData['structure'] = newValue;
                            if (_propertyData['structure'] == "Standalone") {
                              isStandalone = true;
                              _propertyData['unit'] = "1";
                              _propertyData["landlordID"] = landlordid;

                              pID =
                                  'ABJA$landlordid${_propertyData["name"].replaceAll(' ', '')}$randomString';
                              _propertyData["propertyID"] = pID;
                            } else {
                              isStandalone = false;
                            }
                            print(_propertyData['structure']);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: _getSize.height * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: !isStandalone
                          ? _getSize.width * 0.4
                          : _getSize.width * 0.85,
                      child: DropdownButtonFormField<String>(
                        // Initial Value
                        value: categoryItemsValue,
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Pallete
                                    .hintColor), // Change the underline color
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Pallete
                                    .hintColor), // Change the underline color when focused
                          ),
                        ),
                        isExpanded: true,
                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),
                        elevation: 0,
                        focusColor: Pallete.text,
                        style: AppFonts.body1,
                        // Array list of items
                        items: categoryItems.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            categoryItemsValue = newValue!;
                            _propertyData['category'] = newValue;
                          });
                        },
                      ),
                    ),
                    Visibility(
                      visible: !isStandalone,
                      child: SizedBox(
                        width: _getSize.width * 0.45,
                        child: CustomInput3(
                          onChanged: (value) {
                            _propertyData['unit'] = value;
                          },
                          onSaved: (value) {},
                          type: 'number',
                          label: "Unit",
                          hint: "ex: 1",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: _getSize.height * 0.03,
              ),
              CustomInput3(
                onChanged: (value) {
                  _propertyData['description'] = value;
                },
                onSaved: (value) {},
                label: "Property Description",
                hint:
                    "ex: Bright, spacious 2-bedroom apartment in a quiet neighborhood.",
              ),
              SizedBox(
                height: _getSize.height * 0.03,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Text(
                      "Features",
                      style: AppFonts.body1.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Pallete.text),
                    ),
                  ),
                  Row(
                    children: [
                      props(
                        type: "Football",
                        img: AppImages.football,
                        check: _propertyData['football'],
                        onch: (bool? value) {
                          setState(() {
                            _propertyData['football'] = value;
                          });
                        },
                      ),
                      props(
                        type: "Pool",
                        img: AppImages.swim,
                        check: _propertyData['pool'],
                        onch: (bool? value) {
                          setState(() {
                            _propertyData['pool'] = value;
                          });
                        },
                      ),
                      props(
                        type: "Wifi",
                        img: AppImages.wifi,
                        check: _propertyData['wifi'],
                        onch: (bool? value) {
                          setState(() {
                            _propertyData['wifi'] = value;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: _getSize.height * 0.005,
                  ),
                  Row(
                    children: [
                      props(
                        type: "Laundry",
                        img: AppImages.laundry,
                        check: _propertyData['laundry'],
                        onch: (bool? value) {
                          setState(() {
                            _propertyData['laundry'] = value;
                          });
                        },
                      ),
                      props(
                        type: "Garden",
                        img: AppImages.flower,
                        check: _propertyData['garden'],
                        onch: (bool? value) {
                          setState(() {
                            _propertyData['garden'] = value;
                          });
                        },
                      ),
                      props(
                        type: "Fitness",
                        img: AppImages.weightlifting,
                        check: _propertyData['fitness'],
                        onch: (bool? value) {
                          setState(() {
                            _propertyData['fitness'] = value;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: _getSize.height * 0.005,
                  ),
                  Row(
                    children: [
                      props(
                        type: "Power",
                        img: AppImages.power,
                        check: _propertyData['power'],
                        onch: (bool? value) {
                          setState(() {
                            _propertyData['power'] = value;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: _getSize.height * 0.04,
                  ),
                ],
              ),
              GestureDetector(
                onTap: () async {
                  final imgpika.ImagePicker _picker = imgpika.ImagePicker();
                  final img = await _picker.pickImage(
                      source: imgpika.ImageSource.gallery);
                  if (img != null) {
                    File imageFile = File(img.path);
                    Uint8List imageBytes = await imageFile.readAsBytes();
                    String base64String = base64Encode(imageBytes);
                    setState(() {
                      print(base64String);
                      upload(base64String);
                    });
                  }
                },
                child: DottedBorder(
                  color: Pallete.text,
                  strokeWidth: 0.8,
                  dashPattern: [6, 3, 3],
                  borderType: BorderType.RRect,
                  radius: Radius.circular(5),
                  padding: EdgeInsets.all(4),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    child: Container(
                      height: _getSize.height * 0.05,
                      width: _getSize.width * 0.6,
                      color: Color.fromARGB(226, 171, 213, 163),
                      child: !isFetchingImage
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                !isuploaded
                                    ? Icon(
                                        Icons.download,
                                        color: Pallete.primaryColor,
                                      )
                                    : Icon(
                                        Icons.check_circle_rounded,
                                        color: Pallete.whiteColor,
                                      ),
                                !isuploaded
                                    ? Text("Upload Property Image")
                                    : Text("Uploaded")
                              ],
                            )
                          : SpinKitRing(
                              size: 30,
                              color: Pallete.primaryColor,
                              lineWidth: 2.0,
                            ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: _getSize.height * 0.09,
              ),
              isuploaded
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              print(_propertyData);

                              if (_propertyData['name'] == "" ||
                                  _propertyData['location'] == "" ||
                                  _propertyData['structure'] == "" ||
                                  _propertyData['unit'] == "" ||
                                  _propertyData['category'] == "" ||
                                  _propertyData['type'] == "" ||
                                  _propertyData["description"] == "") {
                                AppUtils.singleDialog(
                                    context,
                                    'Error',
                                    'You must provide all property information.',
                                    'close',
                                    const Icon(
                                      Icons.error,
                                      color: Color.fromARGB(255, 205, 5, 5),
                                      size: 30,
                                    ),
                                    Text(""),
                                    () => Navigator.of(context).pop());
                              } else if (!_propertyData['power']) {
                                AppUtils.singleDialog(
                                    context,
                                    'Error',
                                    'You must select atleast power',
                                    'close',
                                    const Icon(
                                      Icons.error,
                                      color: Color.fromARGB(255, 205, 5, 5),
                                      size: 30,
                                    ),
                                    Image.asset(
                                      AppImages.power,
                                      width: 24,
                                    ),
                                    () => Navigator.of(context).pop());
                              } else if (_propertyData['photo'] == '') {
                                AppUtils.singleDialog(
                                    context,
                                    'Error',
                                    'You have not uploaded an image of this property',
                                    'close',
                                    const Icon(
                                      Icons.error,
                                      color: Color.fromARGB(255, 205, 5, 5),
                                      size: 30,
                                    ),
                                    Text(""),
                                    () => Navigator.of(context).pop());
                              } else {
                                Navigator.of(context).pushNamed(
                                        AppRoutes.addUnit,
                                        arguments: {
                                          'data': _propertyData,
                                        },
                                      );
                              }
                            },
                            child: Container(
                              width: _getSize.width * 0.6,
                              height: _getSize.height * 0.055,
                              decoration: BoxDecoration(
                                  color: Pallete.primaryColor,
                                  border: Border.all(
                                      width: 0.5, color: Pallete.primaryColor),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text(
                                "Add Unit",
                                  style: AppFonts.smallWhiteBold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              AppUtils.singleDialog(
                                  context,
                                  'Empty Property',
                                  'You have to provide all property \n information to add unit.'
                                      ,
                                  'close',
                                  const Icon(
                                    Icons.error,
                                    color: Color.fromARGB(255, 205, 5, 5),
                                    size: 30,
                                  ),
                                  Text(""),
                                  () => Navigator.of(context).pop());
                            },
                            child: Container(
                              width: _getSize.width * 0.6,
                              height: _getSize.height * 0.055,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 193, 206, 190),
                                  border: Border.all(
                                      width: 0.5,
                                      color:
                                          Color.fromARGB(255, 166, 194, 160)),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text(
                                  "Add Unit",
                                  style: AppFonts.body1.copyWith(
                                      color: Pallete.whiteColor, fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
              SizedBox(
                height: _getSize.height * 0.01,
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class NewWidget extends StatelessWidget {
  NewWidget(
      {super.key,
      required Size getSize,
      required this.label,
      required this.hint,
      required this.data,
      required this.data2,
      required this.hint2,
      this.type,
      this.enabled,
      this.type2,
      required this.label2})
      : _getSize = getSize;

  final Size _getSize;
  final String label;
  final String? type;
  final bool? enabled;
  final String? type2;
  final String label2;
  final String hint;
  Function(String?) data;
  Function(String?) data2;
  final String hint2;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: _getSize.width * 0.45,
          child: CustomInput3(
            onSaved: (onsaved) {},
            type: type,
            onChanged: data,
            label: label,
            hint: hint,
          ),
        ),
        SizedBox(
          width: _getSize.width * 0.45,
          child: CustomInput3(
            enabled: enabled,
            type: type2,
            onSaved: (onsaved) {},
            onChanged: data2,
            label: label2,
            hint: hint2,
          ),
        )
      ],
    );
  }
}

class props extends StatelessWidget {
  const props(
      {super.key,
      required this.type,
      required this.img,
      required this.check,
      required this.onch});
  final String type;
  final String img;
  final bool check;
  final Function(bool?) onch;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Checkbox(
              activeColor: Pallete.primaryColor, value: check, onChanged: onch),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                border: Border.all(
                  width: 0.5,
                  color: Pallete.fade,
                )),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Image.asset(
                img,
                width: 20,
              ),
            ),
          ),
          SizedBox(
            width: 4,
          ),
          Text(
            type,
            style: AppFonts.body1.copyWith(
              color: Pallete.text,
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }
}
