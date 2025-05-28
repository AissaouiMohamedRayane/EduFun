import 'package:shared_preferences/shared_preferences.dart';

Future<void> storeToken(String token, bool isParent) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('authToken', token);
  await prefs.setBool('isParent', isParent);
}

Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('authToken');
}

Future<bool?> isParent() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isParent');
}

Future<void> removeToken() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('authToken');
  await prefs.remove('isParent');
}
