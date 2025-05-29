import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/users.dart';

const String url = 'http://192.168.202.183:8000';

Future<Parent?> getParent(String? token) async {
  if (token == null) {
    return null;
  }
  try {
    final response = await http.get(
      Uri.parse('$url/users/parent/'),
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
      return Parent.fromJson(responseData);
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

Future<bool> UpdateParent(String? token, String username, String email) async {
  if (token == null) {
    return false;
  }

  try {
    final response = await http.put(
      Uri.parse('$url/users/editParent/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $token', // Note the 'Token' prefix
      },
      body: jsonEncode({'username': username, 'email': email}),
    );

    if (response.statusCode == 200) {
      // Check for '200 OK'
      // Customer update was successful
      print('Customer updated successfully');
      return true;
      // Parse the response body to get the updated customer's ID
    } else {
      // Log detailed error information
      print('Customer update failed with status: ${response.statusCode}');
      print('Error: ${response.body}');
      return false; // Return null to indicate an error occurred
    }
  } catch (e) {
    print('An error occurred: $e');
    return false; // Return null to indicate an error occurred
  }
}
