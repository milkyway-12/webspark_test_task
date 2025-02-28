class GamePoint {
  final int x;
  final int y;

  GamePoint({required this.x, required this.y});

  factory GamePoint.fromJson(Map<String, dynamic> json) {
    return GamePoint(
      x: json['x'] as int,
      y: json['y'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
    'x': x,
    'y': y,
  };
}
