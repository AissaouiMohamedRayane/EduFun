import 'package:flutter/material.dart';
import 'package:frontend/components/ParentSideComponents/HeadingandDushboard.dart';
import 'package:frontend/components/ParentSideComponents/BottomNavBar.dart';
import 'package:frontend/components/ParentSideComponents/screens/familycontrole/EduFunPremiumScreen.dart';
import '../../../services/models/users.dart';

class RewardStore extends StatefulWidget {
  final Child? child;

  RewardStore({super.key, this.child});

  @override
  State<RewardStore> createState() => _RewardStoreState();
}

class _RewardStoreState extends State<RewardStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(223, 246, 242, 1),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    const Heading(),
                    const SizedBox(height: 30),
                    _buildTitle("Available Rewards Wassa"),
                    const SizedBox(height: 20),
                    _buildCurrencyGrid(),
                    const SizedBox(height: 30), // Space before back button
                  ],
                ),
              ),
            ),
          ),

          // Back button placed outside the scrollable area
        ],
      ),
    );
  }

  Widget _buildTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Color(0xFF2086CB),
      ),
    );
  }

  Widget _buildCurrencyGrid() {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.1,
      ),
      itemCount: 8,
      itemBuilder: (context, index) => _buildCurrencyItem(),
    );
  }

  Widget _buildCurrencyItem() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const Text(
                "20 €",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                "4.9%",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2086CB),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text("Buy"),
            ),
          ),
        ],
      ),
    );
  }
}
