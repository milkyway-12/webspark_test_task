import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  static final PreferencesHelper _instance = PreferencesHelper._internal();
  SharedPreferences? _preferencesHelper;

  PreferencesHelper._internal();

  static PreferencesHelper get instance => _instance;

  Future<void> init() async {
    _preferencesHelper = await SharedPreferences.getInstance();
  }

  static const String keyServerUrl = 'server_url';

  Future<void> saveServerUrl(String url) async {
    if (_preferencesHelper?.containsKey(keyServerUrl) == true) {
      await _preferencesHelper?.remove(keyServerUrl);
    }
    await _preferencesHelper?.setString(keyServerUrl, url);
  }

  String? getServerUrl() {
    return _preferencesHelper?.getString(keyServerUrl);
  }
}