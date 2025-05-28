import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/users.dart';
import '../sharedPreferences/prefsAuth.dart';

const String url = 'http://192.168.202.183:8000';

Future<List<Child>> getChildren(String? token) async {
  if (token == null) {
    return [];
  }
  try {
    final response = await http.get(
      Uri.parse('$url/users/getchildren/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'token $token'
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData =
          json.decode(utf8.decode(response.bodyBytes));

      // Map each JSON object to a Child instance
      print(responseData);
      return responseData
          .map((childJson) => Child.fromJson(childJson))
          .toList();
    } else {
      // The login failed
      print('fetching user failed with status: ${response.statusCode}');
      print('Error: ${response.body}');
      return [];
    }
  } catch (e) {
    print('An error occurred: $e');
    return [];
  }
}

Future<int?> registerChild(String token, Map<String, dynamic> child) async {
  try {
    final response = await http.post(
      Uri.parse('$url/users/addchild/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'token $token'
      },
      body: json.encode({
        'username': child['username'],
        'first_name': child['firstName'],
        'last_name': child['lastName'],
        'avatar': 2,
        'dob': child['dob'],
        'gender': true,
      }),
    );

    if (response.statusCode == 201) {
      // The login was successful
      final Map<String, dynamic> responseData = json.decode(response.body);


      // Save the token for future API requests (e.g., using shared_preferences)
      return responseData['id'];
    } else {
      // The login failed
      print('Login failed with status: ${response.statusCode}');
      print('Error: ${response.body}');
      return null;
    }
  } catch (e) {
    print('An error occurred: $e');
    return null;
  }
}
