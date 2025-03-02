import 'package:webspark_test_task/presentation/bloc/states/progressing_state.dart';

class CalculatingState extends ProcessingState {
  final int progress;
  CalculatingState(this.progress);
}