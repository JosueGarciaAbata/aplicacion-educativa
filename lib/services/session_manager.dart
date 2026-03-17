import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const _usernameKey = 'username';

  static Future<void> saveUsername(String username) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_usernameKey, username);
  }

  static Future<String?> getUsername() async {
    final preferences = await SharedPreferences.getInstance();
    final username = preferences.getString(_usernameKey);

    if (username == null || username.trim().isEmpty) {
      return null;
    }

    return username;
  }

  static Future<void> clearSession() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.remove(_usernameKey);
  }
}
