import 'package:flutter/cupertino.dart';
import 'package:webspark_test_task/core/utils/utils.dart';
import '../../data/models/game_point.dart';
import '../../data/models/solution.dart';
import '../../data/models/task.dart';
import 'direction.dart';

class PathFinderService {

  List<List<GamePoint>> getPointMatrix(List<String> field) {
    List<List<GamePoint>> matrix = [];

    for (int x = 0; x < field.length; x++) {
      List<GamePoint> row = [];
      String rowData = field[x];

      for (int y = 0; y < rowData.length; y++) {
        String value = rowData[y];
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


  List<Direction> getDirectionPriorities (Direction neededDirection) {
    
    Map<Direction, List<Direction>> directionPriorities = {
      Direction.left: [Direction.left, Direction.topLeft, Direction.bottomLeft],
      Direction.right: [Direction.right, Direction.topRight, Direction.bottomRight],
      Direction.top: [Direction.top, Direction.topLeft, Direction.topRight],
      Direction.bottom: [Direction.bottom, Direction.bottomLeft, Direction.bottomRight],
      Direction.topLeft: [Direction.topLeft, Direction.top, Direction.left],
      Direction.topRight: [Direction.topRight, Direction.top, Direction.right],
      Direction.bottomLeft: [Direction.bottomLeft, Direction.bottom, Direction.left],
      Direction.bottomRight: [Direction.bottomRight, Direction.bottom, Direction.right],
    };

    return directionPriorities[neededDirection] ?? [];
  }
  
  
  Solution findShortestPath({
    required Task task
  }) {
    final List<List<GamePoint>> matrix = getPointMatrix(task.field);
    final GamePoint start = task.start;
    final GamePoint end = task.end;

    List<GamePoint> blockedPoints = getBlockedPoints(matrix);
    List<GamePoint> shortestPath = [start];

    int maxX = matrix[0].length;
    int maxY = matrix.length;

    bool isEndLeft(GamePoint initialPoint) {
      if (initialPoint.x > end.x) {
        return true;
      } else {
        return false;
      }
    }

    bool isEndRight(GamePoint initialPoint) {
      if (initialPoint.x < end.x) {
        return true;
      } else {
        return false;
      }
    }

    bool isEndTop(GamePoint initialPoint) {
      if (initialPoint.y > end.y) {
        return true;
      } else {
        return false;
      }
    }

    bool isEndBottom(GamePoint initialPoint) {
      if (initialPoint.y < end.y) {
        return true;
      } else {
        return false;
      }
    }
    
    
    Direction setVectorPriority(
        Direction neededDirection,
        List<Direction> availableDirections) {

      List<Direction> endPointPriorities = getDirectionPriorities(neededDirection);

      Direction result = availableDirections.firstWhere(
            (direction) => endPointPriorities.contains(direction),
        orElse: () => availableDirections[0],
      );

      return result;
    }


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

        bool isInsideMatrix(GamePoint point) {
          return point.x >= 0 && point.x < maxX && point.y >= 0 && point.y < maxY;
        }

        List<Direction> toCheck = getDirectionPriorities(neededDirection);

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

    Direction navigateAround(GamePoint initialPoint) {

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
    
    
    void movingByShortestPath() {

      int maxIterations = maxX * maxY;
      int iterations = 0;

      List<Direction> availableDirections = [];

      List<Direction> blockedDirectionsForPoint = [];

      while (!isEndANeighbour(shortestPath.last) && iterations < maxIterations) {
        iterations++;
        GamePoint currentPoint = shortestPath.last;

        Direction neededDirection = getNextMoveDirection(currentPoint);
        
        var allDirections = getAvailableDirections(
            currentPoint,
                neededDirection);
        
        availableDirections = allDirections.
        toSet().
        difference(blockedDirectionsForPoint.toSet()).toList();
        
        void move(GamePoint initialPoint, Direction direction) {
          int newX = initialPoint.x + direction.dx;
          int newY = initialPoint.y + direction.dy;
          
          bool pointAlreadyVisited = shortestPath.any((p) => p.x == newX && p.y == newY);

          if (!pointAlreadyVisited) {
            GamePoint newPathPoint = GamePoint(
              x: newX,
              y: newY,
            );
            shortestPath.add(newPathPoint);
            debugPrint('Moving to ($newX, $newY)');
            blockedDirectionsForPoint = [];
          } else {
            blockedDirectionsForPoint.add(direction);
            debugPrint('Not moving to ($newX, $newY) - already visited');
          }
        }

          switch (availableDirections.length) {
            case 3:
              move(currentPoint, neededDirection);
              break;
            case 2:
            case 1:
              move(currentPoint, setVectorPriority(neededDirection, availableDirections));
              break;
            default:
              move(currentPoint, navigateAround(currentPoint));
              break;
          }
      }
    }

    movingByShortestPath();
    debugPrint('Found path is ${formatPointsPathToString(shortestPath)}');


    return Solution(
        id: task.id,
        steps: shortestPath,
        path: formatPointsPathToString(shortestPath),
        matrix: matrix,
        blockedPoints: blockedPoints);
  }
}