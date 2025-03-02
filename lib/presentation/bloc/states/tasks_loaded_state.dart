import 'package:webspark_test_task/presentation/bloc/states/progressing_state.dart';
import '../../../data/models/task.dart';

class TasksLoadedState extends ProcessingState {
  final List<Task> tasks;
  TasksLoadedState(this.tasks);
}