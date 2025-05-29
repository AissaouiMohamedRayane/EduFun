import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/models/users.dart';

class Gamespage extends StatefulWidget {
  @override
  State<Gamespage> createState() => _GamespageState();
}

class _GamespageState extends State<Gamespage> {
  final int totalLevels = 10;

  final List<Offset> levelPositions = const [
    Offset(170, 70),
    Offset(63, 161),
    Offset(253, 220),
    Offset(105, 252),
    Offset(10, 303),
    Offset(162, 301),
    Offset(258, 372),
    Offset(140, 445),
    Offset(19, 527),
    Offset(165, 625),
  ];

  @override
  Widget build(BuildContext context) {
    final childProvider = Provider.of<ChildProvider>(context);

    return childProvider.isLoading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            body: SafeArea(
              child: Stack(
                children: [
                  // Background image
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/childSide/gamesMap.png',
                      fit: BoxFit.fill,
                    ),
                  ),

                  // Invisible level buttons
                  ...List.generate(levelPositions.length, (index) {
                    final isUnlocked = index < childProvider.child!.level!;
                    final position = levelPositions[index];

                    return Positioned(
                      left: position.dx,
                      top: position.dy,
                      child: GestureDetector(
                        onTap: isUnlocked
                            ? () {
                                print("Tapped Level ${index + 1}");
                              }
                            : null,
                        child: Container(
                          width: 80,
                          height: 80,
                          // Fully invisible but still clickable
                          color: Colors.transparent,
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          );
  }
}
