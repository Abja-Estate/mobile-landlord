import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:abjalandlord/constants/app_fonts.dart';
import 'package:abjalandlord/utils/property_util/add_tenant_utils.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import '../../components/input_field.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_images.dart';
import 'package:image_picker/image_picker.dart' as imgpika;

import '../../network/property.dart';
import '../../utils/app_utils.dart';

class AddTenant extends StatefulWidget {
  const AddTenant({Key? key}) : super(key: key);

  @override
  _AddTenantState createState() => _AddTenantState();
}

class _AddTenantState extends State<AddTenant> {
  TextEditingController datePickerController = TextEditingController();

  final _tenantFormKey = GlobalKey<FormState>();
  final Map<String, dynamic> _tenantData = {
    "email": '',
    "phone": "",
    "name": "",
    "docPhoto": "",
    "propertyID": "",
    "unitID": "",
    "startDate": "",
    "endDate": "",
    "surname": "",
    "receiptPhoto": "",
    "idPhoto": "",
    "rentalPhoto": ""
  };
  bool isFetchingid = false;
  bool isFetchingrental = false;
  bool isFetchingreciept = false;
  Map<String, dynamic> tenantData = {};
  String photo = '';
  imgpika.XFile? image; //this is the state variable
  bool isuploaded = false;
  bool isuploadedren = false;
  bool isuploadedrec = false;
  
  upload(selfie) async {
    var photo = "";
    var res = await PropertyAPI.uploadImage(selfie);
    setState(() {
      photo = res['data']['selfie'];
    });
    print(photo);
    return photo;
  }

  DateTime startDate = DateTime.now();
  String startholderDate = 'dd/mm/yyyy';
  String endholderDate = 'dd/mm/yyyy';
  DateTime endDate = DateTime.now().add(Duration(days: 180)); // 6 months later
  bool haveSelectedStartDate = false;
  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != startDate) {
      setState(() {
        startDate = picked;
        endDate = picked.add(Duration(days: 180));
        startholderDate = formatDate(startDate);
        // Update end date to be at least 6 months later
        haveSelectedStartDate = true;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    if (!haveSelectedStartDate) {
      AppUtils.singleDialog(
          context,
          'Error',
          'Select start date first',
          'close',
          const Icon(
            Icons.error,
            color: Color.fromARGB(255, 205, 5, 5),
            size: 30,
          ),
          const Text(""),
          () => Navigator.of(context).pop());
    } else {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: endDate.isBefore(startDate.add(Duration(days: 180)))
            ? startDate.add(Duration(days: 180))
            : endDate,
        firstDate: startDate.add(Duration(days: 180)),
        lastDate: DateTime(2101),
      );

      if (picked != null && picked != endDate) {
        setState(() {
          endDate = picked;

          endholderDate = formatDate(endDate);
          _tenantData['propertyID'] = tenantData['propertyID'];
          _tenantData['unitID'] = tenantData['unitID'];
          _tenantData['startDate'] = startholderDate;
          _tenantData['endDate'] = endholderDate;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final dataFromRoute = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    tenantData = dataFromRoute["tenant"];
    print(tenantData);
    final _getSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
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
                  Text("Add New Tenant"),
                  Text("")
                ],
              ),
            ),
            SizedBox(
              height: _getSize.height * 0.02,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _tenantFormKey,
                    child: Column(
                      children: [
                        CustomInput3(
                          onSaved: (v) {},
                          onChanged: (v) {
                            _tenantData['name'] = v;
                          },
                          label: "First Name",
                          hint: "First Name",
                        ),
                        SizedBox(
                          height: _getSize.height * 0.025,
                        ),
                        CustomInput3(
                          onSaved: (v) {},
                          onChanged: (v) {
                            _tenantData['surname'] = v;
                          },
                          label: "Last Name",
                          hint: "last Name",
                        ),
                        SizedBox(
                          height: _getSize.height * 0.025,
                        ),
                        CustomInput3(
                          onSaved: (v) {},
                          onChanged: (v) {
                            _tenantData['email'] = v;
                          },
                          label: "Email address",
                          hint: "Email",
                        ),
                        SizedBox(
                          height: _getSize.height * 0.025,
                        ),
                        CustomInput3(
                          onSaved: (v) {},
                          onChanged: (v) {
                            _tenantData['phone'] = v;
                          },
                          type: "number",
                          label: "Phone Number",
                          hint: "Phone",
                        ),
                        SizedBox(
                          height: _getSize.height * 0.025,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Start Date',
                                  suffixIconConstraints:
                                      BoxConstraints(minWidth: 35),
                                  suffixIcon: Image.asset(
                                    "assets/icons/calenda.png",
                                    height: _getSize.height * 0.02,
                                  ),
                                ),
                                readOnly: true,
                                onTap: () => _selectStartDate(context),
                                controller: TextEditingController(
                                    text: startholderDate),
                              ),
                              SizedBox(
                                  height: 20), // Spacing between input fields
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Due Date',
                                  suffixIconConstraints:
                                      BoxConstraints(minWidth: 35),
                                  suffixIcon: Image.asset(
                                    "assets/icons/calenda.png",
                                    height: _getSize.height * 0.02,
                                  ),
                                ),
                                readOnly: true,
                                onTap: () => _selectEndDate(context),
                                controller:
                                    TextEditingController(text: endholderDate),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: _getSize.height * 0.025,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: _getSize.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Text(
                        'Upload Documents',
                        style: AppFonts.bodyText
                            .copyWith(color: Pallete.text, fontSize: 16),
                      ),
                      Text(
                        '*',
                        style: AppFonts.boldText.copyWith(color: Colors.red),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: _getSize.width * 0.8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: _getSize.height * 0.03,
                      ),
                      GestureDetector(
                          onTap: () async {
                            final imgpika.ImagePicker _picker =
                                imgpika.ImagePicker();
                            final img = await _picker.pickImage(
                                source: imgpika.ImageSource.gallery);
                            if (img != null) {
                              File imageFile = File(img.path);
                              Uint8List imageBytes =
                                  await imageFile.readAsBytes();
                              String base64String = base64Encode(imageBytes);
                              setState(() {});
                              isFetchingid = true;

                              _tenantData['idPhoto'] =
                                  await upload(base64String);
                              isFetchingid = false;
                              isuploaded = true;
                              setState(() {});
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'National ID/ Passport',
                                style: AppFonts.bodyText.copyWith(
                                    color: Pallete.text, fontSize: 14),
                              ),
                              !isFetchingid
                                  ? Column(
                                      children: [
                                        !isuploaded
                                            ? Image.asset(
                                                AppImages.dwn,
                                                width: 20,
                                              )
                                            : Icon(
                                                Icons.check_circle_rounded,
                                                color: Pallete.primaryColor,
                                              ),
                                      ],
                                    )
                                  : SpinKitChasingDots(
                                      size: 14,
                                      color: Pallete.primaryColorVariant,
                                    )
                            ],
                          )),
                      SizedBox(
                        height: _getSize.height * 0.025,
                      ),
                      GestureDetector(
                          onTap: () async {
                            final imgpika.ImagePicker _picker =
                                imgpika.ImagePicker();
                            final img = await _picker.pickImage(
                                source: imgpika.ImageSource.gallery);
                            if (img != null) {
                              File imageFile = File(img.path);
                              Uint8List imageBytes =
                                  await imageFile.readAsBytes();
                              String base64String = base64Encode(imageBytes);
                              setState(() {});
                              isFetchingrental = true;

                              _tenantData['rentalPhoto'] =
                                  await upload(base64String);
                              isFetchingrental = false;
                              isuploadedren = true;
                              setState(() {});
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Rental Agreement',
                                style: AppFonts.bodyText.copyWith(
                                    color: Pallete.text, fontSize: 14),
                              ),
                              !isFetchingrental
                                  ? Column(
                                      children: [
                                        !isuploadedren
                                            ? Image.asset(
                                                AppImages.dwn,
                                                width: 20,
                                              )
                                            : Icon(
                                                Icons.check_circle_rounded,
                                                color: Pallete.primaryColor,
                                              ),
                                      ],
                                    )
                                  : SpinKitChasingDots(
                                      size: 14,
                                      color: Pallete.primaryColorVariant,
                                    )
                            ],
                          )),
                      SizedBox(
                        height: _getSize.height * 0.025,
                      ),
                      GestureDetector(
                          onTap: () async {
                            final imgpika.ImagePicker _picker =
                                imgpika.ImagePicker();
                            final img = await _picker.pickImage(
                                source: imgpika.ImageSource.gallery);
                            if (img != null) {
                              File imageFile = File(img.path);
                              Uint8List imageBytes =
                                  await imageFile.readAsBytes();
                              String base64String = base64Encode(imageBytes);
                              setState(() {});
                              isFetchingreciept = true;

                              _tenantData['receiptPhoto'] =
                                  await upload(base64String);
                              isFetchingreciept = false;
                              isuploadedrec = true;
                              setState(() {});
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'First Payment Receipt',
                                style: AppFonts.bodyText.copyWith(
                                    color: Pallete.text, fontSize: 14),
                              ),
                              !isFetchingreciept
                                  ? Column(
                                      children: [
                                        !isuploadedrec
                                            ? Image.asset(
                                                AppImages.dwn,
                                                width: 20,
                                              )
                                            : Icon(
                                                Icons.check_circle_rounded,
                                                color: Pallete.primaryColor,
                                              ),
                                      ],
                                    )
                                  : SpinKitChasingDots(
                                      size: 14,
                                      color: Pallete.primaryColorVariant,
                                    )
                            ],
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: _getSize.height * 0.10,
                ),
                GestureDetector(
                  onTap: () {
                    // ADD DOCUMENT NOT WORKING
                    print(_tenantData);
                    if (_tenantData['name'] == "" ||
                        _tenantData['surname'] == "" ||
                        _tenantData['email'] == "" ||
                        _tenantData['phone'] == "" ||
                        _tenantData['idPhoto'] == "" ||
                        _tenantData['rentalPhoto'] == "" ||
                        _tenantData['receiptPhoto'] == "" ||
                        _tenantData['startDate'] == "" ||
                        _tenantData["endDate"] == "") {
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
                    } else {
                      print(_tenantData);
                      AddTenantUtil.add(context, _tenantData);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Pallete.primaryColor,
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(
                            color: Pallete.primaryColor, width: 0.5)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: _getSize.width * 0.15),
                      child: Text(
                        "Save Changes.",
                        style: AppFonts.bodyText.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Pallete.whiteColor,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: _getSize.height * 0.10,
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}

// Create a new method to format the date
String formatDate(DateTime date) {
  final DateFormat formatter = DateFormat('d MMMM yyyy');
  return formatter.format(date);
}
