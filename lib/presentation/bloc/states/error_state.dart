import 'package:webspark_test_task/presentation/bloc/states/progressing_state.dart';

class ErrorState extends ProcessingState {
  final String message;
  ErrorState(this.message);
}