import '../../data/models/task.dart';
import '../repositories/data_repository.dart';

class FetchTaskListUseCase {
  final DataRepository repository;

  FetchTaskListUseCase(this.repository);

  Future<List<Task>> execute() async {
    try {
      return await repository.getTaskList();
    }
    catch (e) {
      rethrow;
    }
  }
}