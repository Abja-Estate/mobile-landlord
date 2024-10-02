import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:abjalandlord/network/auth.dart';
import 'package:abjalandlord/utils/auth_utils/update_userdata_utils.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart' as imgpika;
import '../../components/buttons.dart';
import '../../components/input_field.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_images.dart';
import '../../constants/app_routes.dart';
import '../../utils/local_storage.dart';
import '../../utils/validator.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var photo = 'https://picsum.photos/200';
  final _updateFormKey = GlobalKey<FormState>();
  final Map<String, dynamic> _updateData = {
    "email": "",
    "phone": "",
    "password": "",
    "confirmPassword": "",
    "name": "",
    "surname": "",
    "about": "",
    "selfie": ""
  };
  String? base64Image;
  var email = "";
  var surname = "";
  var phone = "";
  var name = "";
  var token = "";
  bool isFetchingImage = false;
  var password = "**********";
  var about =
      "Hi, I’m Tony Ukachukwu. A landlord and property owner within Kampala and it’s districts. I offer premium and the best qualities of luxury living spaces  within affordable rent fees.";
  imgpika.XFile? image; //this is the state variable
  getPhoto() async {
    photo = await showSelfie();
    token = await showToken();
    name = await showName();
    phone = await showPhone();
    email = await showEmail();
    surname = await showSurname();
    about = await showRef();
    setState(() {
      photo;
      name;
      surname;
      password;
      phone;
      email;
      about;
    });
  }

  upload(selfie) async {
    var res = await AuthAPI.selfie( selfie);
    isFetchingImage = true;
    print(res);

    await saveSelfie(res['data']['selfie']);
    setState(() {
      photo = res['data']['selfie'];
      isFetchingImage = false;
    });
  }

  @override
  void initState() {
    getPhoto();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  Text("Edit Profile"),
                  Text("")
                ],
              ),
            ),
            SizedBox(
              height: _getSize.height * 0.04,
            ),
            InkWell(
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
              child: Stack(
                children: [
                  DottedBorder(
                    borderType: BorderType.Circle,
                    strokeWidth: 2,
                    color: Color(0xFF47893F),
                    dashPattern: [10, 16],
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: !isFetchingImage
                          ? ClipOval(
                              child: Image.network(
                                photo,
                                fit: BoxFit.cover,
                                width: _getSize.width * 0.23,
                                height: _getSize.height * 0.12,
                              ),
                            )
                          : SpinKitRing(
                              size: 30,
                              color: Pallete.primaryColor,
                              lineWidth: 2.0,
                            ),
                    ),
                  ),
                  Positioned(
                      top: 82,
                      bottom: 1,
                      left: 70,
                      right: 0,
                      child: SizedBox(
                          width: 4,
                          child: Image.asset(
                            AppImages.cam,
                          )))
                ],
              ),
            ),
            SizedBox(
              height: _getSize.height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Form(
                key: _updateFormKey,
                child: Column(
                  children: [
                    CustomInput3(
                      validator: Validators.nameValidator,
                      label: 'Name',
                      hint: 'Name',
                      onChanged: (val) {
                        _updateData['name'] = val;
                      },
                      onSaved: (value) {
                        _updateData['name'] = value;
                      },
                    ),
                    SizedBox(
                      height: _getSize.height * 0.04,
                    ),
                    CustomInput3(
                      validator: Validators.nameValidator,
                      label: "Surname",
                      hint: 'Surname',
                      onChanged: (val) {
                        _updateData['surname'] = val;
                      },
                      onSaved: (value) {
                        _updateData['surname'] = value;
                        setState(() {
                          surname = value!;
                        });
                      },
                    ),
                    SizedBox(
                      height: _getSize.height * 0.04,
                    ),
                    CustomInput3(
                      validator: Validators.emailValidator,
                      onChanged: (v) {
                        _updateData['email'] = v;
                      },
                      label: 'Email',
                      hint: 'Email',
                      onSaved: (value) {
                        _updateData['email'] = value;
                      },
                    ),
                    SizedBox(
                      height: _getSize.height * 0.04,
                    ),
                    CustomInput3(
                
                      type: 'number',
                      label: 'Phone',
                      hint: 'Phone',
                       onChanged: (v) {
                        _updateData['phone'] = v;
                      },
                      onSaved: (value) {
                        _updateData['phone'] = value;
                      },
                    ),
                    SizedBox(
                      height: _getSize.height * 0.04,
                    ),
                    CustomInput3(
                      validator: Validators.nameValidator,
                      label: 'About',
                      hint: 'About',
                       onChanged: (v) {
                        _updateData['about'] = v;
                      },
                      onSaved: (value) {
                        _updateData['about'] = value;
                        
                      },
                    ),
                    SizedBox(
                      height: _getSize.height * 0.04,
                    ),
                   
                  ],
                ),
              ),
            ),
            SizedBox(
              height: _getSize.height * 0.05,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 64),
              child: ButtonWithFuction(
                  text: 'Save Changes',
                  onPressed: () {
                    UpdateUtil.update(_updateFormKey, context, _updateData);
                    // Navigator.of(context).pushNamed(AppRoutes.navbar);
                  }),
            ),
            SizedBox(
              height: _getSize.height * 0.05,
            ),
          ],
        ),
      )),
    );
  }
}
