import '../../data/data_sources/remote/api_client.dart';
import '../../data/models/solution.dart';

class SendResultsUseCase {
  final ApiClient apiClient;

  SendResultsUseCase(this.apiClient);

  Future<void> execute(List<Solution> solutions) async {
    final payload = solutions.map((s) => s.toJson()).toList();

    await apiClient.sendSolutionsList(
      payload,
    );
  }
}
