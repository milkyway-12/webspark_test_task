import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webspark_test_task/domain/services/path_finder_service.dart';
import 'package:webspark_test_task/presentation/bloc/bloc/processing_bloc.dart';
import 'package:webspark_test_task/presentation/pages/home_screen.dart';
import 'data/data_sources/local/preferences_helper.dart';
import 'data/data_sources/remote/api_client.dart';
import 'data/repositories/data_repository_impl.dart';
import 'domain/use_cases/fetch_task_list_use_case.dart';
import 'domain/use_cases/find_shortest_path_use_case.dart';
import 'domain/use_cases/send_results_use_case.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesHelper.instance.init();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.blue,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  final apiClient = ApiClient();
  final dataRepository = DataRepositoryImpl(apiClient: apiClient);
  final pathFinderService = PathFinderService();

  runApp(
    BlocProvider(
      create: (context) => ProcessingBloc(
        fetchTasks: FetchTaskListUseCase(dataRepository),
        findShortestPath: FindShortestPathUseCase(pathFinderService),
        sendResults: SendResultsUseCase(apiClient),
      ),
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WEBSPARK',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}