import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  static late SharedPreferences prefs;

  ///token
  static set token(String token) => prefs.setString("token", token);
  static String get token => prefs.getString("token") ?? '';

  ///deviceToken
  static set deviceToken(String deviceToken) =>
      prefs.setString("deviceToken", deviceToken);
  static String get deviceToken => prefs.getString("deviceToken") ?? '';

  ///First name
  static set firstName(String firstName) =>
      prefs.setString("firstName", firstName);
  static String get firstName => prefs.getString("firstName") ?? '';

  ///last name
  static set lastName(String lastName) => prefs.setString("lastName", lastName);
  static String get lastName => prefs.getString("lastName") ?? '';

  ///userId
  static set userId(String userId) => prefs.setString("userId", userId);
  static String get userId => prefs.getString("userId") ?? '';

  ///Last ticket id created
  static set ticketId(String ticketId) => prefs.setString("ticketId", ticketId);
  static String get ticketId => prefs.getString("ticketId") ?? '';

  ///Last ticket ref created
  static set ticketRef(String ticketRef) =>
      prefs.setString("ticketRef", ticketRef);
  static String get ticketRef => prefs.getString("ticketRef") ?? '';

  ///Last ticket title created
  static set ticketTitle(String ticketTitle) =>
      prefs.setString("ticketTitle", ticketTitle);
  static String get ticketTitle => prefs.getString("ticketTitle") ?? '';

  //Email
  static set email(String email) => prefs.setString("email", email);
  static String get email => prefs.getString("email") ?? '';

  /// password
  static set password(String password) => prefs.setString("password", password);
  static String get password => prefs.getString("password") ?? '';

  /// is first launch
  static set isFirstLaunch(bool isFirstLaunch) =>
      prefs.setBool("isFirstLaunch", isFirstLaunch);
  static bool get isFirstLaunch => prefs.getBool("isFirstLaunch") ?? true;

  /// is logged in
  static set isloggedIn(bool isloggedIn) =>
      prefs.setBool("isloggedIn", isloggedIn);
  static bool get isloggedIn => prefs.getBool("isloggedIn") ?? false;

  static void clear() {
    // prefs.clear();
    PreferenceManager.isFirstLaunch = false;
    PreferenceManager.token = "";
    PreferenceManager.isloggedIn = false;
    PreferenceManager.email = '';
    PreferenceManager.password = '';
    PreferenceManager.userId = '';
    PreferenceManager.firstName = '';
  }

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }
}
