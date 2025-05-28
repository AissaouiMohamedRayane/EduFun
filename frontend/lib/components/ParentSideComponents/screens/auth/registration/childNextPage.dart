// ignore: file_names
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:frontend/components/ParentSideComponents/screens/Utilities/slectAvatar.dart';
import 'package:frontend/components/ParentSideComponents/BottomNavBar.dart';
import 'package:frontend/components/forms/childForm.dart';

import 'package:frontend/services/API/child.dart';

import '../../../../../services/models/users.dart';
import '../../../../../services/models/token.dart';

class ChildNext extends StatefulWidget {
  final Map<String, String>? information;
  final ParentProvider? parentProvider;
  const ChildNext({super.key, this.information, this.parentProvider});

  @override
  _ChildNextState createState() => _ChildNextState();
}

class _ChildNextState extends State<ChildNext> {
  DateTime? _selectedDate;
  bool? _selectedGender;
  final TextEditingController _familyCodeController = TextEditingController();
  String? familyCode;
  final _formKey = GlobalKey<FormState>();

  // Function to show DatePicker
  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final tokenProvider = Provider.of<TokenProvider>(context);

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
                "More Information about Your Child",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Poppins',
                  color: const Color(0xFF774FE3),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 70),

              // Date of Birth Picker
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Select Date of Birth",
                      labelStyle: const TextStyle(fontFamily: 'Poppins'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 12,
                      ),
                    ),
                    controller: TextEditingController(
                      text: _selectedDate == null
                          ? ""
                          : "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}",
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Gender Dropdown
              DropdownButtonFormField<bool>(
                value: _selectedGender,
                decoration: InputDecoration(
                  labelText: "Select Gender",
                  labelStyle: const TextStyle(fontFamily: 'Poppins'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 12,
                  ),
                ),
                items: [true, false]
                    .map(
                      (gender) => DropdownMenuItem(
                        value: gender,
                        child: Text(
                          gender ? 'Male' : 'female',
                          style: const TextStyle(fontFamily: 'Poppins'),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
                onSaved: (newValue) => _selectedGender = newValue,
              ),
              const SizedBox(height: 40),

              // Username Input Field
              if (widget.parentProvider == null)
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return "family code required";
                  },
                  controller: _familyCodeController,
                  decoration: InputDecoration(
                    labelText: "Enter your family code",
                    labelStyle: const TextStyle(fontFamily: 'Poppins'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 12,
                    ),
                  ),
                  onSaved: (newValue) => familyCode = newValue,
                ),
              if (widget.parentProvider == null) const SizedBox(height: 40),

              /// Buttons inside a Row for better alignment
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context, widget.information),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 50,
                      ),
                    ),
                    child: const Text(
                      "Back",
                      style: TextStyle(
                        fontSize: 18,
                        color: const Color(0xFF774FE3),
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _submitForm(tokenProvider.token!);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF774FE3),
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 50,
                      ),
                    ),
                    child: const Text(
                      "Submit",
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

  Future<void> _submitForm(String token) async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      if (widget.parentProvider != null && widget.information != null) {
        final formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate!);

        Map<String, dynamic> child = {
          'username': widget.information!['username'],
          'lastName': widget.information!['lastName'],
          'firstName': widget.information!['firstName'],
          'dob': formattedDate
        };
        bool success = await widget.parentProvider!.addChild(child);
        if (success) {
          // Navigate to the main screen
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('add child with success.'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pushReplacementNamed(context, '/');
        } else {
          // Handle login failure (e.g., show a snackbar or alert)
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('failed. Please try again.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }
}
