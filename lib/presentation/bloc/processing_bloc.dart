import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/solution.dart';
import '../../domain/use_cases/fetch_task_list_use_case.dart';
import '../../domain/use_cases/find_shortest_path_use_case.dart';
import '../../domain/use_cases/send_results_use_case.dart';

abstract class ProcessingEvent {}

class FetchTasksEvent extends ProcessingEvent {}
class StartCalculationsEvent extends ProcessingEvent {}
class SendResultsEvent extends ProcessingEvent {}

abstract class ProcessingState {}

class InitialState extends ProcessingState {}
class LoadingTasksState extends ProcessingState {}
class TasksLoadedState extends ProcessingState {
  final List<dynamic> tasks;
  TasksLoadedState(this.tasks);
}
class CalculatingState extends ProcessingState {
  final int progress;
  CalculatingState(this.progress);
}
class CalculationFinishedState extends ProcessingState {
  final List<Solution> results;
  CalculationFinishedState(this.results);
}
class SendingResultsState extends ProcessingState {
  final List<Solution> results;
  SendingResultsState(this.results);
}
class SuccessState extends ProcessingState {
  final List<Solution> results;
  SuccessState(this.results);
}
class ErrorState extends ProcessingState {
  final String message;
  final List<Solution> results;
  ErrorState(this.message, this.results);
}

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
      add(StartCalculationsEvent());
    } catch (e) {
      emit(ErrorState(e.toString(), []));
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

    emit(SendingResultsState(currentState.results));
    try {
      await sendResults.execute(currentState.results);
      emit(SuccessState(currentState.results));
    } catch (e) {
      emit(ErrorState(e.toString(), currentState.results));
    }
  }
}