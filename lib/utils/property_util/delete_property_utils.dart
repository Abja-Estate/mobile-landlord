import 'dart:io';
import 'package:abjalandlord/provider/property_provider.dart';
import 'package:abjalandlord/views/dashboard/dashboard.dart';
import 'package:abjalandlord/views/property/property.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/app_images.dart';
import '../../constants/app_routes.dart';
import '../../provider/auth_provider.dart';
import '../../views/navbar/nav.dart';
import '../app_utils.dart';
import '../local_storage.dart';

class DeletePropertyUtil {
  static Future<String> delete(BuildContext context, propertyid) async {
    var result = "";

    AppUtils.showLoader(context);
    Provider.of<PropertyProvider>(context, listen: false)
        .deleteProperty(propertyid)
        .then((value) async {
      Navigator.of(context).pop();
      print(value);
      if (value['statusCode'] == 200) {
        AppUtils.SuccessDialog(
          context,
          "Success",
          "This Property is now deleted.",
          Image.asset(
            AppImages.dustbin,
            width: 48,
          ),
          "Go to properties",
        );
        Future.delayed(Duration(seconds: 2), () async {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => NavBar(
                      initialScreen: Property(),
                      initialTab: 2,
                    )),
            (route) => false,
          );
        });
      } else {
        if (value['statusCode'] == 404) {
          AppUtils.showAlertDialog(
              context,
              'Oops, something isn\'t right!',
              value['error'],
              'Sign Up',
              'Try again',
              () => Navigator.of(context).pushNamed(AppRoutes.registerScreen));
        }
        if (value['statusCode'] == 302) {
          AppUtils.singleDialog(
              context,
              'Recieved',
              value['data'],
              'Close',
              Image.asset(
                AppImages.dustbin,
                width: 48,
              ),
              Text(""),
              () => Navigator.of(context).pop());
        }
        if (value['statusCode'] == 403) {
          if (value["error"] == "Expired Bearer token") {
            Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.loginScreen, (route) => false);
          }
        }
      }
    });

    return result;
  }
}
