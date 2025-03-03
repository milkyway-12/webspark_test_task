import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webspark_test_task/presentation/pages/result_list_screen.dart';
import '../bloc/processing_bloc.dart';

class ProcessScreen extends StatelessWidget {
  const ProcessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.blue,
          statusBarIconBrightness: Brightness.light,
        ),
      );
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Process screen",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.lightBlue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
        body: BlocConsumer<ProcessingBloc, ProcessingState>(
          listener: (context, state) {
            if (state is SuccessState) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultListScreen(results: state.results),
                ),
              );
            } else if (state is ErrorState) {
              // Отобразить сообщение об ошибке
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            int progress = 0;
            bool isProcessing = true;
            String statusMessage = "Processing tasks...";
            VoidCallback? onPressed;

            if (state is InitialState) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.read<ProcessingBloc>().add(FetchTasksEvent());
              });
            } else if (state is LoadingTasksState) {
              progress = 0;
            } else if (state is CalculatingState) {
              progress = state.progress;
            } else if (state is CalculationFinishedState) {
              progress = 100;
              isProcessing = false;
              statusMessage = "All calculations have finished, you can send\nyour results to the server";
              onPressed = () => context.read<ProcessingBloc>().add(SendResultsEvent());
            } else if (state is SendingResultsState) {
              progress = 100;
            } else if (state is ErrorState) {
              progress = 100;
              isProcessing = false;
              statusMessage = state.message;
              onPressed = () => context.read<ProcessingBloc>().add(SendResultsEvent());
            }

            return _buildProgressUI(context, progress, isProcessing, statusMessage, onPressed, state);
          },

        ));
  }
}


  Widget _buildProgressUI(
      BuildContext context,
      int progress,
      bool isProcessing,
      String statusMessage,
      VoidCallback? onPressed,
      ProcessingState state
      ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Text(
              statusMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            if (state is! ErrorState)
              Text(
                "$progress%",
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            const SizedBox(height: 16),
            if (state is! ErrorState)
              SizedBox(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(
                  value: progress / 100,
                  strokeWidth: 6,
                  backgroundColor: Colors.blue.withOpacity(0.2),
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ),
            const Spacer(),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: onPressed == null ? Colors.grey : Colors.lightBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: onPressed == null
                        ? const BorderSide(color: Colors.grey, width: 3)
                        : const BorderSide(color: Colors.blue, width: 1),
                  ),
                ),
                onPressed: onPressed,
                child: onPressed == null
                    ? const Text("Processing...", style: TextStyle(color: Colors.white))
                    : const Text("Send results to server", style: TextStyle(color: Colors.black)),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
