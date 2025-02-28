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

    if (response.statusCode == 200) {
      debugPrint('Status code = 200, success');
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load matrix data');
    }
  }

  Future<Map<String, dynamic>> sendSolutionsList(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to post data');
    }
    else {
      return json.decode(response.body);
    }
  }
}