import 'package:flutter/material.dart';
import 'package:webspark_test_task/data/models/game_point.dart';

import '../widgets/matrix_grid.dart';

class PreviewScreen extends StatefulWidget{
  const PreviewScreen({super.key});

  @override
  _PreviewScreenState createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {

  @override
  Widget build(BuildContext context) {
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
                        matrix: [
                          [GamePoint(x: 0, y: 0), GamePoint(x: 0, y: 1), GamePoint(x: 0, y: 2), GamePoint(x: 0, y: 3)],
                          [GamePoint(x: 1, y: 0), GamePoint(x: 1, y: 1), GamePoint(x: 1, y: 2), GamePoint(x: 1, y: 3)],
                          [GamePoint(x: 2, y: 0), GamePoint(x: 2, y: 1), GamePoint(x: 2, y: 2), GamePoint(x: 2, y: 3)],
                          [GamePoint(x: 3, y: 0), GamePoint(x: 3, y: 1), GamePoint(x: 3, y: 2), GamePoint(x: 3, y: 3)],
                        ],
                        path: [GamePoint(x: 0, y: 3), GamePoint(x: 0, y: 2), GamePoint(x: 0, y: 1)],
                        blocked: [GamePoint(x: 1, y: 1)],
                        start: GamePoint(x: 0, y: 3),
                        end: GamePoint(x: 0, y: 1)
                    ),
                  ),
                ],
              ),
            )
        ));
  }
}