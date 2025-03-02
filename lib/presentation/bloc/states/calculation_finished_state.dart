import 'package:webspark_test_task/presentation/bloc/states/progressing_state.dart';

import '../../../data/models/solution.dart';

class CalculationFinishedState extends ProcessingState {
  final List<Solution> results;
  CalculationFinishedState(this.results);
}