import 'package:flutter/cupertino.dart';

import '../../data/models/game_point.dart';
import 'direction.dart';

class PathFinderService {

  List<List<GamePoint>> getPointMatrix (List<String> data) {
    List<List<GamePoint>> matrix = [];

    for (int y = 0; y < data.length; y++) {
      List<GamePoint> row = [];
      String rowData = data[y];

      for (int x = 0; x < rowData.length; x++) {
        String value = rowData[x];
        row.add(GamePoint(x: x, y: y));
      }
      matrix.add(row);
    }

    debugPrint('Got matrix: $matrix');
    return matrix;
  }


  List<GamePoint> getBlockedPoints(List<String> data) {
    List<GamePoint> blockedPoints = [];

    for (int y = 0; y < data.length; y++) {
      String rowData = data[y];

      for (int x = 0; x < rowData.length; x++) {
        if (rowData[x] == 'X') {
          blockedPoints.add(GamePoint(x: x, y: y));
        }
      }
    }

    return blockedPoints;
  }


  List<GamePoint> findShortestPath({
    required List<String> stringField,
    required GamePoint start,
    required GamePoint end
  }) {
    List<List<GamePoint>> matrix = getPointMatrix(stringField);
    List<GamePoint> blockedPoints = getBlockedPoints(stringField);

    List<GamePoint> shortestPath = [start];

    bool isEndLeft (GamePoint initialPoint) {
      if (initialPoint.x < end.x) {
        return true;
      } else {
        return false;
      }
    }

    bool isEndRight (GamePoint initialPoint) {
      if (initialPoint.x > end.x) {
        return true;
      } else {
        return false;
      }
    }

    bool isEndTop (GamePoint initialPoint) {
      if (initialPoint.y < end.y) {
        return true;
      } else {
        return false;
      }
    }

    bool isEndBottom (GamePoint initialPoint) {
        if (initialPoint.y > end.y) {
          return true;
        } else {
          return false;
        }
    }

    GamePoint move (GamePoint initialPoint, Direction direction) {
      GamePoint newPathPoint = GamePoint(
        x: initialPoint.x + direction.dx,
        y: initialPoint.y + direction.dy,
      );
      debugPrint('Moving to (${newPathPoint.x}, ${newPathPoint.y})');
      return newPathPoint;
    }

    bool isPathDiagonal (GamePoint initialPoint) {
      int dx = (initialPoint.x - end.x).abs();
      int dy = (initialPoint.y - end.y).abs();

      if (dx == dy) {
        return true;
      }
      else {
        return false;
      }

    }

    bool isPathStraight (GamePoint initialPoint) {

      if (initialPoint.x == end.x) {
        for (var blockedPoint in blockedPoints) {
          if(initialPoint.x == blockedPoint.x && )
        }



      }
    }


    bool isEndANeighbour (GamePoint initialPoint) {
      int dx = (initialPoint.x - end.x).abs();
      int dy = (initialPoint.y - end.y).abs();

      if ((dx == 1 && dy == 0) ||
          (dx == 0 && dy == 1) ||
          (dx == 1 && dy == 1)) {
        shortestPath.add(end);
        return true;
      }
      return false;
    }

    bool isNeibourBlocked() {
      if()

    };

    void fillStraightPath(GamePoint initialPoint) {


    };

    void fillDiagonalPath(GamePoint initialPoint) {

    };

    return [start, /* j */ end];
  }
}