import 'package:flutter/material.dart';
import '../sharedPreferences/prefsAuth.dart';
import '../API/store.dart';

class Product {
  final int id;
  final String name;
  final int price;
  final String imageUrl;
  final String type;
  String descreption;

  Product(
      {required this.id,
      required this.name,
      required this.price,
      required this.imageUrl,
      required this.type,
      this.descreption = ''});

  // Factory constructor to create a Product from a JSON map
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      imageUrl: json['image_url'],
      type: json['type'],
      descreption: json['descreption'],
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'name': name,
  //     'price': price,
  //     'image_url': imageUrl,
  //     'type': type,
  //   };
  // }
}

class StoreProvider with ChangeNotifier {
  List<Product> products = [];
  bool _isLoading = true;

  bool get isLoading => _isLoading;

  Future<void> initializeProducts() async {
    final String? token = await getToken();
    final List<Product> u = await getProducts(token);
    products = u;
    _isLoading = false;
    notifyListeners();
  }
}
