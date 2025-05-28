import 'package:flutter/material.dart';
import 'package:frontend/components/ParentSideComponents/HeadingandDushboard.dart';
import 'package:frontend/components/forms/childForm.dart';

class KidsAccountManagement extends StatefulWidget {
  const KidsAccountManagement({super.key});

  @override
  State<KidsAccountManagement> createState() => _KidsAccountManagementState();
}

class _KidsAccountManagementState extends State<KidsAccountManagement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(height: 40),
            const Heading(),
            const SizedBox(height: 20),
            _buildChildCardWithAnimation(
              "Child Name",
              "MALE",
              "assets/images/adventurerNeutral-1741401563851.png",
              10,
            ),
            _buildChildCardWithAnimation(
              "Child Name",
              "FEMALE",
              "assets/images/adventurerNeutral-1741401563851.png",
              8,
              delay: 100,
            ),
            const SizedBox(height: 20),
            _buildAddChildButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildChildCardWithAnimation(
    String name,
    String gender,
    String imagePath,
    int age, {
    int delay = 0,
  }) {
    return TweenAnimationBuilder(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 500 + delay),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, (1 - value) * 20),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: _ChildCard(
        name: name,
        gender: gender,
        imagePath: imagePath,
        age: age,
      ),
    );
  }

  // Add Child Button
  Widget _buildAddChildButton() {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey, // Border color
          style: BorderStyle.solid, // Dashed border style
          width: 2, // Border width
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => ChildForm()),
          );
          print("Add Child button pressed");
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(
              Icons.add, // "+" icon
              color: Colors.blue,
            ),
            SizedBox(width: 8),
            Text("Add Child", style: TextStyle(color: Colors.blue)),
          ],
        ),
      ),
    );
  }
}

class _ChildCard extends StatelessWidget {
  final String name;
  final String gender;
  final String imagePath;
  final int age;

  const _ChildCard({
    required this.name,
    required this.gender,
    required this.imagePath,
    required this.age,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Color.fromRGBO(111, 148, 188, 1),
        elevation: 3,
        shadowColor: Colors.black.withOpacity(0.2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(imagePath, height: 40, width: 40),
              ),
              Text(
                "$name",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Text(
                "$gender",
                style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                ),
              ),
              Text("$age years old", style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
