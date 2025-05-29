import 'package:flutter/material.dart';

import '../layout/childSideLayout.dart';
import 'package:provider/provider.dart';
import '../services/models/users.dart';
import './gamesPage.dart';

class ChildSideHome extends StatefulWidget {
  const ChildSideHome({super.key});

  @override
  State<ChildSideHome> createState() => _ChildSideHomeState();
}

class _ChildSideHomeState extends State<ChildSideHome> {
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      context.read<ChildProvider>().initializeChild();
      _isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final childProvider = Provider.of<ChildProvider>(context);

    return childProvider.isLoading
        ? const Center(child: CircularProgressIndicator())
        : ChildSideLayout(
          home: true,
            child: Column(
              children: [
               
                const SizedBox(
                  height: 100,
                ),
                Text(
                  'Hey ${childProvider.child!.username}',
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
                  height: 200,
                ),
                Container(
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
                    onPressed: () {
                      Navigator.of(
                        context,
                      ).push(
                          MaterialPageRoute(builder: (context) => Gamespage()));
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
                      "Play",
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
                )
              ],
            ),
          );
  }
}
