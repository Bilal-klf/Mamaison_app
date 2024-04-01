import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class DataGet {

  Future<Response> sendGetRequest(BuildContext context, Uri apiUrl) async {

      var response = await http.get(apiUrl, headers: {"Content-Type": "application/json"});
      return response;

  }
}
