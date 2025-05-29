import 'package:flutter/material.dart';

import '../API/parent.dart';
import '../API/child.dart';
import '../API/auth.dart';

import '../sharedPreferences/prefsAuth.dart';

class Parent {
  final int id;
  String username;
  String email;
  int avatar;
  bool gender;
  final String familyCode;

  Parent(
      {required this.username,
      required this.id,
      required this.email,
      required this.avatar,
      required this.gender,
      required this.familyCode});

  // Factory constructor to create a Parent from a JSON map
  factory Parent.fromJson(Map<String, dynamic> json) {
    return Parent(
        id: json['id'],
        username: json['username'],
        email: json['email'],
        avatar: json['avatar'],
        gender: json['gender'],
        familyCode: json['family_code']);
  }

  // Method to convert a Parent object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'id': id,
      'email': email,
      'avatar': avatar,
      'gender': gender,
      'family_code': familyCode
    };
  }
}

class Child {
  final int id;
  final String username;
  final String firstname;
  final String lastname;
  final int points;
  final int hintsNumber;
  final int? level;
  final int avatar;
  final int fiftyAvailable;

  Child({
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.id,
    required this.points,
    required this.hintsNumber,
    required this.avatar,
    required this.level,
    required this.fiftyAvailable,
  });

  factory Child.fromJson(Map<String, dynamic> json) {
    return Child(
      id: json['id'],
      username: json['username'],
      firstname: json['first_name'],
      lastname: json['last_name'],
      avatar: json['avatar'],
      points: json['points'],
      level: json['level'],
      hintsNumber: json['hints_available'],
      fiftyAvailable: json['fifty_fifty_available'],
    );
  }

  // Method to convert a Parent object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'id': id,
      'points': points,
      'level': level,
      'hints_available': hintsNumber,
      'fifty_fifty_available': fiftyAvailable,
    };
  }
}

class ParentProvider with ChangeNotifier {
  Parent? parent;
  List<Child> children = [];
  bool _isLoading = true;

  bool get isLoading => _isLoading;

  Future<void> initializeParent() async {
    _isLoading = true;

    String? token = await getToken();
    final u = await getParent(token);
    final c = await getChildren(token);
    parent = u;
    children = c;
    print(c);
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> addChild(Map<String, dynamic> child) async {
    String? token = await getToken();

    int? success = await registerChild(token!, child);
    if (success != null) {
      Child c = Child(
          username: child['username'],
          firstname: child['firstName'],
          lastname: child['lastName'],
          id: success,
          avatar: 2,
          points: 90,
          hintsNumber: 3,
          level: 1,
          fiftyAvailable: 2);
      children.add(c);
      notifyListeners();
      return true;
    }
    notifyListeners();
    return false;
  }

  Future<bool> editParent(String username, String email) async {
    final token = await getToken();
    final bool ress = await UpdateParent(token, username, email);
    if (ress) {
      parent!.username = username;
      parent!.email = email;
    }
    notifyListeners();
    return ress;
  }

  Future<void> logoutParent() async {
    final token = await getToken();
    await logout(token);
    await removeToken();

    _isLoading = true;
    parent = null;
    children = [];
    notifyListeners();
  }
}

class ChildProvider with ChangeNotifier {
  Child? child;
  bool _isLoading = true;

  bool get isLoading => _isLoading;

  Future<void> initializeChild() async {
    _isLoading = true;

    String? token = await getToken();
    child = await getChild(token);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> logoutChild() async {
    final token = await getToken();
    await logout(token);
    await removeToken();

    _isLoading = true;
    child = null;
    notifyListeners();
  }
}
