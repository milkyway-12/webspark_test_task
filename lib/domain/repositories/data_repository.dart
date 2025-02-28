import 'package:webspark_test_task/data/models/response_on_solution.dart';
import '../../data/models/solution.dart';
import '../../data/models/task.dart';

abstract class DataRepository {
  Future<List<Task>> getTaskList();
  Future<ResponseOnSolution> sendSolutionsList(List<Solution> solutionsList);
}