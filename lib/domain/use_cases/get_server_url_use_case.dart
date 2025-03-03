import '../../data/data_sources/local/preferences_helper.dart';

class GetServerUrlUseCase {
  final PreferencesHelper preferencesHelper;

  GetServerUrlUseCase(this.preferencesHelper);

  String? execute() {
    return preferencesHelper.getServerUrl();
  }
}
