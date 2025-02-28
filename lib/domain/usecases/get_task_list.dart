import '../../data/models/task.dart';
import '../repositories/data_repository.dart';

class GetTaskList {
  final DataRepository repository;

  GetTaskList(this.repository);

  Future<List<Task>> execute() async {
    return await repository.getTaskList();
  }
}