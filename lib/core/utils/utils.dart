import 'dart:ui';
import '../../data/models/game_point.dart';

Color hexToColor(String hex) {
  hex = hex.replaceAll("#", "");
  return Color(int.parse("0xFF$hex"));
}

String formatPointsPathToString(List<GamePoint> path) {
  return path.map((point) => "(${point.y},${point.x})").join("->");
}