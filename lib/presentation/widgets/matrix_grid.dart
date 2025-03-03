import 'package:flutter/material.dart';
import 'package:webspark_test_task/core/utils/utils.dart';
import 'package:webspark_test_task/data/models/solution.dart';
import '../../data/models/game_point.dart';

class MatrixGrid extends StatefulWidget {
  final Solution solution;

  const MatrixGrid({
    super.key, required this.solution,
  });

  @override
  State<MatrixGrid> createState() => _MatrixGridState();
}

class _MatrixGridState extends State<MatrixGrid> {
  late List<GamePoint> path;
  late List<GamePoint> blocked;

  @override
  Widget build(BuildContext context) {
    final List<List<GamePoint>> matrix = widget.solution.matrix;
    path = widget.solution.steps;
    blocked = widget.solution.blockedPoints;
    final GamePoint start = path.first;
    final GamePoint end = path.last;

    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: matrix[0].length,
              childAspectRatio: 1.0,
            ),
            itemCount: matrix.length * matrix[0].length,
            itemBuilder: (context, index) {
              int row = index ~/ matrix[0].length;
              int col = index % matrix[0].length;
              bool isOnPath = _isPointOnPath(row, col);
              bool isStart = start.x == row && start.y == col;
              bool isEnd = end.x == row && end.y == col;
              bool isBlocked = _isPointBlocked(row, col);

              return _buildGridCell(row, col, isOnPath, isStart, isEnd, isBlocked);
            },
          ),
        ),
        if (path.isNotEmpty)
              Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                formatPointsPathToString(path),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
        ),
      ],
    );
  }

  bool _isPointOnPath(int x, int y) {
    return path.any((point) => point.x == x && point.y == y);
  }

  bool _isPointBlocked(int x, int y) {
    return blocked.any((point) => point.x == x && point.y == y);
  }

  Widget _buildGridCell(int x, int y, bool onPath, bool isStart, bool isEnd, bool isBlocked) {
    Color startColor = hexToColor('#64FFDA');
    Color pathColor = hexToColor('#4CAF50');
    Color endColor = hexToColor('#009688');
    Color blockedColor = hexToColor('#000000');
    Color defaultColor = Colors.white;

    Color cellColor;

    if (isStart) {
      cellColor = startColor;
    } else if (isEnd) {
      cellColor = endColor;
    } else if (isBlocked) {
      cellColor = blockedColor;
    } else if (onPath) {
      cellColor = pathColor;
    } else {
      cellColor = defaultColor;
    }

    return Card(
      margin: const EdgeInsets.all(1),
      elevation: 2,
      color: cellColor,
      child: Center(
        child: Text(
          "($y,$x)",
          style: TextStyle(
            fontSize: 14,
            color: cellColor.computeLuminance() > 0.5 ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }
}