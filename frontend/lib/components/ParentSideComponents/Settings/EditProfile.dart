import 'package:flutter/material.dart';
import 'package:frontend/components/ParentSideComponents/HeadingandDushboard.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  // Create controllers for each editable field
  final TextEditingController _fullNameController = TextEditingController(
    text: "UserName",
  );
  final TextEditingController _emailController = TextEditingController(
    text: "abcd@gmail.com",
  );
  final TextEditingController _phoneController = TextEditingController(
    text: "+213 00 00 00 00",
  );
  final TextEditingController _dobController = TextEditingController(
    text: "day / month /  year",
  );
  final TextEditingController _pobController = TextEditingController(
    text: "Dellys",
  );
  final TextEditingController _addressController = TextEditingController(
    text: "...",
  );
  final TextEditingController _genderController = TextEditingController(
    text: "Male",
  );
  final TextEditingController _statusController = TextEditingController(
    text: "Single",
  );

  // Track which fields are being edited
  bool _editingFullName = false;
  bool _editingEmail = false;
  bool _editingPhone = false;
  bool _editingDob = false;
  bool _editingPob = false;
  bool _editingAddress = false;
  bool _editingGender = false;
  bool _editingStatus = false;

  @override
  void dispose() {
    // Dispose all controllers when the widget is disposed
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    _pobController.dispose();
    _addressController.dispose();
    _genderController.dispose();
    _statusController.dispose();
    super.dispose();
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
              label: "Full Name",
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
            _buildEditableProfileField(
              label: "Phone Number",
              controller: _phoneController,
              isEditing: _editingPhone,
              onEdit: () => setState(() => _editingPhone = true),
              onSave: () => setState(() => _editingPhone = false),
            ),
            _buildEditableProfileField(
              label: "Date of birth",
              controller: _dobController,
              isEditing: _editingDob,
              onEdit: () => setState(() => _editingDob = true),
              onSave: () => setState(() => _editingDob = false),
            ),
            _buildEditableProfileField(
              label: "Place of birth",
              controller: _pobController,
              isEditing: _editingPob,
              onEdit: () => setState(() => _editingPob = true),
              onSave: () => setState(() => _editingPob = false),
            ),
            _buildEditableProfileField(
              label: "Address",
              controller: _addressController,
              isEditing: _editingAddress,
              onEdit: () => setState(() => _editingAddress = true),
              onSave: () => setState(() => _editingAddress = false),
            ),
            _buildEditableProfileField(
              label: "Gender",
              controller: _genderController,
              isEditing: _editingGender,
              onEdit: () => setState(() => _editingGender = true),
              onSave: () => setState(() => _editingGender = false),
            ),
            _buildEditableProfileField(
              label: "Status",
              controller: _statusController,
              isEditing: _editingStatus,
              onEdit: () => setState(() => _editingStatus = true),
              onSave: () => setState(() => _editingStatus = false),
            ),
            const SizedBox(height: 30),
            _buildSaveAllButton(),
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

  Widget _buildSaveAllButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Profile updated successfully")),
            );
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: const Color(0xFF2086CB),
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
}
