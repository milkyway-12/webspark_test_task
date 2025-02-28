import '../../data/models/task.dart';

abstract class DataRepository {
  Future<Task> getTaskList();
  Future<void> sendSolutionsList(Task solution);
}