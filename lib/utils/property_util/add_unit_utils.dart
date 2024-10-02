import 'dart:io';
import 'package:abjalandlord/provider/property_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/app_images.dart';
import '../../constants/app_routes.dart';
import '../../provider/auth_provider.dart';
import '../../views/property/property.dart';
import '../app_utils.dart';
import '../local_storage.dart';

class AddUnitUtil {
  static Future<String> add(
      BuildContext context, Map<String, dynamic> propertyData) async {
    var result;

    AppUtils.showLoader(context);
    Provider.of<PropertyProvider>(context, listen: false)
        .addUnit(propertyData)
        .then((value) async {
      Navigator.of(context).pop();

      if (value['statusCode'] == 200) {
        AppUtils.SuccessDialogWithNav(
            context,
            "Successful",
            "Your Property and Units have been successfully added.",
            Image.asset(
              AppImages.success,
              width: 48,
            ),
            "View Property",
            const Property(),
            2);
        Provider.of<PropertyProvider>(context, listen: false)
            .getAllProperties();
      } else {
        if (value['statusCode'] == 403) {
          if (value["error"] == "Expired Bearer token") {
            Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.loginScreen, (route) => false);
          } else {
            AppUtils.showAlertDialog(
                context,
                'Oops, something isn\'t right!',
                value['error'],
                'Close',
                'Try again',
                () => Navigator.of(context).pop());
          }
        }
      }
    });

    return result;
  }
}
