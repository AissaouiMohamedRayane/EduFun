import '../models/games.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

const String url = 'http://192.168.202.183:8000';

Future<Game?> getGameById(String? token, int id) async {
  if (token == null) {
    return null;
  }
  try {
    final response = await http.get(
      Uri.parse('$url/games/level/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'token $token'
      },
    );

    if (response.statusCode == 200) {
      // The login was successful
      final Map<String, dynamic> responseData =
          json.decode(utf8.decode(response.bodyBytes));

      // Save the token for future API requests (e.g., using shared_preferences)
      return Game.fromJson(responseData);
    } else {
      // The login failed
      print('fetching user failed with status: ${response.statusCode}');
      print('Error: ${response.body}');
      return null;
    }
  } catch (e) {
    print('An error occurred: $e');
    return null;
  }
}
