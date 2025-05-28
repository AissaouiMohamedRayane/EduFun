import 'package:flutter/material.dart';

class CollaborativeLearning extends StatelessWidget {
  const CollaborativeLearning({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildActivityCard(
            title: "Maths Final Quizz",
            progress: 0.7,
            reward: "20 hints package",
            status: "Progress",
          ),
          const SizedBox(height: 16),
          _buildActivityCard(
            title: "Islamics test",
            progress: 0.0,
            reward: "plane to unram",
            status: "Execution",
          ),
          const SizedBox(height: 16),
          _buildActivityCard(
            title: "Geography test",
            progress: 0.0,
            reward: "trip to United States",
            status: "Execution",
          ),
          const SizedBox(height: 32),
          Center(
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text("Create New Competition"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildActivityCard({
  required String title,
  required double progress,
  required String reward,
  required String status,
}) {
  return Card(
    elevation: 3,
    color: const Color(0xFFA6BCD3), // Changed to #A6BCD3
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white, // Added white text for better contrast
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                status,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                ), // Changed to white
              ),
              const Spacer(),
              Text(
                "${(progress * 100).toStringAsFixed(0)}%",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Changed to white
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[200],
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF2086CB)),
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(
                Icons.card_giftcard,
                size: 20,
                color: Colors.white,
              ), // Changed to white
              const SizedBox(width: 8),
              Text(
                "Reward: $reward",
                style: TextStyle(color: Colors.white), // Changed to white
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
