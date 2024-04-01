import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class DataPost{

  Future<bool> sendPostRequest(BuildContext context,String jsonEncode,Uri apiUrl) async {
    var response = await http.post(apiUrl,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}