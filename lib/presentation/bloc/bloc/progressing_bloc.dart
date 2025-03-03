import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/solution.dart';
import '../../../domain/use_cases/fetch_task_list_use_case.dart';
import '../../../domain/use_cases/find_shortest_path_use_case.dart';
import '../../../domain/use_cases/send_results_use_case.dart';
import '../events/fetch_tasks_event.dart';
import '../events/processing_event.dart';
import '../events/send_results_event.dart';
import '../events/start_calculations_event.dart';
import '../states/calculating_state.dart';
import '../states/calculation_finished_state.dart';
import '../states/error_state.dart';
import '../states/initial_state.dart';
import '../states/loading_tasks_state.dart';
import '../states/progressing_state.dart';
import '../states/sending_results_state.dart';
import '../states/success_state.dart';
import '../states/tasks_loaded_state.dart';

class ProcessingBloc extends Bloc<ProcessingEvent, ProcessingState> {
  final FetchTaskListUseCase fetchTasks;
  final FindShortestPathUseCase findShortestPath;
  final SendResultsUseCase sendResults;

  ProcessingBloc({
    required this.fetchTasks,
    required this.findShortestPath,
    required this.sendResults,
  }) : super(InitialState()) {
    on<FetchTasksEvent>(_onFetchTasks);
    on<StartCalculationsEvent>(_onStartCalculations);
    on<SendResultsEvent>(_onSendResults);
  }

  Future<void> _onFetchTasks(FetchTasksEvent event, Emitter<ProcessingState> emit) async {
    emit(LoadingTasksState());
    try {
      final tasks = await fetchTasks.execute();
      emit(TasksLoadedState(tasks));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }

  Future<void> _onStartCalculations(StartCalculationsEvent event, Emitter<ProcessingState> emit) async {
    final currentState = state;
    if (currentState is! TasksLoadedState) return;

    List<Solution> results = [];
    for (int i = 0; i < currentState.tasks.length; i++) {
      final result = findShortestPath.execute(currentState.tasks[i]);
      results.add(result);
      emit(CalculatingState(((i + 1) / currentState.tasks.length * 100).toInt()));
    }
    emit(CalculationFinishedState(results));
  }

  Future<void> _onSendResults(SendResultsEvent event, Emitter<ProcessingState> emit) async {
    final currentState = state;
    if (currentState is! CalculationFinishedState) return;

    emit(SendingResultsState());
    try {
      await sendResults.execute(currentState.results);
      emit(SuccessState());
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}