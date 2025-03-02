import 'package:flutter/cupertino.dart';

import '../../data/models/game_point.dart';
import 'direction.dart';

class PathFinderService {

  List<List<GamePoint>> getPointMatrix(List<String> data) {
    List<List<GamePoint>> matrix = [];

    for (int y = 0; y < data.length; y++) {
      List<GamePoint> row = [];
      String rowData = data[y];

      for (int x = 0; x < rowData.length; x++) {
        String value = rowData[x];
        bool isAvailable = value == '.';

        row.add(GamePoint(x: x, y: y, isAvailable: isAvailable));
      }
      matrix.add(row);
    }

    debugPrint('Got matrix: $matrix');
    return matrix;
  }


  List<GamePoint> getBlockedPoints(List<List<GamePoint>> matrix) {
    List<GamePoint> blockedPoints = [];

    for (var row in matrix) {
      for (var point in row) {
        if (point.isAvailable == false) {
          blockedPoints.add(point);
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
    List<GamePoint> blockedPoints = getBlockedPoints(matrix);

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

    bool isDiagonalPathClear (GamePoint initialPoint) {
      int dx = (initialPoint.x - end.x).abs();
      int dy = (initialPoint.y - end.y).abs();

      if (dx != dy) {
        return false;
      }

      int stepX = initialPoint.x < end.x ? 1 : -1;
      int stepY = initialPoint.y < end.y ? 1 : -1;

      int x = initialPoint.x + stepX;
      int y = initialPoint.y + stepY;

      while (x != end.x && y != end.y) {
        if (blockedPoints.any((p) => p.x == x && p.y == y)) {
          return false;
        }
        x += stepX;
        y += stepY;
      }

      return true;
    }


    bool isStraightPathClear (GamePoint initialPoint) {

      if (initialPoint.x == end.x) {
        int minY = initialPoint.y < end.y ? initialPoint.y : end.y;
        int maxY = initialPoint.y > end.y ? initialPoint.y : end.y;

        for (int y = minY + 1; y < maxY; y++) {
          if (blockedPoints.any((p) => p.x == initialPoint.x && p.y == y)) {
            return false;
          }
        }
        return true;
      }

      if (initialPoint.y == end.y) {
        int minX = initialPoint.x < end.x ? initialPoint.x : end.x;
        int maxX = initialPoint.x > end.x ? initialPoint.x : end.x;

        for (int x = minX + 1; x < maxX; x++) {
          if (blockedPoints.any((p) => p.y == initialPoint.y && p.x == x)) {
            return false;
          }
        }
        return true;
      }

      return false;
    }

  // List<Direction> setVectorPriority (List<Direction> availableDirections) {
  //
  //
  //
  //
  // }


    Direction getNextMoveDirection(GamePoint initialPoint) {
      if (isEndLeft(initialPoint)) {
        if (isEndTop(initialPoint)) {
          return Direction.topLeft;
        } else if (isEndBottom(initialPoint)) {
          return Direction.bottomLeft;
        } else {
          return Direction.left;
        }
      }

      if (isEndRight(initialPoint)) {
        if (isEndTop(initialPoint)) {
          return Direction.topRight;
        } else if (isEndBottom(initialPoint)) {
          return Direction.bottomRight;
        } else {
          return Direction.right;
        }
      }

      if (isEndBottom(initialPoint)) {
        return Direction.bottom;
      }

      return Direction.top;
    }


      List<Direction> getAvailableDirections(
          GamePoint initialPoint, Direction neededDirection) {
        List<Direction> availableDirections = [];

        int maxX = matrix[0].length;
        int maxY = matrix.length;

        bool isInsideMatrix(GamePoint point) {
          return point.x >= 0 && point.x < maxX && point.y >= 0 && point.y < maxY;
        }

        Map<Direction, List<Direction>> checkMap = {
          Direction.left: [Direction.left, Direction.topLeft, Direction.bottomLeft],
          Direction.right: [Direction.right, Direction.topRight, Direction.bottomRight],
          Direction.top: [Direction.top, Direction.topLeft, Direction.topRight],
          Direction.bottom: [Direction.bottom, Direction.bottomLeft, Direction.bottomRight],
          Direction.topLeft: [Direction.topLeft, Direction.top, Direction.left],
          Direction.topRight: [Direction.topRight, Direction.top, Direction.right],
          Direction.bottomLeft: [Direction.bottomLeft, Direction.bottom, Direction.left],
          Direction.bottomRight: [Direction.bottomRight, Direction.bottom, Direction.right],
        };

        List<Direction> toCheck = checkMap[neededDirection] ?? [];

        for (Direction direction in toCheck) {
          int newX = initialPoint.x + direction.dx;
          int newY = initialPoint.y + direction.dy;

          if (isInsideMatrix(GamePoint(x: newX, y: newY)) &&
              matrix[newY][newX].isAvailable == true) {
            availableDirections.add(direction);
          }
        }

        return availableDirections;
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


    Direction navigateAround(GamePoint initialPoint, GamePoint end, List<GamePoint> blockedPoints, int maxX, int maxY) {

      bool isVerticalBlock = blockedPoints.every((p) => p.x == initialPoint.x);
      bool isHorizontalBlock = blockedPoints.every((p) => p.y == initialPoint.y);

      if (isVerticalBlock) {

        int topBlocked = blockedPoints.where((p) => p.y < initialPoint.y).length;
        int bottomBlocked = blockedPoints.where((p) => p.y > initialPoint.y).length;

        bool canMoveDown = initialPoint.y + 1 <= maxY && !blockedPoints.any((p) => p.y == initialPoint.y + 1);
        bool canMoveUp = initialPoint.y - 1 >= 0 && !blockedPoints.any((p) => p.y == initialPoint.y - 1);

        if (topBlocked > bottomBlocked && canMoveDown) {
          return Direction.bottom;
        } else if (canMoveUp) {
          return Direction.top;
        }
      } else if (isHorizontalBlock) {

        int leftBlocked = blockedPoints.where((p) => p.x < initialPoint.x).length;
        int rightBlocked = blockedPoints.where((p) => p.x > initialPoint.x).length;

        bool canMoveRight = initialPoint.x + 1 <= maxX && !blockedPoints.any((p) => p.x == initialPoint.x + 1);
        bool canMoveLeft = initialPoint.x - 1 >= 0 && !blockedPoints.any((p) => p.x == initialPoint.x - 1);

        if (leftBlocked > rightBlocked && canMoveRight) {
          return Direction.right;
        } else if (canMoveLeft) {
          return Direction.left;
        }
      }

      if (initialPoint.y - 1 >= 0) return Direction.top;
      if (initialPoint.y + 1 <= maxY) return Direction.bottom;
      if (initialPoint.x - 1 >= 0) return Direction.left;
      if (initialPoint.x + 1 <= maxX) return Direction.right;

      throw Exception("Неможливо пройти");
    }


    void movingByShortestPath(){
      late Direction lastMoveDirection;
      GamePoint initialPoint = shortestPath[shortestPath.length-1];

      while(!isEndANeighbour(initialPoint)) {
        Direction neededDirection = getNextMoveDirection(initialPoint);
        List<Direction> availableDirections = getAvailableDirections(initialPoint, neededDirection);

        if (availableDirections.contains(neededDirection)) {
          shortestPath.add(move(initialPoint, neededDirection));
        }
        else if (availableDirections.length < 3){

        }

    }

    }

    // void fillStraightPath(GamePoint initialPoint) {
    //
    //
    // };
    //
    // void fillDiagonalPath(GamePoint initialPoint) {
    //
    // };

    return [start, /* j */ end];
  }
}

