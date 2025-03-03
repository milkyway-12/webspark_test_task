import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webspark_test_task/presentation/pages/preview_screen.dart';
import '../../data/models/solution.dart';

class ResultListScreen extends StatelessWidget {
  final List<Solution> results;

  const ResultListScreen({super.key, required this.results});
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
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text(
                'Result list screen',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
              backgroundColor: Colors.lightBlue,
            ),
            body:
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: results.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: Column(
                              children: [
                                ListTile(
                              title: Text(
                                results[index].path,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600
                                ),
                                textAlign: TextAlign.center,
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PreviewScreen(solution: results[index]),
                                  ),
                                );
                              },
                            ),
                          Container(
                          width: double.maxFinite,
                            color: Colors.grey,
                            height: 1,
                          )
                          ]
                          ));
                        },
                      ),
                    ),
                  ]
              ),
            )
        );
  }
}