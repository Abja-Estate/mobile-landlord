import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/resources.dart';
import '../utils/local_storage.dart';

class RequestAPI {
  static Future updateRequest(ticket) async {
    var id = await showId();
    var accessToken = await showToken();
    var response = await http.post(
      Uri.parse('$BaseURL/request/landlord/update_request'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-api-key': APIKEY,
        'authorization': 'Bearer $accessToken'
      },
      body: jsonEncode(<String, dynamic>{
        "landlordID": id,
        "ticketNumber": ticket,
      }),
    );

    var parsedResponse = jsonDecode(response.body);

    return parsedResponse;
  }

  static Future getAllRequest() async {
    var id = await showId();
    var accessToken = await showToken();
    var response = await http.post(
      Uri.parse('$BaseURL/request/landlord/all_tenant_request'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-api-key': APIKEY,
        'authorization': 'Bearer $accessToken'
      },
      body: jsonEncode(<String, String>{"landlordID": id}),
    );

    var parsedResponse = jsonDecode(response.body);
    print(parsedResponse);
    return parsedResponse;
  }
}
