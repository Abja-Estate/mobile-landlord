import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/app_routes.dart';
import '../../provider/auth_provider.dart';
import '../app_utils.dart';
import '../local_storage.dart';

class LoginUtil {
  static Future<String> login(GlobalKey<FormState> formkey,
      BuildContext context, Map<String, dynamic> loginData) async {
    var result;
    await saveEmail(loginData['email']);

    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();

      AppUtils.showLoader(context);
      Provider.of<AuthProvider>(context, listen: false)
          .login(
        loginData['email'].trim(),
        loginData['password'].trim(),
      )
          .then((value) async {
      
        Navigator.of(context).pop();

        if (value['statusCode'] == 200) {
          // formkey.currentState!.reset();
          await saveId(value['data']['_id'].toString());
          await saveEmail(value['data']['email']);
          await saveName(value['data']['name']);
          await savePhone(value['data']['phone']);
          await saveSurname(value['data']['surname']);
          await saveSelfie(value['data']['selfie'] ??
              "https://i.ibb.co/txwfp3w/37f70b1b79e6.jpg");
          await saveCreatedAt(value['data']['created']);
          await saveToken(value['data']['accessToken']);
          await saveAbout(value['data']['about'] ?? "");
          await saveOnce(3);

          Navigator.of(context).popAndPushNamed(AppRoutes.loadHome);
        } else {
          if (value['statusCode'] == 404) {
            AppUtils.showAlertDialog(
                context,
                'Oops, something isn\'t right!',
                value['error'],
                'Sign Up',
                'Try again',
                () =>
                    Navigator.of(context).pushNamed(AppRoutes.welcomeScreen));
          }
          if (value['statusCode'] == 400) {
            AppUtils.showAlertDialog(
                context,
                'Oops, something isn\'t right!',
                value['error'],
                'Sign Up',
                'Try again',
                () =>
                    Navigator.of(context).pushNamed(AppRoutes.welcomeScreen));
          }

          if (value['statusCode'] == 500) {
            AppUtils.showAlertDialog(
                context,
                'Oops, something isn\'t right!',
                value['error'],
                'Sign Up',
                'Try again',
                () =>
                    Navigator.of(context).pushNamed(AppRoutes.registerScreen));
          }

          if (value['statusCode'] == 403) {
            if (value["error"] == "Expired Bearer token") {
              Navigator.of(context).pushNamed(AppRoutes.loginScreen);
            } else {}
            AppUtils.showAlertDialog(
                context,
                'Oops, something isn\'t right!',
                value['error'],
                'Contact Support',
                'Close',
                () => Navigator.of(context).pop());
          }
        }
      });
    }

    return result;
  }
}
