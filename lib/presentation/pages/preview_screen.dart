import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webspark_test_task/data/models/solution.dart';

import '../widgets/matrix_grid.dart';

class PreviewScreen extends StatefulWidget{
  final Solution solution;

  const PreviewScreen({
    super.key,
    required this.solution});

  @override
  _PreviewScreenState createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {

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
                'Preview screen',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),),
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white)),
              backgroundColor: Colors.lightBlue,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: MatrixGrid(
                        solution: widget.solution
                    ),
                  ),
                ],
              ),
            )
        ));
  }
}