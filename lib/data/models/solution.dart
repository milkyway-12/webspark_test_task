import 'package:webspark_test_task/data/models/game_point.dart';

class Solution {
  final String id;
  final List<GamePoint> steps;
  final String path;
  final List<List<GamePoint>> matrix;
  final List<GamePoint> blockedPoints;

  Solution({
    required this.id,
    required this.steps,
    required this.path,
    required this.matrix,
    required this.blockedPoints
  });

  Map<String, dynamic> toJson() =>
    {
      'id': id,
      'result': {
        'steps': steps,
        'path': path,
      }
    };
}
