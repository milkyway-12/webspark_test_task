import '../../data/data_sources/local/preferences_helper.dart';

class SaveServerUrlUseCase {
  final PreferencesHelper preferencesHelper;

  SaveServerUrlUseCase(this.preferencesHelper);

  Future<void> execute(String url) async {
    await preferencesHelper.saveServerUrl(url);
  }
}
