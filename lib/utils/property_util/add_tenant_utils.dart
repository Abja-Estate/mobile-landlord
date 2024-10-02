import 'dart:io';
import 'package:abjalandlord/provider/property_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/app_images.dart';
import '../../constants/app_routes.dart';
import '../../provider/auth_provider.dart';
import '../../views/dashboard/dashboard.dart';
import '../../views/navbar/nav.dart';
import '../../views/property/property.dart';
import '../app_utils.dart';
import '../local_storage.dart';
import '../notification_util.dart';

class AddTenantUtil {
  static Future<String> add(
      BuildContext context, Map<String, dynamic> tenantData) async {
    var result;

    AppUtils.showLoader(context);
    Provider.of<PropertyProvider>(context, listen: false)
        .addTenantToUnit(tenantData)
        .then((value) async {
      Navigator.of(context).pop();

      if (value['statusCode'] == 200) {
        AppUtils.SuccessDialog(
            context,
            "Successful",
            "New Tenant; ${tenantData['name']} ${tenantData['surname']} has been added successfully. ",
            Image.asset(
              AppImages.success,
              width: 48,
            ),
            "Close",
            sroute: AppRoutes.propDetails,
            routeData: value['data']['propertyID']);

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  NavBar(initialScreen: const Dashboard(), initialTab: 0)),
          (route) => false,
        );

        notify(
            "New Successfully Added Tenant",
            "You added ${tenantData['name']} ${tenantData['surname']} to a property with id- ${tenantData["propertyID"]}.",
            true);
      } else {
         if (value['statusCode'] == 403) {
          if (value["error"] == "Expired Bearer token") {
            Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.loginScreen, (route) => false);
          } else {
        AppUtils.showAlertDialog(
            context,
            'Oops, something isn\'t right!',
            value['error'].toString(),
            'Close',
            'Try again',
            () => Navigator.of(context).pop());
      }}}
    });

    return result;
  }
}
