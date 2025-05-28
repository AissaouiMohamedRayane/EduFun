import 'package:flutter/material.dart';

class PrivacySettingsSection extends StatefulWidget {
  @override
  _PrivacySettingsSectionState createState() => _PrivacySettingsSectionState();
}

class _PrivacySettingsSectionState extends State<PrivacySettingsSection> {
  int _dataSharingLevel = 0; // 0: Minimal, 1: Moderate, 2: Full
  bool _locationTrackingEnabled = false;
  bool _adPersonalizationEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Privacy Settings',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Control how your information is used',
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
        SizedBox(height: 24),

        // Data Sharing Section
        Text(
          'Data Sharing',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        _buildDataSharingOption(
          value: 0,
          title: 'Minimal',
          description:
              'Only share essential data required for the app to function.',
        ),
        _buildDataSharingOption(
          value: 1,
          title: 'Moderate',
          description:
              'Share data to improve app experience and recommendations.',
        ),
        _buildDataSharingOption(
          value: 2,
          title: 'Full',
          description:
              'Share data to get personalized content and help improve services.',
        ),
        SizedBox(height: 24),

        Divider(height: 1),
        SizedBox(height: 16),

        // Location Tracking Section
        _buildToggleOption(
          title: 'Location Tracking',
          description: 'Allow app to access your location.',
          value: _locationTrackingEnabled,
          onChanged: (value) {
            setState(() {
              _locationTrackingEnabled = value;
            });
          },
        ),
        SizedBox(height: 16),

        // Ad Personalization Section
        _buildToggleOption(
          title: 'Ad Personalization',
          description: 'Allow personalized ads based on your activity.',
          value: _adPersonalizationEnabled,
          onChanged: (value) {
            setState(() {
              _adPersonalizationEnabled = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildDataSharingOption({
    required int value,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Radio<int>(
            value: value,
            groupValue: _dataSharingLevel,
            onChanged: (int? newValue) {
              setState(() {
                _dataSharingLevel = newValue ?? 0;
              });
            },
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleOption({
    required String title,
    required String description,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Text(
                description,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ),
            Switch(
              value: value,
              onChanged: onChanged,
              activeColor: Colors.blue,
            ),
          ],
        ),
      ],
    );
  }
}
