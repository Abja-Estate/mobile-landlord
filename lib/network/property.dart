import 'dart:convert';
import 'package:abjalandlord/utils/local_storage.dart';
import 'package:http/http.dart' as http;
import '../constants/resources.dart';

class PropertyAPI {
  static Future addProperty(data) async {
    var id = await showId();
    var accessToken = await showToken();
    var response = await http.post(
      Uri.parse('$BaseURL/service/landlord/add_property'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-api-key': APIKEY,
        'authorization': 'Bearer $accessToken'
      },
      body: jsonEncode(<String, dynamic>{
        "landlordID": id,
        "propertyID": data['propertyID'],
        "name": data['name'],
        "description": data['description'],
        "unit": data['unit'],
        "category": data['category'],
        "structure": data['structure'],
        "type": data['type'],
        "location": data['location'],
        "photo": data['photo'],
        "unitData": data['unitData'],
        "football": data['football'],
        "pool": data['pool'],
        "wifi": data['wifi'],
        "laundry": data['laundry'],
        "garden": data['garden'],
        "fitness": data['fitness'],
        "power": data['power']
      }),
    );

    var parsedResponse = jsonDecode(response.body);
    print(parsedResponse);
    return parsedResponse;
  }

  static Future deleteProperty(propid) async {
    var id = await showId();
 var accessToken = await showToken();
    var response = await http.post(
      Uri.parse('$BaseURL/service/landlord/delete_property'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
   'x-api-key': APIKEY,
        'authorization': 'Bearer $accessToken'
      },
      body:
          jsonEncode(<String, String>{"landlordID": id, "propertyID": propid}),
    );

    var parsedResponse = jsonDecode(response.body);
 
    return parsedResponse;
  }

  static Future getAllProperty() async {
    var id = await showId();
     var accessToken = await showToken();
    var response = await http.post(
      Uri.parse('$BaseURL/service/landlord/properties'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-api-key': APIKEY,
        'authorization': 'Bearer $accessToken'
      },
      body: jsonEncode(<String, String>{"landlordID": id}),
    );

    var parsedResponse = jsonDecode(response.body);

    return parsedResponse;
  }

  static Future tenantSelfies() async {
    var id = await showId();
     var accessToken = await showToken();
    var response = await http.post(
      Uri.parse('$BaseURL/service/landlord/all_tenant_selfie'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
    'x-api-key': APIKEY,
        'authorization': 'Bearer $accessToken'
      },
      body: jsonEncode(<String, String>{"landlordID": id}),
    );

    var parsedResponse = jsonDecode(response.body);

    return parsedResponse;
  }

  static Future getAllPropertiesData() async {
    var id = await showId();
     var accessToken = await showToken();
    var response = await http.post(
      Uri.parse('$BaseURL/service/landlord/propertiesdata'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-api-key': APIKEY,
        'authorization': 'Bearer $accessToken'
      },
      body: jsonEncode(<String, String>{"landlordID": id}),
    );

    var parsedResponse = jsonDecode(response.body);

    return parsedResponse;
  }

  static Future getProperty(propid) async {
 var accessToken = await showToken();
    var id = await showId();
    var response = await http.post(
      Uri.parse('$BaseURL/service/landlord/propertybyid'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      'x-api-key': APIKEY,
        'authorization': 'Bearer $accessToken'
      },
      body: jsonEncode(
          <String, String>{"landlordID": id, "propertyID": propid.toString()}),
    );

    var parsedResponse = jsonDecode(response.body);

    return parsedResponse;
  }

  static Future getPropertyName() async {
    var id = await showId();
     var accessToken = await showToken();
    var response = await http.post(
      Uri.parse('$BaseURL/service/landlord/propertiesbyname'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
       'x-api-key': APIKEY,
        'authorization': 'Bearer $accessToken'
      },
      body: jsonEncode(<String, String>{"landlordID": id}),
    );

    var parsedResponse = jsonDecode(response.body);

    return parsedResponse;
  }

  static Future getPropertyTenants(propID) async {
    var id = await showId();
     var accessToken = await showToken();
    var response = await http.post(
      Uri.parse('$BaseURL/service/landlord/all_property_tenants'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
    'x-api-key': APIKEY,
        'authorization': 'Bearer $accessToken'
      },
      body:
          jsonEncode(<String, String>{"landlordID": id, "propertyID": propID}),
    );

    var parsedResponse = jsonDecode(response.body);

    return parsedResponse;
  }

  static Future uploadImage(selfie) async {
     var accessToken = await showToken();
    var response = await http.post(
      Uri.parse('$BaseURL/service/landlord/upload'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
       'x-api-key': APIKEY,
        'authorization': 'Bearer $accessToken'
      },
      body: jsonEncode(<String, String>{"selfie": selfie}),
    );

    var parsedResponse = jsonDecode(response.body);

    return parsedResponse;
  }

  static Future refresh(email) async {
  var accessToken = await showToken();
    var response = await http.put(
      Uri.parse('$BaseURL/auth/landlord/refresh_token'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-api-key': APIKEY,
        'authorization': 'Bearer $accessToken'
      },
      body: jsonEncode(<String, String>{"email": email}),
    );
    var parsedResponse = jsonDecode(response.body);
    return parsedResponse;
  }

  static Future addTenant(data) async {
    var id = await showId();
 var accessToken = await showToken();
    var response = await http.post(
      Uri.parse('$BaseURL/service/landlord/add_tenant_unit'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
       'x-api-key': APIKEY,
        'authorization': 'Bearer $accessToken'
      },
      body: jsonEncode(<String, dynamic>{
        "email": data['email'],
        "landlordID": id,
        "propertyID": data['propertyID'],
        "unitID": data['unitID'],
        "phone": data['phone'],
        "startDate": data['startDate'],
        "endDate": data['endDate'],
        "name": data['name'],
        "surname": data['surname'],
        "idPhoto": data['idPhoto'],
        "receiptPhoto": data['receiptPhoto'],
        "rentalPhoto": data['rentalPhoto'],
      }),
    );

    var parsedResponse = jsonDecode(response.body);
    return parsedResponse;
  }

  static Future addUnit(data) async {
    var id = await showId();
   var accessToken = await showToken();
    var response = await http.post(
      Uri.parse('$BaseURL/service/landlord/add_unit'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
    'x-api-key': APIKEY,
        'authorization': 'Bearer $accessToken'
      },
      body: jsonEncode(<String, dynamic>{
        "propertyID": data['propertyID'],
        "unitData": data['unitData'],
        "landlordID": id,
      }),
    );

    var parsedResponse = jsonDecode(response.body);
    return parsedResponse;
  }
}
