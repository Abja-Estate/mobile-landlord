import 'dart:io';
import 'package:abjalandlord/provider/property_provider.dart';
import 'package:abjalandlord/utils/notification_util.dart';
import 'package:abjalandlord/views/property/property.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/app_images.dart';
import '../../constants/app_routes.dart';
import '../../provider/auth_provider.dart';
import '../app_utils.dart';
import '../local_storage.dart';

class AddPropertyUtil {
  static Future<String> add(
      BuildContext context, Map<String, dynamic> propertyData) async {
    var result;

    AppUtils.showLoader(context);
    Provider.of<PropertyProvider>(context, listen: false)
        .createProperty(propertyData)
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
            Property(),
            2);
        Provider.of<PropertyProvider>(context, listen: false)
            .getAllProperties();
        Future.delayed(const Duration(seconds: 2), () {
          notify(
              "New Successfully Added Property",
              "A new property- ${propertyData["name"]} with id- ${propertyData["propertyID"]} has been added to your collection",
              true);
        });
      } else {
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
        AppUtils.showAlertDialog(
            context,
            'Oops, something isn\'t right!',
            value['error'],
            'Close',
            'Try again',
            () => Navigator.of(context).pop());
      }
    });

    return result;
  }
}
