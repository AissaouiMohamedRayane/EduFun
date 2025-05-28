import 'package:flutter/material.dart';

class SwitchAccount extends StatefulWidget {
  const SwitchAccount({super.key});

  @override
  State<SwitchAccount> createState() => _SwitchAccountState();
}

class _SwitchAccountState extends State<SwitchAccount> {
  List<Map<String, String>> arrayOfParents = [
    {'name': 'Parent Name', 'imageAssets': "assets/images/1.png"},
    {'name': "Maman's Name", 'imageAssets': "assets/images/1.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Makes it fit content dynamically
        children: [
          // Header with Close Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Switch Account",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context), // Close overlay
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Instruction Text
          const Text("Choose the account that you want to switch"),

          const SizedBox(height: 10),

          // List of Parent Accounts
          Column(
            children:
                arrayOfParents.map((parent) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue.shade600,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: Image.asset(
                          parent['imageAssets']!,
                          width: 40,
                          height: 40,
                        ),
                        title: Text(
                          parent['name']!,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          // Handle switch account action
                          print("Switched to ${parent['name']}");
                          Navigator.pop(context); // Close overlay
                        },
                      ),
                    ),
                  );
                }).toList(),
          ),

          const SizedBox(height: 10),

          // Buttons for switching accounts
          TextButton(
            onPressed: () {
              // Handle another account switch
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color.fromRGBO(54, 136, 222, 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                "Switch To Another Account",

                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              // Handle kid account switch
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 236, 231, 231),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                "Kid ACCOUNT",
                style: TextStyle(
                  color: Color.fromRGBO(54, 136, 222, 1),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
