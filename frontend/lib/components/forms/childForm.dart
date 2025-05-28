import 'package:flutter/material.dart';
import 'package:frontend/components/ParentSideComponents/screens/auth/registration/Mychoice.dart';
import 'package:frontend/components/ParentSideComponents/screens/auth/registration/childNextPage.dart';
import '../../services/models/users.dart';

class ChildForm extends StatefulWidget {
  final ParentProvider? parentProvider;
  final Map<String, String>? information;

  ChildForm({Key? key, this.parentProvider, this.information})
      : super(key: key);

  @override
  State<ChildForm> createState() => _ChildFormState();
}

class _ChildFormState extends State<ChildForm> {
  final _formKey = GlobalKey<FormState>();

  Map<String, String> information = {
    'username': '',
    'firstName': '',
    'lastName': '',
  };

  @override
  void initState() {
    super.initState();
    if (widget.information != null) {
      information = widget.information!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            physics: const BouncingScrollPhysics(), // Smooth scrolling
            children: [
              const SizedBox(height: 90),
              const Text(
                "Register for Your Child",
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Poppins',
                  color: Color(0xFF774FE3),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 70),
              _buildTextField(
                "Enter your username",
                'username',
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "username is required";
                },
              ),
              const SizedBox(height: 40),
              _buildTextField(
                "Enter your First Name",
                'firstName',
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "First name is required";
                },
              ),
              const SizedBox(height: 40),
              _buildTextField(
                "Enter your Last Name",
                'lastName',
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "First name is required";
                },
              ),
              const SizedBox(height: 40),

              /// Buttons inside a Row for better alignment
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 40,
                      ),
                    ),
                    child: const Text(
                      "Back",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      print('test10');
                      print(information);
                      _submitForm();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF774FE3),
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 40,
                      ),
                    ),
                    child: const Text(
                      "next",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
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
      _formKey.currentState?.save();

      final returnedInfo = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChildNext(
            information: information,
            parentProvider: widget.parentProvider,
          ),
        ),
      );

      if (returnedInfo != null) {
        setState(() {
          information = Map<String, String>.from(returnedInfo);
        });
      }
    }
  }

  Widget _buildTextField(String label, String field,
      {required String? Function(String?) validator}) {
    return TextFormField(
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontFamily: 'Poppins'),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      ),
      onChanged: (newValue) => information[field] = newValue,
    );
  }
}
