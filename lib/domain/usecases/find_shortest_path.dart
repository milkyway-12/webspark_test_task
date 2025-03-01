import '../../data/models/game_point.dart';
import '../services/path_finder_service.dart';

class FindShortestPath {
  final PathFinderService pathFinderService;

  FindShortestPath(this.pathFinderService);

  List<GamePoint> execute({
    required List<String> matrix,
    required GamePoint start,
    required GamePoint end
  }) {
    return pathFinderService.findShortestPath(
        stringField: matrix,
        start: start,
        end: end
    );
  }
}