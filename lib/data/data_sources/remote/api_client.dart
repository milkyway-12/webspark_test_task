import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../domain/use_cases/get_server_url_use_case.dart';
import '../local/preferences_helper.dart';

class ApiClient {
  final getUrlUseCase = GetServerUrlUseCase(PreferencesHelper.instance);

  Future<Map<String, dynamic>?> getTaskList() async {
    final baseUrl = getUrlUseCase.execute() ?? 'https://flutter.webspark.dev/flutter/api';

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

  Future<Map<String, dynamic>> sendSolutionsList(List<Map<String, dynamic>> data) async {
    final baseUrl = getUrlUseCase.execute() ?? 'https://flutter.webspark.dev/flutter/api';

    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
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