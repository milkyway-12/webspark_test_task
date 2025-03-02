class GamePoint {
  final int x;
  final int y;
  final bool? isAvailable;

  GamePoint({required this.x, required this.y, this.isAvailable});

  factory GamePoint.fromJson(Map<String, dynamic> json) {
    return GamePoint(
      x: json['x'] as int,
      y: json['y'] as int,
      isAvailable: false,
    );
  }

  Map<String, dynamic> toJson() => {
    'x': x,
    'y': y,
  };
}
