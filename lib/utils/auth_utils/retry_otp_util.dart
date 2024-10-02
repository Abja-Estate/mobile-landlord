import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_routes.dart';
import '../../provider/auth_provider.dart';
import '../app_utils.dart';
import '../local_storage.dart';

class RetryOTPUtil {
  static Future<String> retry(BuildContext context) async {
    var email = await showEmail();
  
  
    AppUtils.showLoader(context);
    var result;
    Provider.of<AuthProvider>(context, listen: false)
        .forgotPassword(email)
        .then((value) async {
      Navigator.of(context).pop();
   
      if (value['statusCode'] != 200) {
        if (value["error"] == "Expired Bearer token") {
          Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.forgotPassword, (route) => false);
        } else {
          AppUtils.ErrorDialog(
            context,
            value['error'] ?? "",
            'User not found',
            'Close',
            Icon(
              Icons.error_rounded,
              color: Color.fromARGB(255, 213, 10, 27),
              size: 30,
            ),
          );
        }
      } else {
        await saveToken(value['data']['accessTken'] ?? "");
        AppUtils.ErrorDialog(
          context,
          "Sent",
          'An OTP has been resent to you',
          'Close',
          Icon(
            Icons.check_circle_outline_rounded,
            color: Color.fromARGB(255, 10, 213, 13),
            size: 30,
          ),
        );
      }
    });

    return result;
  }
}
