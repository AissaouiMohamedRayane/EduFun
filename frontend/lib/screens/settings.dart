import 'package:EduFun/services/models/users.dart';
import 'package:flutter/material.dart';
import '../layout/childSideLayout.dart';
import 'package:provider/provider.dart';

class childSideSettings extends StatefulWidget {
  const childSideSettings({super.key});

  @override
  State<childSideSettings> createState() => _childSideSettingsState();
}

class _childSideSettingsState extends State<childSideSettings> {
  @override
  Widget build(BuildContext context) {
    final childProvider = Provider.of<ChildProvider>(context);

    return childProvider.isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ChildSideLayout(
            home: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Text(
                  '${childProvider.child!.username}',
                  style: const TextStyle(
                    color: Color(0xFF56C8CC),
                    fontFamily: 'Rubik',
                    fontSize: 42,
                    fontWeight: FontWeight.w800,
                    fontStyle: FontStyle.normal,
                    height: 1, // equivalent to normal line-height
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFF40B7A3),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(255, 255, 255, 0.25),
                        offset: Offset(-4, 4),
                        blurRadius: 4,
                      ),
                      BoxShadow(
                        color: Color(0xFF3DB86E),
                        offset: Offset(4, -4),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      surfaceTintColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 48, vertical: 24),
                    ),
                    child: const Text(
                      "Acquisition",
                      style: TextStyle(
                        color: Colors.white, // #FFF
                        fontFamily: 'Rubik',
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        fontStyle: FontStyle.normal,
                        height: 1.0, // equivalent to line-height: normal
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFF40B7A3),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(255, 255, 255, 0.25),
                        offset: Offset(-4, 4),
                        blurRadius: 4,
                      ),
                      BoxShadow(
                        color: Color(0xFF3DB86E),
                        offset: Offset(4, -4),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      surfaceTintColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 48, vertical: 24),
                    ),
                    child: const Text(
                      "Ranking",
                      style: TextStyle(
                        color: Colors.white, // #FFF
                        fontFamily: 'Rubik',
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        fontStyle: FontStyle.normal,
                        height: 1.0, // equivalent to line-height: normal
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(255, 255, 255, 0.25),
                        offset: Offset(-4, 4),
                        blurRadius: 4,
                      ),
                      BoxShadow(
                        color: Colors.red,
                        offset: Offset(4, -4),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      _logout(context, childProvider);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      surfaceTintColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 48, vertical: 24),
                    ),
                    child: const Text(
                      "Logout",
                      style: TextStyle(
                        color: Colors.white, // #FFF
                        fontFamily: 'Rubik',
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        fontStyle: FontStyle.normal,
                        height: 1.0, // equivalent to line-height: normal
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}

void _logout(BuildContext context, ChildProvider childProvider) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Log Out"),
      content: const Text("Are you sure you want to log out?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            // Perform logout
            childProvider.logoutChild();
            Navigator.pushReplacementNamed(context, '/');

            print("User logged out");
          },
          child: const Text(
            "Log Out",
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    ),
  );
}
