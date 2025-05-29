import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/models/users.dart';
import '../screens/settings.dart';

class ChildSideLayout extends StatefulWidget {
  final Widget child;
  final bool home;

  const ChildSideLayout({super.key, required this.child, required this.home});

  @override
  State<ChildSideLayout> createState() => _ChildSideLayoutState();
}

class _ChildSideLayoutState extends State<ChildSideLayout> {
  @override
  Widget build(BuildContext context) {
    final childProvider = Provider.of<ChildProvider>(context);

    return Scaffold(
      body: childProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                // Background image
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/childSide/childSideBackground.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Gradient overlay
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.64),
                        Colors.black.withOpacity(0.64),
                      ],
                    ),
                  ),
                ),

                // Use the passed-in child widget here
                Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 30),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),

                                color: const Color(0xFF56C8CC),
                                // Your color
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 60,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,

                                      color: Colors.white, // Your color
                                    ),
                                    child: const Center(
                                        child: Icon(
                                      Icons.star,
                                      size: 50,
                                      color: Color(0xFF779FE5),
                                    )),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    childProvider.child!.points.toString(),
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontFamily: 'Rubik',
                                        fontWeight: FontWeight.w800),
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if(widget.home)
                                Navigator.of(
                                  context,
                                ).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const childSideSettings()));
                              },
                              child: SizedBox(
                                width: 60,
                                height: 60,
                                child: ClipOval(
                                  child: Image.asset(
                                    "assets/images/profileChildrenPictures/${childProvider.child!.avatar}.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        widget.child,
                      ],
                    )),
              ],
            ),
    );
  }
}
