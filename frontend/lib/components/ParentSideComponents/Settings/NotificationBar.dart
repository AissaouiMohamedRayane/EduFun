import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class NotificationBar extends StatefulWidget {
  const NotificationBar({super.key});

  @override
  State<NotificationBar> createState() => _NotificationBarState();
}

class _NotificationBarState extends State<NotificationBar> {
  // Notification channels
  bool enableNotifications = true;
  bool screenTimeNotifications = true;
  bool achievementsNotifications = true;
  bool competitionsNotifications = true;
  bool storeNotifications = false;
  bool emailNotifications = true;
  bool smsNotifications = false;
  bool securityNotifications = true;

  // Notification behavior
  String selectedSound = 'Default';
  bool vibrationEnabled = true;
  String notificationFrequency = 'Immediate';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Notification Preferences'),
        backgroundColor: const Color(0xFFE6F2F9),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF2086CB)),
        titleTextStyle: const TextStyle(
          color: Color(0xFF2086CB),
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Container(
        color: const Color(0xFFE6F2F9),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Notification Channels Section
                const Text(
                  'Notification Channels',
                  style: TextStyle(
                    color: Color(0xFF2086CB),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                _buildNotificationChannelsCard(),
                const SizedBox(height: 16),

                // Notifications Behavior Section
                const Text(
                  'Notifications Behavior',
                  style: TextStyle(
                    color: Color(0xFF2086CB),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                _buildNotificationBehaviorCard(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationChannelsCard() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFCCE0F0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildToggleRow('Enable Notifications', enableNotifications, (
              value,
            ) {
              setState(() => enableNotifications = value);
            }),
            _buildToggleRow(
              'Screen Time Notifications',
              screenTimeNotifications,
              (value) {
                setState(() => screenTimeNotifications = value);
              },
            ),
            _buildToggleRow(
              'Achievements Notifications',
              achievementsNotifications,
              (value) {
                setState(() => achievementsNotifications = value);
              },
            ),
            _buildToggleRow(
              'Competitions Notifications',
              competitionsNotifications,
              (value) {
                setState(() => competitionsNotifications = value);
              },
            ),
            _buildToggleRow('Store Notifications', storeNotifications, (value) {
              setState(() => storeNotifications = value);
            }),
            _buildToggleRow('Email Notifications', emailNotifications, (value) {
              setState(() => emailNotifications = value);
            }),
            _buildToggleRow('SMS Notifications', smsNotifications, (value) {
              setState(() => smsNotifications = value);
            }),
            _buildToggleRow('Security Notifications', securityNotifications, (
              value,
            ) {
              setState(() => securityNotifications = value);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationBehaviorCard() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFCCE0F0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Notification Sound
            const Text(
              'Notification Sound',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF4A4A4A),
              ),
            ),
            const SizedBox(height: 8),
            _buildRadioOption('Default', 'Default', 'sound'),
            _buildRadioOption('Chosen Sound', 'Chosen Sound', 'sound'),
            _buildRadioOption('None', 'None', 'sound'),

            const Divider(height: 24, color: Color(0xFFB0C4DE)),

            // Vibration
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Vibration',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF4A4A4A),
                      ),
                    ),
                    Text(
                      'Vibrate when notifications arrive',
                      style: TextStyle(fontSize: 12, color: Color(0xFF808080)),
                    ),
                  ],
                ),
                CupertinoSwitch(
                  value: vibrationEnabled,
                  activeColor: const Color(0xFF2086CB),
                  onChanged: (value) {
                    setState(() => vibrationEnabled = value);
                  },
                ),
              ],
            ),

            const Divider(height: 24, color: Color(0xFFB0C4DE)),

            // Notification Frequency
            const Text(
              'Notification Frequency',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF4A4A4A),
              ),
            ),
            const SizedBox(height: 8),
            _buildRadioOption('Immediate', 'Immediate', 'frequency'),
            _buildRadioOption('Hourly Digest', 'Hourly Digest', 'frequency'),
            _buildRadioOption('Daily Digest', 'Daily Digest', 'frequency'),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleRow(String title, bool value, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, color: Color(0xFF4A4A4A)),
          ),
          CupertinoSwitch(
            value: value,
            activeColor: const Color(0xFF2086CB),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildRadioOption(String title, String value, String group) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Radio(
            value: value,
            groupValue:
                group == 'sound' ? selectedSound : notificationFrequency,
            activeColor: const Color(0xFF2086CB),
            onChanged: (newValue) {
              setState(() {
                if (group == 'sound') {
                  selectedSound = value;
                } else {
                  notificationFrequency = value;
                }
              });
            },
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 16, color: Color(0xFF4A4A4A)),
          ),
        ],
      ),
    );
  }
}
