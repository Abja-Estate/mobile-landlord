import 'package:abjalandlord/views/auth/loading.dart';
import 'package:abjalandlord/views/auth/login/login.dart';
import 'package:abjalandlord/views/auth/package.dart';
import 'package:abjalandlord/views/auth/register/register.dart';
import 'package:abjalandlord/views/auth/welcome/welcome.dart';
import 'package:abjalandlord/views/dashboard/dashboard.dart';
import 'package:abjalandlord/views/drawer_menu/sidebar.dart';
import 'package:abjalandlord/views/profile/edit_profile.dart';
import 'package:abjalandlord/views/profile/profile.dart';
import 'package:abjalandlord/views/property/add/add-property.dart';
import 'package:abjalandlord/views/property/add/add-unit-more.dart';
import 'package:abjalandlord/views/property/details/property-details.dart';
import 'package:abjalandlord/views/request/request.dart';
import 'package:abjalandlord/views/settings/content/content.dart';
import 'package:abjalandlord/views/settings/settings.dart';
import 'package:abjalandlord/views/tenant/add_tenant.dart';
import 'package:abjalandlord/views/tenant/tenant_profile.dart';
import 'package:flutter/widgets.dart';

import '../views/auth/forgotPassword/change_password.dart';
import '../views/auth/forgotPassword/forgotPassword.dart';
import '../views/auth/forgotPassword/otp.dart';
import '../views/auth/register/register_otp.dart';
import '../views/navbar/nav.dart';
import '../views/onboarding/onboarding.dart';
import '../views/property/add/add-unit.dart';
import '../views/request/create_request/create_request.dart';
import '../views/request/create_request/request_details.dart';
import '../views/request/view_request/view_request.dart';
import '../views/tenant/tenants.dart';

class AppRoutes {
  static const dashboardScreen = '/dashboardScreen';
  static const propDetails = '/propDetails';
  static const welcomeScreen = '/welcomeScreen';

  static const profile = '/profile';
  static const editProfile = '/editProfile';
  static const about = './history';

  static const randomSearch = '/randomSearchScreen';
  static const addTenant = '/addTenant';

  static const webviewScreen = '/webview';
  static const checkOut = '/checkOut';

  static const loginScreen = '/loginScreen';
  static const forgotPassword = '/forgotPassword';
  static const selectTest = '/selectTest';
  static const ordersScreen = '/ordersScreen';
  static const drugOrdersScreen = '/drugOrdersScreen';
  static const diag = '/diag';
  static const package = '/package';

  static const loadHome = '/loadHome';
  static const privacy = '/privacy';
  static const terms = '/terms';
  static const requestDetails = './requestDetails';
  static const createRequest = './createRequest';
  static const requestScreen = './requestScreen';
  static const registerOTPScreen = '/registerOTPScreen';
  static const changePassword = '/changePassword';
  static const registerScreen = '/registerScreen';
  static const resetOTPScreen = '/resetOTPScreen';
  static const addProperty = '/addProperty';
  static const addUnit = '/addUnit';
  static const viewRequest = '/viewRequest';
  static const addMoreUnit = '/addMoreUnit';
  static const makeRequest = '/makeRequest';
  static const tenants = '/tenants';
  static const onboarding = '/onboarding';
  static const tenantsProfile = '/tenantsprofile';
  static const settings = '/settings';
  static const settingsDetails = '/settingsDetails';
  static Map<String, WidgetBuilder> routes() {
    return <String, WidgetBuilder>{
      AppRoutes.createRequest: (context) => CreateRequest(),
         AppRoutes.viewRequest: ((context) => ViewRequest()),
      AppRoutes.requestScreen: (context) => RequestScreen(),
      AppRoutes.requestDetails: (context) => RequestDetails(),
      AppRoutes.welcomeScreen: ((context) => Welcome()),
      AppRoutes.onboarding: (context) => OnboardingScreen(),
      AppRoutes.forgotPassword: ((context) => PasswordResetScreen()),
      AppRoutes.settings: ((context) => Settings()),
      AppRoutes.settingsDetails: ((context) => SettingsContent()),
      AppRoutes.editProfile: ((context) => EditProfile()),
      AppRoutes.addProperty: ((context) => AddProperty()),
      AppRoutes.addUnit: ((context) => AddUnit()),
      AppRoutes.makeRequest: ((context) => AddProperty()),
      AppRoutes.changePassword: (context) => NewPasswordScreen(),
      AppRoutes.registerOTPScreen: (context) => RegisterOTPScreen(),
      AppRoutes.resetOTPScreen: (context) => ResetOTPScreen(),
      AppRoutes.loginScreen: (context) => LoginScreen(),
      AppRoutes.registerScreen: (context) => SignUp(),
      AppRoutes.loadHome: (context) => LoadingHomeScreen(),
      AppRoutes.package: (context) => Package(),
      AppRoutes.profile: (context) => Profile(),
      AppRoutes.dashboardScreen: (context) => Dashboard(),
      AppRoutes.addTenant: (context) => AddTenant(),
      AppRoutes.addMoreUnit: (context) => AddMoreUnit(),
      AppRoutes.tenants: (context) => Tenants(),
      AppRoutes.tenantsProfile: (context) => TenantProfile(),
      AppRoutes.propDetails: (context) => PropertyDetails(),
    };
  }
}
