import 'package:flutter/material.dart';
import 'package:EduFun/components/ParentSideComponents/BottomNavBar.dart';
import 'package:EduFun/components/forms/childForm.dart';
import 'package:provider/provider.dart';
import '../services/models/users.dart';
import '../services/models/token.dart';
import 'package:flutter/services.dart';

class SelectKidScreen extends StatefulWidget {
  const SelectKidScreen({Key? key}) : super(key: key);

  @override
  State<SelectKidScreen> createState() => _SelectKidScreenState();
}

class _SelectKidScreenState extends State<SelectKidScreen> {
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      context.read<ParentProvider>().initializeParent();
      context.read<TokenProvider>().initializeToken();
      _isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final parentProvider = Provider.of<ParentProvider>(context);
    final tokenProvider = Provider.of<TokenProvider>(context);
    return parentProvider.isLoading || tokenProvider.isLoading
        ? const Center(child: CircularProgressIndicator())
        : parentProvider.parent == null
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Connection lost'),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )
            : Scaffold(
                body: Container(
                  decoration: const BoxDecoration(color: Color(0xFFD4F1FF)),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset("assets/images/1.png",
                                      height: 60, width: 60),
                                  const SizedBox(width: 10),
                                  Text(
                                    parentProvider.parent!.username,
                                    style: const TextStyle(
                                      color: Colors.blue,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    parentProvider.parent!.familyCode,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 2, 18, 32),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        Clipboard.setData(ClipboardData(
                                            text: parentProvider.parent!.familyCode));
                                        // Optional: Show confirmation
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content:
                                                  Text("Copied to clipboard")),
                                        );
                                      },
                                      icon: Icon(Icons.copy))
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            "Select one of your kids",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 30),
                          Expanded(
                            child: GridView.count(
                                crossAxisCount: 2,
                                mainAxisSpacing: 20,
                                crossAxisSpacing: 20,
                                childAspectRatio: 0.9,
                                children: [
                                  ...parentProvider.children.map((child) {
                                    return _buildKidAvatar(
                                        context,
                                        child.username,
                                        Colors.orange.shade200,
                                        "assets/images/profileChildrenPictures/${child.avatar}.png",
                                        child);
                                  }),
                                  _buildAddNewKid(context, parentProvider),
                                ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
  }
}

Widget _buildKidAvatar(BuildContext context, String name, Color backgroundColor,
    String imagePath, Child child) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BottomNavBar(child: child)),
      );
    },
    child: Column(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(imagePath, fit: BoxFit.cover),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(
            color: Colors.blue,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

Widget _buildAddNewKid(BuildContext context, ParentProvider parentProvider) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChildForm(parentProvider: parentProvider)),
      );
    },
    child: Column(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey.withOpacity(0.5),
                width: 2,
                style: BorderStyle.solid,
              ),
            ),
            child: const Center(
              child: Icon(Icons.add, size: 40, color: Colors.grey),
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "Add New",
          style: TextStyle(
            color: Colors.blue,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

class KidInformation extends StatelessWidget {
  final String name;
  final String image;
  final String fullName;

  const KidInformation({
    super.key,
    required this.name,
    required this.image,
    required this.fullName,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100, // Fixed height
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 100,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 80, height: 80, child: Image.asset(image)),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(fullName, style: TextStyle(fontSize: 16)),
              ],
            ),
            Image.asset("assets/Settings.png"),
          ],
        ),
      ),
    );
  }
}
