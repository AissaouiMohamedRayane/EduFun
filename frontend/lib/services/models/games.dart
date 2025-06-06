import 'package:flutter/material.dart';

class Question {
  final int id;
  final String text;
  final int difficulty;
  final String category;
  final List<String> choices;
  final String answer;
  final String hint;

  Question({
    required this.id,
    required this.text,
    required this.difficulty,
    required this.category,
    required this.choices,
    required this.answer,
    required this.hint,
  });

  // Factory constructor to create a Question from a JSON map
  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      text: json['text'].toString(),
      difficulty: json['difficulty'],
      category: json['category'].toString(),
      choices: List<String>.from(json['choices'].map((e) => e.toString())),
      answer: json['answer'].toString(),
      hint: json['hint'].toString(),
    );
  }

  // Optional: Convert a Question object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'difficulty': difficulty,
      'category': category,
      'choices': choices,
      'answer': answer,
      'hint': hint,
    };
  }
}

class Game {
  final int level;
  final Question math;
  final Question science;
  final Question geography;
  final Question history;
  final Question islamic;
  final int requiredScore;

  Game({
    required this.level,
    required this.math,
    required this.science,
    required this.geography,
    required this.history,
    required this.islamic,
    this.requiredScore = 1,
  });
  Question getByCategory(String category) {
    switch (category) {
      case 'math':
        return math;
      case 'science':
        return science;
      case 'history':
        return history;
      case 'islamic':
        return islamic;
      case 'geography':
        return geography;
      default:
        throw Exception('Invalid category: $category');
    }
  }

  // Factory constructor to create a Game from a JSON map
  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      level: json['level'],
      math: Question.fromJson(json['math_question']),
      science: Question.fromJson(json['science_question']),
      geography: Question.fromJson(json['geography_question']),
      history: Question.fromJson(json['history_question']),
      islamic: Question.fromJson(json['islamic_question']),
      requiredScore: json['required_score'] ?? 1,
    );
  }

  // Convert a Game object to JSON
  Map<String, dynamic> toJson() {
    return {
      'level': level,
      'math_question': math.toJson(),
      'science_question': science.toJson(),
      'geography_question': geography.toJson(),
      'history_question': history.toJson(),
      'islamic_question': islamic.toJson(),
      'required_score': requiredScore,
    };
  }
}
