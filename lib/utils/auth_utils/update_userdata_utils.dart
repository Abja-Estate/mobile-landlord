import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/app_images.dart';
import '../../constants/app_routes.dart';
import '../../provider/auth_provider.dart';
import '../app_utils.dart';
import '../local_storage.dart';

class UpdateUtil {
  static Future<String> update(GlobalKey<FormState> formkey,
      BuildContext context, Map<String, dynamic> updateData) async {
     print(updateData);


    var result;

    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();

      AppUtils.showLoader(context);
      Provider.of<AuthProvider>(context, listen: false)
          .update(
              updateData['email'],
              updateData['phone'],
              updateData['password'],
              updateData['confirmPassword'],
              updateData['name'],
              updateData['surname'],
              updateData['about'],
              updateData['token'])
          .then((value) async {
        print(value);
        Navigator.of(context).pop();

        if (value['statusCode'] == 200) {
          await saveId(value['data']['_id'].toString());
          await saveEmail(value['data']['email']);
          await saveName(value['data']['name']);
          await savePhone(value['data']['phone']);
          await saveSurname(value['data']['surname']);
          await saveSelfie(value['data']['selfie'] ??
              "https://i.ibb.co/txwfp3w/37f70b1b79e6.jpg");
          await saveCreatedAt(value['data']['created']);
          await saveAbout(value['data']['about'] ?? "");
          AppUtils.SuccessDialog(
              context,
              "Success",
              "Profile updated successfully",
              Image.asset(
                AppImages.success,
                width: 32,
              ),
              "View profile",
              sroute: AppRoutes.profile);

          // formkey.currentState!.reset();
          await saveSelfie(value['data']['selfie']);
          var user = {
            "email": value['data']['email'],
            "phone": value['data']['phone'],
            "name": value['data']['name'],
            "surname": value['data']['surname'],
            "selfie": value['data']['selfie'],
            "about": value['data']['about'],
            "createdAt": value['data']['created'],
          };
          await saveUser(user);
        } else {
          if (value['statusCode'] == 404) {
            AppUtils.showAlertDialog(
                context,
                'Oops, something isn\'t right!',
                value['error'],
                'Sign Up',
                'Try again',
                () => Navigator.of(context).pushNamed(AppRoutes.profile));
          }
          if (value['statusCode'] == 403) {
            if (value["error"] == "Expired Bearer token") {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.loginScreen, (route) => false);
            } else {
              AppUtils.ErrorDialog(
                context,
                'Oops, something isn\'t right!',
                value['error'] ?? "",
            
                'Close',
                Icon(
                  Icons.error_rounded,
                  color: Color.fromARGB(255, 213, 10, 27),
                  size: 30,
                ),
              );
            }
          }
        }
      });
    }

    return result;
  }
}
