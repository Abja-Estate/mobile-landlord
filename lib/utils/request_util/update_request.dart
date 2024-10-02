import 'dart:io';
import 'package:abjalandlord/provider/request_provider.dart';
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'package:provider/provider.dart';
import '../../constants/app_routes.dart';
import '../../provider/auth_provider.dart';
import '../app_utils.dart';
import '../local_storage.dart';

class UpdateRequestUtil {
  static Future<String> update(BuildContext context, ticket) async {
    var result;

    Provider.of<RequestProvider>(context, listen: false)
        .updateRequest(ticket)
        .then((value) async {
   
      if (value['statusCode'] != 200) {
        if (value['statusCode'] == 403) {
          if (value["error"] == "Expired Bearer token") {
            Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.loginScreen, (route) => false);
          }
        }
      } else {
        Provider.of<RequestProvider>(context, listen: false).getAllRequest();
      }
    });

    return result;
  }
}
