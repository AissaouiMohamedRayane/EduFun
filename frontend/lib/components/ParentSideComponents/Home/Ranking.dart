import 'package:flutter/material.dart';

class Ranking extends StatelessWidget {
  final List<Subject> subjects = [
    Subject(name: 'Maths', percentage: 80),
    Subject(name: 'Sciences', percentage: 40),
    Subject(name: 'Geography', percentage: 65),
    Subject(name: 'History', percentage: 50),
  ];

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 340, minWidth: 340),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 192, 194, 212),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...subjects.map((subject) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subject.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4),
                    Stack(
                      children: [
                        Container(
                          height: 20,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[200],
                          ),
                        ),
                        Container(
                          height: 20,
                          width: (subject.percentage / 100) * (340 - 40),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: _getColorForPercentage(subject.percentage),
                          ),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Text(
                                '${subject.percentage}%',
                                style: TextStyle(
                                  color:
                                      subject.percentage > 50
                                          ? Colors.white
                                          : Colors.grey[800],
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Color _getColorForPercentage(int percentage) {
    if (percentage >= 70) return Colors.blue[700]!;
    if (percentage >= 50) return Colors.blue[500]!;
    if (percentage >= 30) return Colors.blue[300]!;
    return Colors.blue[100]!;
  }
}

class Subject {
  final String name;
  final int percentage;

  Subject({required this.name, required this.percentage});
}
