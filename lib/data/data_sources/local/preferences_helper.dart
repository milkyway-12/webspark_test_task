import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {

  static const String keyServerUrl = 'server_url';

  Future<bool> saveServerUrl(String url) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(keyServerUrl, url);
  }

  Future<String?> getServerUrl() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyServerUrl);
  }
}