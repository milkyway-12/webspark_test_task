import '../../data/models/solution.dart';
import '../../data/models/task.dart';
import '../services/path_finder_service.dart';

class FindShortestPathUseCase {
  final PathFinderService pathFinderService;

  FindShortestPathUseCase(this.pathFinderService);

  Solution execute(Task task) => pathFinderService.findShortestPath(task: task);
}
