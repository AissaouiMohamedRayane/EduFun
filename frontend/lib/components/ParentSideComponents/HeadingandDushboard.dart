import 'package:flutter/material.dart';
import 'package:EduFun/components/ParentSideComponents/Home/Notification.dart';
import 'package:EduFun/components/ParentSideComponents/Settings/EditProfile.dart';
import 'package:EduFun/components/ParentSideComponents/Settings/NotificationBar.dart';
import 'package:EduFun/components/ParentSideComponents/Store/RewardStore.dart';
import 'package:EduFun/components/ParentSideComponents/Settings/Settings.dart';
import 'package:EduFun/main.dart';
import 'package:EduFun/components/ParentSideComponents/screens/Utilities/showSwitchAccountOverlay.dart';

class Heading extends StatelessWidget {
  const Heading({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset("assets/images/1.png", height: 50, width: 50),

        const Text(
          "Parent Side",
          style: TextStyle(
            color: Color(0xFF2086CB),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.notification_add),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => NotificationsScreen()),
            );
          },
          splashColor: Colors.blue.withOpacity(0.3), // Splash effect color
          highlightColor: Colors.blue.withOpacity(
            0.1,
          ), // Highlight when pressed
        ),
      ],
    );
  }
}
