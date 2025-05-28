// ignore: file_names
import 'package:flutter/material.dart';
import 'package:frontend/components/forms/childForm.dart';
import 'package:frontend/components/forms/parentForm.dart';
import 'package:frontend/components/ParentSideComponents/screens/auth/login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 150),
            const Text(
              "WELCOME TO EDUFUN",
              style: TextStyle(
                fontSize: 29,
                fontWeight: FontWeight.w700,
                fontFamily: 'Poppins',
                color: Color(0xFF774FE3),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 200),
            const Text(
              "Already have an account?",
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Poppins', // ✅ Apply Poppins font
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (context) => const SignIn()));
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue, // Text color
              ),
              child: const Text(
                "Login",
                style: TextStyle(
                  fontSize: 18,
                  decoration: TextDecoration.underline, // Underline effect
                  decorationColor: Colors.blue, // Color of the underline
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins', // ✅ Apply Poppins font
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 320,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(
                      builder: (context) => const ParentForm()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF774FE3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Next",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontFamily: 'Poppins', // ✅ Apply Poppins font
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridItem(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 149,
        width: 149,
        decoration: BoxDecoration(
          color: const Color(0xFF774FE3),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18,
            fontFamily: 'Poppins', // ✅ Apply Poppins font
          ),
        ),
      ),
    );
  }
}
