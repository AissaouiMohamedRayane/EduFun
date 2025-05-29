import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/store.dart';

const String url = 'http://192.168.202.183:8000';

Future<List<Product>> getProducts(String? token) async {
  if (token == null) {
    return [];
  }
  try {
    final response = await http.get(
      Uri.parse('$url/store/powerups/'),
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
          .map((childJson) => Product.fromJson(childJson))
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
