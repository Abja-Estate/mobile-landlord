import 'dart:async';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import '../network/property.dart';
import '../network/user.dart';
import '../utils/app_utils.dart';
import '../utils/local_storage.dart';
import '../utils/permissions.dart';

class UserProvider extends ChangeNotifier {
  String _name = "";
  String _photo = "";
  String _email = "";
  String _about = "";
  Map<String, dynamic> _user = {};
  String _surname = "";
  bool _isLoadingUser = false;
  var _createdAt;
  List _historyData = [];
  bool _fetchingHistory = true;

  String get name => _name;
  String get about => _about;
  Map<String, dynamic> get user => _user;
  String get email => _email;
  bool get isLoadingUser => _isLoadingUser;
  String get createdAt => _createdAt;
  String get surname => _surname;
  String get photo => _photo;
  List get history => _historyData;
  bool get fetchingHistory => _fetchingHistory;

  initUserData() {
    getUserData();
    getAllHistory();
    //notifyListeners();
  }

  Future<void> getAllHistory() async {
    _fetchingHistory = true;
    notifyListeners();

    try {
      var responseData = await UserAPI.history();

      if (responseData['statusCode'] == 200) {
        _historyData = List<Map<String, dynamic>>.from(responseData['data']);
     
        _fetchingHistory = false;
        notifyListeners();
      } else {
        _historyData = [];
          _fetchingHistory = false;
        notifyListeners();

        // Additional error handling or logging can be added here
      }
    } catch (e) {
      print({'error': e.toString()});
      _historyData = [];
      // Additional error handling or logging can be added here
    }
  }

  getUserData() async {
    _isLoadingUser = true;
    notifyListeners();
    var userString = await showUser();

    var getUser = Map<String, dynamic>.from(jsonDecode(userString));
    Future.delayed(Duration(milliseconds: 200), () {
      if (getUser.isEmpty) {
        _user = {};
        _isLoadingUser = false;

        notifyListeners();
      } else {
        _user = getUser;
        _isLoadingUser = false;
        print(_user);
        notifyListeners();
      }
      // Do something
    });
  }
}
