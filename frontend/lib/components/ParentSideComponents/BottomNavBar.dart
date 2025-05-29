import 'package:flutter/material.dart';
import 'package:EduFun/components/ParentSideComponents/Store/RewardStore.dart';
import 'package:EduFun/components/ParentSideComponents/Settings/Settings.dart';
import 'package:EduFun/components/ParentSideComponents/screens/ParentSide/ParentSide.dart';
import '../../services/models/users.dart';

class BottomNavBar extends StatefulWidget {
  final Child child;

  BottomNavBar({Key? key, required this.child}) : super(key: key);
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 1;

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      RewardStore(child: widget.child),
      ParentSide(child: widget.child),
      Settings(child: widget.child),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(223, 246, 242, 1),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.store),
                  label: "Store",
                ),
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: "Settings",
                ),
              ],
              selectedItemColor: const Color(0xFF2086CB),
              unselectedItemColor: Colors.black,
              elevation: 0,
              type: BottomNavigationBarType.fixed,
            ),
          ),
        ),
      ),
    );
  }
}
