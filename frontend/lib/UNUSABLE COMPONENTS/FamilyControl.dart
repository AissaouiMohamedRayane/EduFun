import 'package:flutter/material.dart';
import 'package:frontend/components/ParentSideComponents/Buy.dart';
import 'package:frontend/components/ParentSideComponents/HeadingandDushboard.dart';
import 'package:frontend/components/ParentSideComponents/Home/ScreenTime.dart';
import 'package:frontend/components/ParentSideComponents/Home/ScreenTimeLimits.dart';
import 'package:frontend/components/ParentSideComponents/screens/ParentSide/EditDeviceScreen.dart';
import 'package:frontend/components/ParentSideComponents/screens/ParentSide/KidsAccountMangement.dart';
import 'package:frontend/components/ParentSideComponents/screens/familycontrole/CollaborativeLearning.dart';

class FamilyControle extends StatefulWidget {
  const FamilyControle({super.key});

  @override
  State<FamilyControle> createState() => _FamilyControleState();
}

int numberOfChildren = 5; // from backend

class _FamilyControleState extends State<FamilyControle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50),
              Heading(),
              SizedBox(height: 20),
              Text(
                "Family Control",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(32, 134, 203, 1),
                  shadows: [
                    Shadow(
                      blurRadius: 2,
                      color: Colors.black12,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              _buildChildCardWithAnimation(
                "BISSOU",
                "MALE",
                "assets/images/adventurerNeutral-1741401560712.png",
                19,
              ),
              _buildChildCardWithAnimation(
                "RAYANE",
                "MALE",
                "assets/images/adventurerNeutral-1741401570245.png",
                19,
                delay: 100,
              ),
              SizedBox(height: 20),
              _buildManageButton(),
              SizedBox(height: 20),
              _StandardText("Competition"),
              Container(
                width: 315,
                decoration: BoxDecoration(
                  color: Colors.blueGrey[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    _StandardText("Screen Time Limites"),
                    CollaborativeLearning(),
                  ],
                ),
              ),
              SizedBox(height: 20),
              _StandardText("Screen and Schedules"),
              ScreenTimeLimits(),
              SizedBox(height: 20),
              _StandardText("Some Rewards For Your Kids"),
              SizedBox(height: 10),
              Buy(),
              SizedBox(height: 20),
              _StandardText("Kids Devices"),
              StandardCardFoDevices(
                context, // Pass context here
                "name",
                "assets/images/adventurerNeutral-1741401560712.png",
                "Beni Ourtilane , Setif",
              ),
              StandardCardFoDevices(
                context, // Pass context here
                "Mouhammed",
                "assets/images/adventurerNeutral-1741401570245.png",
                "Salambi , Alger",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChildCardWithAnimation(
    String name,
    String gendre,
    String ImagePath,
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
      child: StandardCard(name, gendre, ImagePath, age),
    );
  }

  Widget _buildManageButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 70),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => KidsAccountManagement()),
          );
        },
        onHover: (isHovered) {},
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: Color.fromRGBO(32, 134, 203, 1),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Text(
              "Manage Kids Account",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _StandardText(String title) {
  return Padding(
    padding: EdgeInsets.only(bottom: 10),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color.fromRGBO(32, 134, 203, 1),
        shadows: [
          Shadow(blurRadius: 2, color: Colors.black12, offset: Offset(1, 1)),
        ],
      ),
    ),
  );
}

Widget StandardCard(String name, String gendre, String ImagePath, int age) {
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
              child: Image.asset(ImagePath, height: 40, width: 40),
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
              "$gendre",
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

Widget StandardCardFoDevices(
  BuildContext context, // Accept context here
  String name,
  String ImagePath,
  String Location,
) {
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
            Icon(Icons.phone),
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(ImagePath, height: 40, width: 40),
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
                  "$Location",
                  style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  width: 100,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context, // Use the context passed to the widget
                        MaterialPageRoute(
                          builder: (context) => EditDeviceScreen(),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      side: const BorderSide(
                        color: Colors.white,
                      ), // White border
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Text("Active"),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: TextButton(
                    onPressed: () {
                      // Handle the edit action here
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue,
                      side: const BorderSide(color: Colors.blue),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Text("Edit"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
