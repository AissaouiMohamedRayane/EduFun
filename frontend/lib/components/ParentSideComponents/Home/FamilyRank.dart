import 'package:flutter/material.dart';
import 'package:EduFun/components/ParentSideComponents/Home/Ranking.dart';

class FamilyRank extends StatefulWidget {
  const FamilyRank({super.key});

  @override
  State<FamilyRank> createState() => _FamilyRankState();
}

class _FamilyRankState extends State<FamilyRank> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Strength by Subject",
              style: TextStyle(
                color: Color(0xFF2086CB),
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          width: 315,

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: const Color.fromARGB(255, 192, 194, 212),
          ),
        ),
        Ranking(),
        SizedBox(height: 10),
      ],
    );
  }
}
