import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:recipe_app_flutter/constants/strings.dart';

class GeneralApi {
  //function for calling APIs that do not require parameters
  static Future<Map<String, dynamic>> getWithoutParams(String endpoint) async {
    //defining map which will be returned by function
    //status can be 0 or 1, 1 is a success and 0 is a failure
    //msg will store the error to display to the user
    Map<String, dynamic> responseMap = {
      "status": 0,
      "data": null,
      "msg": Strings.somethingWentWrong
    };
    try {
      //make API call
      final response = await http.get(Uri.parse(Strings.baseUrl + endpoint),
          headers: {"Accept": "application/json"});
      //check if it was successful
      if (response.statusCode == 200) {
        //set data to response body
        responseMap = {"status": 1, "data": response.body, "msg": null};
      } else {
        //throw exception if status code fails
        throw Exception(response.statusCode);
      }
    } catch (e) {
      //check if its a network error
      if (e is SocketException) {
        responseMap = {
          "status": 0,
          "data": null,
          "msg": Strings.noInternetConnection
        };
      }
      //check if its a timeout error
      else if (e is TimeoutException) {
        responseMap = {
          "status": 0,
          "data": null,
          "msg": Strings.requestTimedOut
        };
      } else {
        //return generic error message to user
        responseMap = {
          "status": 0,
          "data": null,
          "msg": Strings.somethingWentWrong
        };
      } 
    }
    return responseMap;
  }
}
