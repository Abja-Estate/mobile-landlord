import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:abjalandlord/constants/app_routes.dart';
import 'package:abjalandlord/views/dashboard/dashboard.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../network/property.dart';
import '../utils/local_storage.dart';

class PropertyProvider extends ChangeNotifier {
  List _property = [];
  List<String> _tenantSelfies = [];
  bool _isLoadingPropertyData = false;
   bool _isExpired = false;
  bool _isLoadingShowProperty = false;
  bool _isLoadingProperty = false;
  dynamic _propertiesInfo;

   init(){
  
    getAllProperties();
    getPropertiesName();
    getPropertyItems();
    getPropertiesData();
    allTenantSelfies();
  }

  List get property => _property;
  List<String> get tenantSelfies => _tenantSelfies;
  bool get isLoadingProperty => _isLoadingProperty;
  bool get isLoadingShowProperty => _isLoadingShowProperty;
  bool get isLoadingPropertyData => _isLoadingPropertyData;
  bool get isExpired => _isExpired;
  dynamic get propertiesInfo => _propertiesInfo;

  Future<Map<String, dynamic>> createProperty(dataobj) async {
    dynamic data;
    //dynamic dataz;
    //List<dynamic> data;
    notifyListeners();

    try {
      var responseData = await PropertyAPI.addProperty(dataobj);

      data = responseData;

      if (responseData['statusCode'] == 200) {
        notifyListeners();
        print(data);
        data;
      } else {
        data;
      }
    } catch (e) {
      notifyListeners();
      data = {'error': e};
    }
    return data;
  }

  Future<dynamic> allTenantSelfies() async {
    dynamic data;

    try {
      var responseData = await PropertyAPI.tenantSelfies();

      if (responseData['statusCode'] == 200) {
        List<String> stringList = List<String>.from(responseData['data']);

        _tenantSelfies = stringList as List<String>;
        notifyListeners();
        print(_tenantSelfies);
      } else {
        _tenantSelfies = [];
      }
    } catch (e) {
      notifyListeners();
      data = {'error': e};
    }
  }

  Future<Map<String, dynamic>> deleteProperty(pid) async {
    dynamic data;
    //dynamic dataz;
    //List<dynamic> data;
    notifyListeners();

    try {
      var responseData = await PropertyAPI.deleteProperty(pid);

      data = responseData;

      if (responseData['statusCode'] == 200) {
        notifyListeners();
        print(data);
        data;
      } else {
        data;
      }
    } catch (e) {
      notifyListeners();
      data = {'error': e};
    }
    return data;
  }

  Future<Map<String, dynamic>> addTenantToUnit(dataobj) async {
    dynamic data;
    //dynamic dataz;
    //List<dynamic> data;
    notifyListeners();

    try {
      var responseData = await PropertyAPI.addTenant(dataobj);

      data = responseData;

      if (responseData['statusCode'] == 200) {
        notifyListeners();
        print(data);
        data;
      } else {
        data;
      }
    } catch (e) {
      notifyListeners();
      data = {'error': e};
    }
    return data;
  }

  Future<Map<String, dynamic>> addUnit(dataobj) async {
    dynamic data;
    //dynamic dataz;
    //List<dynamic> data;
    notifyListeners();

    try {
      var responseData = await PropertyAPI.addUnit(dataobj);

      data = responseData;

      if (responseData['statusCode'] == 200) {
        notifyListeners();
        print(data);
        data;
      } else {
        data;
      }
    } catch (e) {
      notifyListeners();
      data = {'error': e};
    }
    return data;
  }

  getAllProperties() async {
    var res = await PropertyAPI.getAllProperty();

    var gotproperties = res['data'];

    if (res['statusCode'] != 200) {
       if (res['statusCode'] == 403) {
            if (res["error"] == "Expired Bearer token") {
                 notifyListeners();
                 _isExpired=true;
             
            }
       }
    } else {
      savePropertyItem(gotproperties);
      Future.delayed(const Duration(milliseconds: 500), () {
        getPropertyItems();
      });
    }
  }
  getPropertiesName() async {
    var res = await PropertyAPI.getPropertyName();

    if (res['statusCode'] != 200) {
      await savePropertyName([]);
    } else {
      var gotproperties = res['data'];

      await savePropertyName(gotproperties);
    }
  }

  getPropertiesData() async {
    notifyListeners();
    _isLoadingPropertyData = true;
    var res = await PropertyAPI.getAllPropertiesData();
    var allPropertiesInfo = res['data'];

    if (res['statusCode'] != 200) {
    } else {
      if (allPropertiesInfo != null) {
        _isLoadingPropertyData = false;
        _propertiesInfo = allPropertiesInfo;
        notifyListeners();
      } else {
        _isLoadingPropertyData = false;
        _propertiesInfo;
        notifyListeners();
      }
    }
  }

  getPropertyItems() async {
    _isLoadingShowProperty = true;
    notifyListeners();
    var propertyString = await showPropertyItem();
    var getproperty =
        List<Map<String, dynamic>>.from(jsonDecode(propertyString));
  
    if (getproperty.isEmpty) {
            _property = getproperty;
      _isLoadingShowProperty = false;
      notifyListeners();
  
      getAllProperties();
    } else {
      _property = getproperty;
      _isLoadingShowProperty = false;
      notifyListeners();
    }
  }
}
