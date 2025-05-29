import 'package:flutter/material.dart';
import 'package:EduFun/Netflixfirstpage/SelectKidScreen.dart';
import 'package:EduFun/components/ParentSideComponents/ActivitiesProgress.dart';
import 'package:EduFun/components/ParentSideComponents/Home/FamilyRank.dart';
import 'package:EduFun/components/ParentSideComponents/HeadingandDushboard.dart';
import 'package:EduFun/components/ParentSideComponents/KidInformation/Stricts.dart';
import 'package:EduFun/components/ParentSideComponents/Home/PreferredSubjects.dart';
import 'package:EduFun/components/ParentSideComponents/Home/ScreenTime.dart';
import 'package:EduFun/components/ParentSideComponents/ShowKidsDetails.dart';
import '../../../../services/models/users.dart';

class ParentSide extends StatefulWidget {
  final Child child;
  ParentSide({super.key, required this.child});

  @override
  State<ParentSide> createState() => _ParentSideState();
}

class _ParentSideState extends State<ParentSide> {
  int _selectedIndex = 0;
  int _selectedChildIndex = -1;

  final List<Map<String, int>> children = [
    {'gold': 40, 'silver': 40, 'bronze': 40},
    {'gold': 35, 'silver': 45, 'bronze': 30},
    {'gold': 30, 'silver': 35, 'bronze': 45},
    {'gold': 45, 'silver': 30, 'bronze': 35},
    {'gold': 45, 'silver': 30, 'bronze': 35},
  ];

  final List<String> subjectNames = [
    'Maths',
    'History',
    'Islamics',
    'Sciences',
    'Geography',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onChildSelected(int index) {
    setState(() {
      _selectedChildIndex = index;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${subjectNames[index]} selected'),
          duration: Duration(seconds: 1),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(223, 246, 242, 1),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(height: 20),
            const Heading(),
            const SizedBox(height: 20),
            KidInformation(
              name: widget.child.username,
              image: "assets/images/profileChildrenPictures/${widget.child.avatar}.png",
              fullName: "${widget.child.lastname} ${widget.child.firstname}",
            ),
            // General Overview
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "General Overview",
                  style: TextStyle(
                    color: Color(0xFF2086CB),
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Subject-based Child Details
            ...List.generate(children.length, (index) {
              return GestureDetector(
                onTap: () => _onChildSelected(index),
                child: ShowKidDetails(
                  number: index + 1,
                  name: subjectNames[index],
                  gold: children[index]['gold'] ?? 0,
                  silver: children[index]['silver'] ?? 0,
                  bronze: children[index]['bronze'] ?? 0,
                  isSelected: _selectedChildIndex == index,
                ),
              );
            }),
            const SizedBox(height: 30),
            Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Recent Activity / Achievement",
                        style: TextStyle(
                          color: Color(0xFF2086CB),
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(166, 188, 211, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        // Make The Widget Here
                        _buildAchievementItem(
                          'Silver medal in maths',
                          'assets/fonts/S.png',
                        ),
                        Divider(height: 1, color: Colors.grey[300]),
                        _buildAchievementItem(
                          'Bronze medal in geography',
                          'assets/fonts/B.png',
                        ),
                        Divider(height: 1, color: Colors.grey[300]),
                        _buildAchievementItem(
                          'Gold medal in sciences',
                          'assets/fonts/G.png',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            ScreenTime(),

            const SizedBox(height: 30),
            Strict(),

            const SizedBox(height: 30),
            FamilyRank(),
            const SizedBox(height: 30),
            ActivitiesProgress(
              completed: _selectedChildIndex >= 0
                  ? (children[_selectedChildIndex]['gold'] ?? 0)
                  : 100,
              total: 300,
            ),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Ranking Most Liked Subjects",
                style: TextStyle(
                  color: Color(0xFF2086CB),
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            PreferredSubjects(
              subjects: [
                {'name': 'maths', 'percentage': 92},
                {'name': 'history', 'percentage': 85},
                {'name': 'islamics', 'percentage': 78},
                {'name': 'sciences', 'percentage': 65},
                {'name': 'geography', 'percentage': 58},
              ],
            ),
            SizedBox(height: 30),

            Container(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Color.fromRGBO(71, 121, 173, 1),
                  width: 2,
                ),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/');
                },
                child: const Text(
                  "Go back to children",
                  style: TextStyle(
                    color: Color.fromRGBO(71, 121, 173, 1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Updated ShowKidDetails widget
class ShowKidDetails extends StatelessWidget {
  final int number;
  final String name; // Now subject name
  final int gold;
  final int silver;
  final int bronze;
  final bool isSelected;

  const ShowKidDetails({
    super.key,
    required this.number,
    required this.name,
    required this.gold,
    required this.silver,
    required this.bronze,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: isSelected
            ? const Color.fromRGBO(80, 120, 160, 1)
            : const Color.fromRGBO(111, 148, 188, 1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1,
          color: isSelected ? Colors.blue : Colors.black,
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '#$number',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              name, // Subject name shown here
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Row(
                  children: [
                    Text(
                      "$gold ",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Image.asset("assets/Gold.png"),
                  ],
                ),
                const SizedBox(width: 5),
                Row(
                  children: [
                    Text(
                      "$silver",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Image.asset("assets/Silver.png"),
                  ],
                ),
                const SizedBox(width: 5),
                Row(
                  children: [
                    Text(
                      "$bronze",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Image.asset("assets/Bronz.png"),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildAchievementItem(String text, String medalIcon) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
    child: Row(
      children: [
        Image.asset(medalIcon),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}
