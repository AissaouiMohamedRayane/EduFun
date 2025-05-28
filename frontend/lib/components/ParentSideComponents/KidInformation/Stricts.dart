import 'package:flutter/material.dart';

class Strict extends StatelessWidget {
  const Strict({super.key});

  @override
  Widget build(BuildContext context) {
    return const LearningStreakCard();
  }
}

class LearningStreakCard extends StatelessWidget {
  const LearningStreakCard({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data for the streak
    const int goalDaysPerWeek = 5;
    const int achievedDays = 4;
    final List<bool> completedDays = [
      true,
      true,
      true,
      false,
      true,
      false,
      false,
    ];

    return Column(
      children: [
        Row(
          children: [
            const Text(
              'Learning Streaks',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A73E8),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Container(
          width: double.infinity, // Ensure the container takes full width
          decoration: BoxDecoration(
            color: Color.fromRGBO(166, 188, 211, 1),
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize:
                MainAxisSize.min, // Important to prevent infinite height
            children: [
              const SizedBox(height: 8),
              const Text(
                'Maintain consistent study days',
                style: TextStyle(fontSize: 14, color: Color(0xFF5F6368)),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Goal: $goalDaysPerWeek days/week',
                    style: TextStyle(fontSize: 14, color: Color(0xFF5F6368)),
                  ),
                  Text(
                    'Achieved: $achievedDays/$goalDaysPerWeek days',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF5F6368),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              WeeklyCalendar(completedDays: completedDays),
              const SizedBox(height: 16),
              const Text(
                'Needs 1 more day to complete weekly streak',
                style: TextStyle(fontSize: 14, color: Color(0xFF5F6368)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class WeeklyCalendar extends StatelessWidget {
  final List<bool> completedDays;

  const WeeklyCalendar({super.key, required this.completedDays});

  @override
  Widget build(BuildContext context) {
    final List<String> weekdays = [
      'Sun',
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
    ];

    return SizedBox(
      height: 70, // Fixed height
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          7,
          (index) => DayIndicator(
            day: weekdays[index],
            isCompleted: completedDays[index],
          ),
        ),
      ),
    );
  }
}

class DayIndicator extends StatelessWidget {
  final String day;
  final bool isCompleted;

  const DayIndicator({super.key, required this.day, required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // Important to prevent infinite height
      children: [
        Text(
          day,
          style: const TextStyle(fontSize: 14, color: Color(0xFF5F6368)),
        ),
        const SizedBox(height: 8),
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: isCompleted ? const Color(0xFF1A73E8) : Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFDFE1E5), width: 1),
          ),
          child:
              isCompleted
                  ? const Icon(Icons.check, color: Colors.white, size: 20)
                  : null,
        ),
      ],
    );
  }
}
