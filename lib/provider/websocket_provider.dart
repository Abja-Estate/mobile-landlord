import 'dart:convert';

import 'package:abjalandlord/utils/app_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

import '../constants/resources.dart';
import '../utils/local_storage.dart';
import '../utils/notification_util.dart';

class WebSocketProvider extends ChangeNotifier {
  late WebSocketChannel _channel;

  bool _result = false; // Initialize to false by default
  WebSocketProvider() {
    init();
  }

  WebSocketChannel get channel => _channel;
  bool get result => _result;
  void sendMessage(String message) {
    _channel.sink.add(message);
  }

  init() async {
    var id = await showId();
    var accessToken = await showToken();
    var wsUrl = '$WebsocketURL?id=$id';
    var headers = {
      'x-api-key': WebsocketAPIKEY,
      'Authorization': 'Bearer $accessToken'
    };
    _channel = IOWebSocketChannel.connect(wsUrl, headers: headers);
    _channel.stream.listen((message) {
      print(message);
      if (message == "Connected") {
        notifyListeners();
      } else if (message == "Sent.✔️") {
        _result = true;
        notifyListeners();
        notify("Request", "Request is being $message", true);
      } else if (message == "Seen.✔️✔️") {
        _result = true;
        notifyListeners();
        notify("Request", "Request is being $message", true);
      } else {
        var msg = Map<String, dynamic>.from(jsonDecode(message));

        notify(
            "New Request from ${msg["fullName"]}",
            "${msg["agent"]} is needed at ${msg["propertyName"]} on ${msg["day"]} between ${msg["period"]}",
            true);
      }
    }).onError((b) {});
  }

  void closeChannel() {
    _channel.sink.close(status.goingAway);
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }
}
