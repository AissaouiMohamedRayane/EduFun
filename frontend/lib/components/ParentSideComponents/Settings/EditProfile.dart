import 'package:flutter/material.dart';
import 'package:EduFun/components/ParentSideComponents/HeadingandDushboard.dart';
import 'package:provider/provider.dart';
import '../../../services/models/users.dart';

class EditProfile extends StatefulWidget {
  final ParentProvider parentProvider;
  const EditProfile({super.key, required this.parentProvider});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  // Create controllers for each editable field
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  // Track which fields are being edited
  bool _editingFullName = false;
  bool _editingEmail = false;

  @override
  void dispose() {
    // Dispose all controllers when the widget is disposed
    _fullNameController.dispose();
    _emailController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _fullNameController.text = widget.parentProvider.parent!.username;
    _emailController.text = widget.parentProvider.parent!.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Heading(),
            const SizedBox(height: 30),
            _buildSectionTitle("Manage your personal details"),
            const SizedBox(height: 20),
            _buildEditableProfileField(
              label: "username",
              controller: _fullNameController,
              isEditing: _editingFullName,
              onEdit: () => setState(() => _editingFullName = true),
              onSave: () => setState(() => _editingFullName = false),
            ),
            _buildEditableProfileField(
              label: "Email Address",
              controller: _emailController,
              isEditing: _editingEmail,
              onEdit: () => setState(() => _editingEmail = true),
              onSave: () => setState(() => _editingEmail = false),
            ),
            const SizedBox(height: 30),
            _buildSaveAllButton(widget.parentProvider),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildEditableProfileField({
    required String label,
    required TextEditingController controller,
    required bool isEditing,
    required VoidCallback onEdit,
    required VoidCallback onSave,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              if (!isEditing)
                IconButton(
                  icon: const Icon(Icons.edit, size: 20),
                  onPressed: onEdit,
                  color: const Color(0xFF2086CB),
                ),
            ],
          ),
          const SizedBox(height: 4),
          isEditing
              ? Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.check, color: Colors.green),
                      onPressed: onSave,
                    ),
                  ],
                )
              : Text(
                  controller.text,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
          const Divider(height: 20),
        ],
      ),
    );
  }

  Widget _buildSaveAllButton(ParentProvider parentProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            if (_editingEmail || _editingFullName) {
              _submitForm(parentProvider);
            }
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: _editingEmail || _editingFullName
                ? const Color(0xFF2086CB)
                : const Color.fromARGB(255, 141, 179, 205),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Save All Changes',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submitForm(ParentProvider parentProvider) async {
    bool isEmail(String? email) {
      final emailRegex = RegExp(
        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
      );
      return emailRegex.hasMatch(email ?? '');
    }

    if (isEmail(_emailController.text)) {
      final bool success = await parentProvider.editParent(
          _fullNameController.text, _emailController.text);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Profile updated successfully"),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Profile updated failed"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Wrong email format"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
