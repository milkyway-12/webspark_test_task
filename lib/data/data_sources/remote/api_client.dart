import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../local/preferences_helper.dart';

class ApiClient {
  // final String? baseUrl = PreferencesHelper.instance.getServerUrl();
  final baseUrl = 'https://flutter.webspark.dev/flutter/api';

  Future<Map<String, dynamic>?> getTaskList() async {
    final response = await http.get(Uri.parse(baseUrl));
    debugPrint('Response: ${response.body}');

    if (response.body.isEmpty) {
      throw Exception("Empty response from server");}

    switch (response.statusCode) {
      case 200:
        debugPrint('Status code 200, success');
        return json.decode(response.body);

      case 429:
        throw Exception('Status code ${response.statusCode}. Too Many Requests');

      case 500:
        throw Exception('Status code ${response.statusCode}. Internal Server Error');

      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> sendSolutionsList(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      // headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    debugPrint('Response: ${response.body}');

    if (response.body.isEmpty) {
      throw Exception("Empty response from server");}

    switch (response.statusCode) {
      case 200:
        debugPrint('Status code 200, success');
        return json.decode(response.body);

      case 429:
        throw Exception('Status code ${response.statusCode}. Too Many Requests');

      case 500:
        throw Exception('Status code ${response.statusCode}. Internal Server Error');

      default:
        throw Exception('Unexpected error: ${response.statusCode}');
    }
    }
  }