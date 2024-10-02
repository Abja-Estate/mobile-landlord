import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:abjalandlord/constants/app_colors.dart';
import 'package:abjalandlord/constants/app_fonts.dart';
import 'package:abjalandlord/constants/resources.dart';
import 'package:abjalandlord/utils/app_utils.dart';
import 'package:abjalandlord/utils/property_util/add_unit_utils.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart' as imgpika;
import '../../../components/input_field.dart';
import '../../../constants/app_images.dart';
import '../../../network/property.dart';
import '../../../utils/local_storage.dart';
import '../../navbar/nav.dart';
import '../../tenant/tenant_profile.dart';
import '../property.dart';
import 'add-property.dart';
import 'add-unit.dart';

class AddMoreUnit extends StatefulWidget {
  const AddMoreUnit({Key? key}) : super(key: key);

  @override
  _AddMoreUnitState createState() => _AddMoreUnitState();
}

class _AddMoreUnitState extends State<AddMoreUnit> {
  int unitCount = 0;
  var name = '';
  var landlordid = '';
  var surname = '';

  imgpika.XFile? image; //this is the state variable
  bool isFetchingImage = false;
  getData() async {
    landlordid = await showId();
    name = await showName();
    surname = await showSurname();
    setState(() {
      name;
      surname;
      landlordid;
    });
    pid = _propertyData['propertyID'];
  }

  var pid = '';
  String randomString = generateRandomString(5, "a");

  bool isuploaded = false;
  upload(selfie) async {
    var photo = "";

    var res = await PropertyAPI.uploadImage(selfie);
    setState(() {
      photo = res['data']['selfie'];
      isFetchingImage = false;
    });

    return photo;
  }

  var newUnitsCount = 0;

  var pID = "";
  var unitID = "";
  List<UnitItem> moreUnits = [];
  var mcLength = 0.235;
  var txLength = 0.235;
  var extraLength = 0.235;
  void addUnit() {
    setState(() {
      newUnitsCount++;
      moreUnits.add(UnitItem(false, false, "", ",", "", "", "", imgHolder, "",
          "", false, false, "", "", "", ""));
    });
  }

  collectUnitData() {
    List<Map<String, dynamic>> dataList =
        moreUnits.asMap().entries.map((entry) {
      int index = entry.key; // This is the index
      var item = entry.value; // This is the current item
      return {
        "bedroom": item.bedroom,
        "landlordID": landlordid,
        "propertyID": _propertyData['propertyID'],
        "unitID": item.id,
        "bathroom": item.bathroom,
        "lightMeter": item.light,
        "waterMeter": item.water,
        "toilet": item.toilet,
        "wifi": item.isWifiChecked,
        "power": item.isPowerChecked,
        "store": item.store,
        "isTaken": false,
        "isInUse": false,
        "monthlyCost": item.mc,
        "extraWages": item.extra,
        "tax": item.tax,
        "photo": item.photo,
        "nick": item.nick
      };
    }).toList();

    bool hasEmptyData = dataList.any((data) =>
        data["bedroom"] == null ||
        data["bedroom"].toString().isEmpty ||
        data["bathroom"] == null ||
        data["bathroom"].toString().isEmpty ||
        data["lightMeter"] == null ||
        data["lightMeter"].toString().isEmpty ||
        data["waterMeter"] == null ||
        data["waterMeter"].toString().isEmpty ||
        data["toilet"] == null ||
        data["toilet"].toString().isEmpty ||
        data["wifi"] == null ||
        data["wifi"].toString().isEmpty ||
        data["power"] == null ||
        data["power"].toString().isEmpty ||
        data["store"] == null ||
        data["store"].toString().isEmpty ||
        data["nick"] == null ||
        data["nick"].toString().isEmpty ||
        data["photo"] == null ||
        data["photo"].toString().isEmpty ||
        data["tax"] == null ||
        data["tax"].toString().isEmpty ||
        data["monthlyCost"] == null ||
        data["monthlyCost"].toString().isEmpty ||
        data["extraWages"] == null ||
        data["extraWages"].toString().isEmpty);

    print(dataList);
    if (hasEmptyData) {
      // Handle case where there's empty data
      // For example, show an error message or prevent further action
      AppUtils.ErrorDialog(
        context,
        'Some fields are empty',
        "You need to fill all the fields",
        'Close',
        Icon(
          Icons.error_rounded,
          color: Color.fromARGB(255, 213, 10, 10),
          size: 30,
        ),
      );
    } else {
      // Proceed with adding the property data
      // Now dataList contains all items as map objects
      // You can use this dataList as needed
      _propertyData['unitData'] = dataList;
      _propertyData["landlordID"] = landlordid;
      _propertyData["propertyID"] = _propertyData["propertyID"];
      AddUnitUtil.add(context, _propertyData);
    }
  }

  @override
  void initState() {
    _propertyData['unitData'] = [];
    mcLength;
    txLength;
    extraLength;
    getData();
    addUnit();
    super.initState();
  }

  Map<String, dynamic> _propertyData = {};

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dataFromRoute = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    _propertyData = dataFromRoute["data"];
    final _getSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  NavBar(initialScreen: const Property(), initialTab: 2)),
          (route) => false,
        );
        return true;
      },
      child: Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
          child: SizedBox(
            height: _getSize.height,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
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
                      Text("Add Unit"),
                      Text("")
                    ],
                  ),
                  SizedBox(
                    height: _getSize.height * 0.03,
                  ),
                  SizedBox(
                    width: _getSize.width,
                    height: _getSize.height * 0.79,
                    child: ListView.builder(
                        itemCount: moreUnits.length,
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          String userAccessCodeString =
                              generateRandomString(3, "b");
                          moreUnits[index].id =
                              "${moreUnits[index].nick}-$userAccessCodeString";
                          newUnitsCount = _propertyData["unitData"].length + 1;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 32.0),
                            child: Column(children: [
                              ProfileData(
                                getSize: _getSize,
                                header: "",
                                content:
                                    "Unit ${newUnitsCount + index} Information.",
                              ),
                              SizedBox(
                                height: _getSize.height * 0.003,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'ID Number: ',
                                      style: AppFonts.smallWhite.copyWith(
                                        color: Pallete.fade,
                                      ),
                                    ),
                                    SizedBox(
                                        width: _getSize.width * 0.65,
                                        child: Text(
                                          moreUnits[index].id,
                                          overflow: TextOverflow.ellipsis,
                                          style: AppFonts.smallWhiteBold
                                              .copyWith(
                                                  color: Pallete
                                                      .primaryColorVariant,
                                                  fontSize: 11),
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: _getSize.height * 0.03,
                              ),
                              CustomInput3(
                                label: "Unit name",
                                onChanged: (p) {
                                  moreUnits[index].nick = p!;
                                  setState(() {});
                                },
                                onSaved: (p) {
                                  moreUnits[index].nick = p!;
                                },
                                hint: "name: Quater01",
                              ),
                              SizedBox(
                                height: _getSize.height * 0.03,
                              ),
                              NewWidget(
                                data: (value) {
                                  moreUnits[index].bedroom = value!;
                                  // String userAccessCodeString =
                                  //     generateRandomString(5, "b");
                                  // moreUnits[index].id =
                                  //     "$pID-00$userAccessCodeString";
                                },
                                data2: (value) {
                                  moreUnits[index].store = value!;
                                },
                                getSize: _getSize,
                                label: "Bedroom",
                                hint: "ex: 3 Bedrooms",
                                label2: "store",
                                type: "number",
                                type2: "number",
                                hint2: "ex: 1",
                              ),
                              SizedBox(
                                height: _getSize.height * 0.03,
                              ),
                              NewWidget(
                                data: (value) {
                                  moreUnits[index].bathroom = value!;
                                },
                                data2: (value) {
                                  moreUnits[index].toilet = value!;
                                },
                                getSize: _getSize,
                                label: "Bathrooms",
                                type: "number",
                                type2: "number",
                                hint: "ex: 2 Bathroom",
                                label2: "Toilet",
                                hint2: "ex:2 Toilet",
                              ),
                              SizedBox(
                                height: _getSize.height * 0.03,
                              ),
                              NewWidget(
                                data: (value) {
                                  moreUnits[index].light = value!;
                                },
                                data2: (value) {
                                  moreUnits[index].water = value!;
                                },
                                getSize: _getSize,
                                label: "Light Meter",
                                hint: "ex: 4543433324",
                                type: "number",
                                type2: "number",
                                label2: "Water meter",
                                hint2: "ex: 344444333",
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
                                        type: "Wifi",
                                        img: AppImages.wifi,
                                        check: moreUnits[index].isWifiChecked,
                                        onch: (bool? value) {
                                          setState(() {
                                            moreUnits[index].isWifiChecked =
                                                value!;
                                          });
                                        },
                                      ),
                                      props(
                                        type: "Power",
                                        img: AppImages.power,
                                        check: moreUnits[index].isPowerChecked,
                                        onch: (bool? value) {
                                          setState(() {
                                            moreUnits[index].isPowerChecked =
                                                value!;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: _getSize.height * 0.005,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 1,
                                    width: _getSize.width * 0.25,
                                    color: Pallete.primaryColor,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Cost for rent",
                                    style: AppFonts.body1.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Pallete.primaryColor),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    height: 1,
                                    width: _getSize.width * 0.25,
                                    color: Pallete.primaryColor,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: _getSize.height * 0.02,
                              ),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Monthly Cost",
                                            style: AppFonts.bodyText.copyWith(
                                                fontSize: 12,
                                                color: Pallete.text,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            "*",
                                            style: AppFonts.bodyText.copyWith(
                                                color: Color.fromARGB(
                                                    255, 208, 0, 0)),
                                          ),
                                        ],
                                      ),
                                     SizedBox(
                                        height: _getSize.height * 0.04,
                                        width: _getSize.width * mcLength,
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 10),
                                            errorMaxLines: 1,
                                            filled: true,
                                            fillColor: Color(0xFFDAE7D9),
                                            hintStyle: AppFonts.hintStyle,
                                            errorStyle: AppFonts.errorStyle,
                                            prefixText: "\$",
                                            suffixText: "/ month",
                                            suffixStyle: AppFonts.body1
                                                .copyWith(
                                                    color: Pallete.primaryColor,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600),
                                            prefixStyle: AppFonts.body1
                                                .copyWith(
                                                    color: Pallete.primaryColor,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600),
                                            border: InputBorder.none,
                                          ),
                                          onSaved: (p) {
                                            moreUnits[index].mc = p!;
                                            setState(() {});
                                          },
                                          onChanged: (p) {
                                            moreUnits[index].mc = p;
                                            if (p.length <= 3) {
                                              setState(() {
                                                mcLength = 0.235;
                                              });
                                            } else {
                                              setState(() {
                                                mcLength = 0.29;
                                              });
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: _getSize.height * 0.01,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Extra Wages",
                                            style: AppFonts.bodyText.copyWith(
                                                fontSize: 12,
                                                color: Pallete.text,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            "*",
                                            style: AppFonts.bodyText.copyWith(
                                                color: Color.fromARGB(
                                                    255, 208, 0, 0)),
                                          ),
                                        ],
                                      ),
                                     SizedBox(
                                        height: _getSize.height * 0.04,
                                        width: _getSize.width * extraLength,
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 10),
                                            errorMaxLines: 1,
                                            filled: true,
                                            fillColor: Color(0xFFDAE7D9),
                                            hintStyle: AppFonts.hintStyle,
                                            errorStyle: AppFonts.errorStyle,
                                            prefixText: "\$",
                                            suffixText: "/ month",
                                            suffixStyle: AppFonts.body1
                                                .copyWith(
                                                    color: Pallete.primaryColor,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600),
                                            prefixStyle: AppFonts.body1
                                                .copyWith(
                                                    color: Pallete.primaryColor,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600),
                                            border: InputBorder.none,
                                          ),
                                          onSaved: (p) {
                                            moreUnits[index].extra = p!;
                                            setState(() {});
                                          },
                                          onChanged: (p) {
                                            moreUnits[index].extra = p;
                                            if (p.length <= 3) {
                                              setState(() {
                                                extraLength = 0.235;
                                              });
                                            } else {
                                              setState(() {
                                                extraLength = 0.29;
                                              });
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: _getSize.height * 0.01,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Tax",
                                            style: AppFonts.bodyText.copyWith(
                                                fontSize: 12,
                                                color: Pallete.text,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            "*",
                                            style: AppFonts.bodyText.copyWith(
                                                color: Color.fromARGB(
                                                    255, 208, 0, 0)),
                                          ),
                                        ],
                                      ),
                                     SizedBox(
                                        height: _getSize.height * 0.04,
                                        width: _getSize.width * txLength,
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 10),
                                            errorMaxLines: 1,
                                            filled: true,
                                            fillColor: const Color(0xFFDAE7D9),
                                            hintStyle: AppFonts.hintStyle,
                                            errorStyle: AppFonts.errorStyle,
                                            prefixText: "\$",
                                            suffixText: "/ month",
                                            suffixStyle: AppFonts.body1
                                                .copyWith(
                                                    color: Pallete.primaryColor,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600),
                                            prefixStyle: AppFonts.body1
                                                .copyWith(
                                                    color: Pallete.primaryColor,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600),
                                            border: InputBorder.none,
                                          ),
                                          onSaved: (p) {
                                            moreUnits[index].tax = p!;
                                            setState(() {});
                                          },
                                          onChanged: (p) {
                                            moreUnits[index].tax = p;
                                            if (p.length <= 3) {
                                              setState(() {
                                                txLength = 0.235;
                                              });
                                            } else {
                                              setState(() {
                                                txLength = 0.29;
                                              });
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: _getSize.height * 0.05,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  final imgpika.ImagePicker _picker =
                                      imgpika.ImagePicker();
                                  final img = await _picker.pickImage(
                                      source: imgpika.ImageSource.gallery);
                                  if (img != null) {
                                    print(isFetchingImage);
                                    isFetchingImage = true;
                                    moreUnits[index].isFetchedImage =
                                        isFetchingImage;
                                    setState(() {});
                                    print(isFetchingImage);
                                    File imageFile = File(img.path);
                                    Uint8List imageBytes =
                                        await imageFile.readAsBytes();
                                    String base64String =
                                        base64Encode(imageBytes);

                                    String uploadedPhoto =
                                        await upload(base64String);
                                    print(uploadedPhoto);

                                    if (uploadedPhoto != "") {
                                      setState(() {
                                        moreUnits[index].photo = uploadedPhoto;
                                        moreUnits[index].isuploaded = true;
                                        moreUnits[index].isFetchedImage =
                                            isFetchingImage;

                                        print(moreUnits[index].isFetchedImage);
                                      });
                                    } else {}
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    child: Container(
                                      height: _getSize.height * 0.05,
                                      width: _getSize.width * 0.6,
                                      color: Color(0xFFDAE7D9),
                                      child: !moreUnits[index].isFetchedImage
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                !moreUnits[index].isuploaded
                                                    ? Icon(
                                                        Icons.download,
                                                        color: Pallete
                                                            .primaryColor,
                                                      )
                                                    : Icon(
                                                        Icons
                                                            .check_circle_rounded,
                                                        color:
                                                            Pallete.whiteColor,
                                                      ),
                                                !moreUnits[index].isuploaded
                                                    ? Text(
                                                        "Upload Property Image")
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
                            ]),
                          );
                        }),
                  ),
                  SizedBox(
                    height: _getSize.height * 0.03,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            addUnit();
                            AppUtils.showSnackBarMessage(
                                'Scroll down to fill unit information',
                                context);
                          },
                          child: Container(
                            width: _getSize.width * 0.4,
                            height: _getSize.height * 0.045,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 0.5, color: Pallete.primaryColor),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text("Add Unit"),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            collectUnitData();
                          },
                          child: Container(
                            width: _getSize.width * 0.4,
                            height: _getSize.height * 0.045,
                            decoration: BoxDecoration(
                                color: Pallete.primaryColor,
                                border: Border.all(
                                    width: 0.5, color: Pallete.primaryColor),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                "Submit",
                                style: AppFonts.smallWhiteBold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )),
      ),
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

String generateRandomString(int length, String a) {
  var res;
  if (a == "a") {
    const String chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random rnd = Random();

    res = String.fromCharCodes(Iterable.generate(
        length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
  } else {
    const String chars = 'abrstuvwxyzABCDEFGHIJK0123456789';
    Random rnd = Random();

    res = String.fromCharCodes(Iterable.generate(
        length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
  }

  return res;
}
