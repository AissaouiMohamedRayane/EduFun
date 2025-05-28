import 'package:flutter/material.dart';
import '../../../../services/API/auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isParentSelected = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void updatePlaceholders(bool isParent) {
    setState(() {
      isParentSelected = isParent;
      emailController.text = "";
      passwordController.text = "";

      emailController.value = TextEditingValue(
        text: "",
        selection: TextSelection.collapsed(offset: 0),
      );

      passwordController.value = TextEditingValue(
        text: "",
        selection: TextSelection.collapsed(offset: 0),
      );
    });
  }

  void validateAndProceed() async {
    if (_formKey.currentState!.validate()) {
      bool? success;
      if (isParentSelected) {
         success =
            await loginParent(emailController.text, passwordController.text);
      } else {
         success =
            await loginChild(emailController.text, passwordController.text);
      }

      if (success == true) {
        // Navigate to the main screen
      print('test');
        Navigator.pushReplacementNamed(context, '/');
      } else {
        // Handle login failure (e.g., show a snackbar or alert)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login failed. Please try again.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 80),

                // Centered Tabs Container with Padding and Rounded Borders
                Container(
                  width: 250,
                  height: 60,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      _buildTabButton("Parent", true),
                      _buildTabButton("Kid", false),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // Welcome Text
                const Text(
                  "Welcome Back !!",
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Poppins',
                  ),
                ),

                const SizedBox(height: 60),

                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Email Input (Dynamic Placeholder)
                      _buildTextFieldSignIn(
                        label:
                            isParentSelected ? "Enter Your Email" : "Family ID",
                        controller: emailController,
                        validator: (value) => (value == null || value.isEmpty)
                            ? "Field cannot be empty"
                            : null,
                      ),

                      const SizedBox(height: 30),

                      // Password Input (Dynamic Placeholder)
                      _buildTextFieldSignIn(
                        label:
                            isParentSelected ? "Enter Your Password" : "Own ID",
                        controller: passwordController,
                        isPassword: true,
                        validator: (value) => (value == null || value.isEmpty)
                            ? "Field cannot be empty"
                            : null,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 60),

                // Next Button
                ElevatedButton(
                  onPressed: validateAndProceed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF774FE3),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 50,
                    ),
                  ),
                  child: const Text(
                    "Next",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Function to build tab buttons (Kids/Parent)
  Widget _buildTabButton(String label, bool isParent) {
    bool isSelected = isParent ? isParentSelected : !isParentSelected;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          updatePlaceholders(isParent);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF774FE3) : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.white : Colors.grey[400],
            ),
          ),
        ),
      ),
    );
  }

  // Input Field Builder Function
  Widget _buildTextFieldSignIn({
    required String label,
    required TextEditingController controller,
    bool isPassword = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontFamily: 'Poppins'),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 12,
        ),
      ),
      validator: validator,
    );
  }
}
