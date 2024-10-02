import 'package:abjalandlord/constants/app_routes.dart';
import 'package:flutter/material.dart';

import '../views/dashboard/dashboard.dart';
import '../views/navbar/nav.dart';

Future<bool> onBackPressed(
  BuildContext context,
  screen,
  pointer,
) async {
  // Your logic to handle the back button press
  // Return true to allow the pop, and false to prevent it
  // For example:
  await Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
        builder: (context) =>
            NavBar(initialScreen: screen, initialTab: pointer)),
    (route) => false,
  );
  return true;
}
