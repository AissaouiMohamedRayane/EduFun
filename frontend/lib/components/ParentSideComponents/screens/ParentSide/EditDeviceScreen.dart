import 'package:flutter/material.dart';

class EditDeviceScreen extends StatelessWidget {
  const EditDeviceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit your kids Device'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Edit Device\'s Name'),
            _buildTextField('Enter new device name'),
            const SizedBox(height: 30),
            _buildSectionTitle("Add The Name"),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: "Select a Name",
                border: OutlineInputBorder(),
              ),
              items:
                  ["BISSOU", "RAYANE", "Mouhammed", "Ali"].map((name) {
                    return DropdownMenuItem(value: name, child: Text(name));
                  }).toList(),
              onChanged: (value) {
                print("Selected: $value");
              },
            ),
            const SizedBox(height: 30),
            _buildSectionTitle('Device Restrictions'),
            _buildToggleOption('Apply Screen Time Limits', true),
            _buildToggleOption('Apply Content Filters', false),
            _buildToggleOption('Allow App Installation', true),
            _buildToggleOption('Allow In-App Purchases', false),
            const SizedBox(height: 30),
            _buildSectionTitle('Device Status'),
            _buildStatusOption('Active (Monitored)', true),
            _buildStatusOption('Locked (Unusable)', false),
            _buildStatusOption('Unrestricted (Parent Device)', false),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton('Cancel', Colors.grey, () {
                  Navigator.pop(context);
                }),
                _buildActionButton('Confirm', const Color(0xFF2086CB), () {
                  // Save changes logic
                  Navigator.pop(context);
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
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

  Widget _buildTextField(String hint) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          // contentPadding: const EdgeInsets.symmetric(
          //   horizontal: 15,
          //   vertical: 12,
          // ),
        ),
      ),
    );
  }

  Widget _buildToggleOption(String label, bool value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(child: Text(label, style: const TextStyle(fontSize: 16))),
          Switch(
            value: value,
            activeColor: const Color(0xFF2086CB),
            onChanged: (bool newValue) {},
          ),
        ],
      ),
    );
  }

  Widget _buildStatusOption(String label, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2086CB).withOpacity(0.1) : null,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? const Color(0xFF2086CB) : Colors.grey[300]!,
          ),
        ),
        child: RadioListTile<bool>(
          title: Text(label),
          value: true,
          groupValue: isSelected,
          activeColor: const Color(0xFF2086CB),
          onChanged: (bool? value) {},
          dense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        ),
      ),
    );
  }

  Widget _buildActionButton(String text, Color color, VoidCallback onPressed) {
    return SizedBox(
      width: 120,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(text, style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}
