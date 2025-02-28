import 'package:webspark_test_task/data/models/game_point.dart';

class Solution {
  final String id;
  final List<GamePoint> steps;
  final String path;

  Solution({
    required this.id,
    required this.steps,
    required this.path,
  });

  factory Solution.fromJson(Map<String, dynamic> json) {
    return Solution(
      id: json['id'],
      steps: List<GamePoint>.from(json['game_point']),
      path: json['path'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'steps': steps,
    'path': path,
  };
}
