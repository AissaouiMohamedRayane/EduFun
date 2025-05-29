import 'package:flutter/material.dart';
// import 'package:frontend/components/ParentSideComponents/BottomNavBar.dart';
// import 'package:frontend/components/ParentSideComponents/screens/ParentSide/ParentSide.dart';
// import 'package:frontend/components/ParentSideComponents/screens/Utilities/slectAvatar.dart';

import '../../services/API/auth.dart';

import 'package:EduFun/components/ParentSideComponents/screens/auth/registration/Mychoice.dart';

// Parent Form Class
class ParentForm extends StatefulWidget {
  const ParentForm({super.key});

  @override
  State<ParentForm> createState() => _ParentFormState();
}

class _ParentFormState extends State<ParentForm> {
  Map<String, String> information = {
    'username': '',
    'firstName': '',
    'lastName': '',
    'email': '',
    'password': '',
    'confPassword': ''
  };
  final _formKey = GlobalKey<FormState>();
  bool isEmail(String? email) {
    final emailRegex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );
    return emailRegex.hasMatch(email ?? '');
  }

  Widget _buildTextField(
    String label,
    String field, {
    bool isPassword = false,
    required String? Function(String?) validator, // 🔄 FIX HERE
  }) {
    return TextFormField(
      obscureText: isPassword, // ✅ Hide password input when needed
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          fontFamily: 'Poppins',
        ), // ✅ Apply Poppins font
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      ),
      onSaved: (newValue) => information[field] = newValue ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 90),
              const Text(
                "Please fill the following Information",
                style: TextStyle(
                  fontSize: 25,
                  color: Color(0xFF774FE3),
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Poppins', // ✅ Apply Poppins font
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 70),
              _buildTextField(
                "Enter your user name",
                'username',
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "username is required";
                },
              ),
              const SizedBox(height: 40),
              _buildTextField(
                "Enter your Email",
                'email',
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "Email is required";
                  if (!isEmail(value)) return "Enter a valid email";
                  return null;
                },
              ),
              const SizedBox(height: 40),
              _buildTextField(
                "Enter your password",
                'password',
                isPassword: true,
                validator: (value) {
                  if (value == null || value.isEmpty) return "required";
                  if (information['password'] != information['confPassword'])
                    return 'Passwords do not match';
                },
              ),
              const SizedBox(height: 40),
              _buildTextField(
                "Confirme your password",
                'confPassword',
                isPassword: true,
                validator: (value) {
                  if (value == null || value.isEmpty) return "required";
                  if (information['password'] != information['confPassword'])
                    return 'Passwords do not match';
                },
              ),
              const SizedBox(height: 80),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildButton(
                    text: "Back",
                    color: Colors.white,
                    textColor: const Color(0xFF774FE3),
                    onPressed: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  _buildButton(
                      text: "Submit",
                      color: const Color(0xFF774FE3),
                      textColor: Colors.white,
                      onPressed: () async {
                        await _submitForm();
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save(); // Save the form state

      // Call the login function with the username and password
      bool success = await registerParent(information['username']!,
          information['password']!, information['email']!);

      if (success) {
        // Navigate to the main screen

        Navigator.pushReplacementNamed(context, '/');
      } else {
        // Handle login failure (e.g., show a snackbar or alert)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login failed. Please try again.')),
        );
      }
    }
  }
}

// Reusable Button Widget
Widget _buildButton({
  required String text,
  required Color color,
  required Color textColor,
  required VoidCallback onPressed,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 45),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 18,
        color: textColor,
        fontFamily: 'Poppins', // ✅ Apply Poppins font
      ),
    ),
  );
}
