import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../network/request.dart';

class RequestProvider extends ChangeNotifier {
  List _request = [];
  bool _isFetchingRequest = false;
  List get request => _request;
  bool get isFetchingRequest => _isFetchingRequest;

  RequestProvider() {
    getAllRequest();
  }

  Future<void> getAllRequest() async {
    _isFetchingRequest = true;
    notifyListeners();
    try {
      var responseData = await RequestAPI.getAllRequest();
      if (responseData['statusCode'] == 200) {
        _request = responseData['data'];
        notifyListeners();
        _isFetchingRequest = false;
      } else {
        _isFetchingRequest = false;
        _request = [];
        notifyListeners();
      }
    } catch (e) {
      _request = [];
    }
  }

  Future <Map<String, dynamic>>updateRequest(ticket) async {
    var data;

    notifyListeners();
    try {
      var responseData = await RequestAPI.updateRequest(ticket);
      if (responseData['statusCode'] == 200) {
        data = responseData;
        notifyListeners();
      } else {
        data = responseData;
        notifyListeners();
      }
    } catch (e) {
      data;
    }
    return data;
  }
}
