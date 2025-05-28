import 'package:flutter/material.dart';

class Gamespage extends StatelessWidget {
  final int totalLevels = 10;
  final int unlockedLevels = 5;

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
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: Image.asset(
                'assets/images/childSide/gamesMap.png',
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) {
                  return Center(child: Text('Image not found!'));
                },
              ),
            ),

            // Invisible level buttons
            ...List.generate(levelPositions.length, (index) {
              final isUnlocked = index < unlockedLevels;
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
