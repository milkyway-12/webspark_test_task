import 'package:webspark_test_task/data/models/game_point.dart';

class Task {
  final String id;
  final List<String> field;
  final GamePoint start;
  final GamePoint end;

  Task({
    required this.id,
    required this.field,
    required this.start,
    required this.end,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      field: List<String>.from(json['field']),
      start: GamePoint.fromJson(json['start']),
      end: GamePoint.fromJson(json['end']),
    );
  }
}
