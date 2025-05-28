import 'package:flutter/material.dart';

class PreferredSubjects extends StatelessWidget {
  final List<Map<String, dynamic>> subjects;

  const PreferredSubjects({super.key, required this.subjects});

  @override
  Widget build(BuildContext context) {
    // Sort subjects by achievement percentage (highest first)
    final sortedSubjects = List<Map<String, dynamic>>.from(subjects)
      ..sort((a, b) => (b['percentage'] ?? 0).compareTo(a['percentage'] ?? 0));

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'your kids prefer this subjects by order',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          Column(
            children:
                sortedSubjects.asMap().entries.map((entry) {
                  final index = entry.key;
                  final subject = entry.value;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '#${index + 1}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: _getRankColor(index),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          subject['name'] ?? 'Subject',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '${subject['percentage']?.toStringAsFixed(0) ?? '0'}%',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }

  Color _getRankColor(int index) {
    switch (index) {
      case 0:
        return Colors.amber[800]!; // Gold for 1st
      case 1:
        return Colors.grey[600]!; // Silver for 2nd
      case 2:
        return Colors.brown[600]!; // Bronze for 3rd
      default:
        return Colors.grey[500]!; // Default for others
    }
  }
}
