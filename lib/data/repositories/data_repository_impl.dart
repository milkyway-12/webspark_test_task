import 'package:flutter/cupertino.dart';
import 'package:webspark_test_task/data/models/response_on_solution.dart';
import '../../domain/repositories/data_repository.dart';
import '../data_sources/remote/api_client.dart';
import '../models/solution.dart';
import '../models/task.dart';

class DataRepositoryImpl implements DataRepository {
  final ApiClient apiClient;

  DataRepositoryImpl({required this.apiClient});

  @override
  Future<List<Task>> getTaskList() async {
    try {
      final Map<String, dynamic>? jsonData = await apiClient.getTaskList();

      if (jsonData == null || !jsonData.containsKey('data')) {
        throw Exception('Incorrect json: data is absent');
      }

      if (jsonData['data'] is! List) {
        throw Exception('Incorrect data: data is not list');
      }

      final List<Task> taskList = (jsonData['data'] as List)
          .map((taskJson) {
        if (taskJson is! Map<String, dynamic>) {
          throw Exception('Incorrect Task model format');
        }
        return Task.fromJson(taskJson);
      })
          .toList();

      debugPrint('List of tasks from server: $taskList');
      return taskList;
    } on FormatException {
      throw Exception('Formatting data error');
    } on TypeError {
      throw Exception('Type error');
    } catch (e) {
      throw Exception('Ecxeption: $e');
    }
  }


  @override
  Future<ResponseOnSolution> sendSolutionsList(List<Solution> solutionsList) async {

    final List<Map<String, dynamic>> data =
    solutionsList.map((solution) => solution.toJson()).toList();

    try {
      final Map<String, dynamic>? jsonData =  await apiClient.sendSolutionsList(data);
      debugPrint('JsonData for ResponseOnSolution ${jsonData.toString()}');

      if (jsonData == null || jsonData == '') {
        throw Exception('Incorrect json: absent data');
      }

      final ResponseOnSolution response = jsonData['data']
          .map((taskJson) {
        if (taskJson is! Map<String, dynamic>) {
          throw Exception('Incorrect ResponseOnSolution model format');
        }
        return Task.fromJson(taskJson);
      });

      debugPrint('Response from server: $response');
      return response;
    } on FormatException {
      throw Exception('Formatting data error');
    } on TypeError {
      throw Exception('Type error');
    } catch (e) {
      throw Exception('Exception: $e');
    }
    }
}