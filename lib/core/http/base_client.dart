import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String baseUrl = "http://192.168.1.232:8000/api/v1";

class BaseClient {
  var client = http.Client();

  late SharedPreferences _storage;

  Future<dynamic> get(String endPoint) async {
    var url = Uri.parse(baseUrl + endPoint);
    _storage = await SharedPreferences.getInstance();
    String? token = _storage.getString('access_token');
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    try {
      var response = await client.get(url, headers: headers);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        // throw
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> post(String endPoint, dynamic data) async {
    var url = Uri.parse(baseUrl + endPoint);
    var _payload = json.encode(data);
    _storage = await SharedPreferences.getInstance();
    debugPrint("init storage");
    String? token = _storage.getString('access_token');
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    var response = await client.post(url, body: _payload, headers: headers);
    if (response.statusCode == 204 || response.statusCode == 200) {
      debugPrint("post success");
      return jsonDecode(response.body);
    } else {
      throw Exception("Error happend when post data");
    }
  }

  Future<dynamic> put(String endPoint, dynamic data) async {
    var url = Uri.parse(baseUrl + endPoint);
    var _payload = json.encode(data);

    _storage = await SharedPreferences.getInstance();
    String? token = _storage.getString('access_token');
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    var response = await client.put(url, body: _payload, headers: headers);

    print("put success");

    if (response.statusCode == 204 || response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Error happend when put data");
    }
  }

  Future<dynamic> delete(String endPoint) async {
    var url = Uri.parse(baseUrl + endPoint);
    // var _headers = {};

    var response = await client.delete(url);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      // throw
    }
  }
}
