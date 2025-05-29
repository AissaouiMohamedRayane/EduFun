import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:EduFun/components/ParentSideComponents/Settings/PasswordChangeOverlay.dart';

class Privacy extends StatefulWidget {
  const Privacy({super.key});

  @override
  State<Privacy> createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  // Toggle states
  bool adTrackingEnabled = false;
  bool dataCollectionEnabled = true;
  bool locationTrackingEnabled = true;
  bool childDataProtectionEnabled = true;
  bool ageRestrictionEnabled = true;
  bool contentFilteringEnabled = true;
  bool parentalControlsEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF0288D1)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Privacy & Security',
          style: TextStyle(
            color: Color(0xFF0288D1),
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 8.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Security Status
                _buildSectionTitle('Security Status'),
                _buildSecurityStatusCard(),
                const SizedBox(height: 20),

                // Account Security
                _buildSectionTitle('Account Security'),
                _buildAccountSecurityCard(),
                const SizedBox(height: 20),

                // Privacy Settings
                _buildSectionTitle('Privacy Settings'),
                _buildPrivacySettingsCard(),
                const SizedBox(height: 20),

                // Child Data Protection
                _buildSectionTitle('Child Data Protection'),
                _buildChildDataProtectionCard(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF0288D1),
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildSecurityStatusCard() {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(132, 183, 236, 1),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Security Status',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Protected',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Your account is secure with all protections enabled',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSecurityMetric('Logins', 'Today, 10:45 AM'),
                _buildSecurityMetric('Device', 'iPhone 13 Pro'),
                _buildSecurityMetric('IP', '192.168.1.1'),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSecurityMetric('Threats', 'None'),
                _buildSecurityMetric('Updates', '2 days ago'),
                _buildSecurityMetric('Last scan', 'Today'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityMetric(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF0288D1),
            fontWeight: FontWeight.w800,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildAccountSecurityCard() {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(166, 188, 211, 1),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSettingItem(
              icon: Icons.key,
              iconBackground: const Color(0xFF64B5F6),
              title: 'Password',
              subtitle: 'Last changed 3 months ago',
              hasNavigation: true,
              onTap: () {},
            ),
            const Divider(height: 24),
            _buildSettingItem(
              icon: Icons.security,
              iconBackground: const Color(0xFF81C784),
              title: 'Two-Factor Authentication',
              subtitle: 'Enabled',
              hasToggle: true,
              toggleValue: true,
              onToggleChanged: (value) {},
            ),
            const Divider(height: 24),
            _buildSettingItem(
              icon: Icons.fingerprint,
              iconBackground: const Color(0xFFFFB74D),
              title: 'Biometric Authentication',
              subtitle: 'Face ID, Touch ID',
              hasToggle: true,
              toggleValue: true,
              onToggleChanged: (value) {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrivacySettingsCard() {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(132, 183, 236, 1),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildToggleSetting(
              title: 'Ad Tracking',
              description:
                  'Allow apps to request to track your activity across apps and websites',
              value: adTrackingEnabled,
              onChanged: (value) {
                setState(() {
                  adTrackingEnabled = value;
                });
              },
            ),
            const Divider(height: 24),
            _buildToggleSetting(
              title: 'Data Collection',
              description:
                  'Allow us to collect anonymous usage data to improve our services',
              value: dataCollectionEnabled,
              onChanged: (value) {
                setState(() {
                  dataCollectionEnabled = value;
                });
              },
            ),
            const Divider(height: 24),
            _buildToggleSetting(
              title: 'Location Tracking',
              description: 'Allow apps to use your location data',
              value: locationTrackingEnabled,
              onChanged: (value) {
                setState(() {
                  locationTrackingEnabled = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChildDataProtectionCard() {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(166, 188, 211, 1),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSettingItem(
              icon: Icons.shield,
              iconBackground: const Color(0xFF7986CB),
              title: 'Child Data Protection',
              subtitle: 'Enabled',
              hasToggle: true,
              toggleValue: childDataProtectionEnabled,
              onToggleChanged: (value) {
                setState(() {
                  childDataProtectionEnabled = value;
                });
              },
            ),
            const Divider(height: 24),
            _buildSettingItem(
              icon: Icons.calendar_today,
              iconBackground: const Color(0xFFE57373),
              title: 'Age Restriction',
              subtitle: 'Minimum age: 13',
              hasNavigation: true,
              onTap: () {},
            ),
            const Divider(height: 24),
            _buildSettingItem(
              icon: Icons.filter_list,
              iconBackground: const Color(0xFF4FC3F7),
              title: 'Content Filtering',
              subtitle: 'Moderate',
              hasNavigation: true,
              onTap: () {},
            ),
            const Divider(height: 24),
            _buildSettingItem(
              icon: Icons.admin_panel_settings,
              iconBackground: const Color(0xFFAED581),
              title: 'Parental Controls',
              subtitle: 'Not configured',
              hasToggle: true,
              toggleValue: parentalControlsEnabled,
              onToggleChanged: (value) {
                setState(() {
                  parentalControlsEnabled = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required Color iconBackground,
    required String title,
    required String subtitle,
    bool hasNavigation = false,
    bool hasToggle = false,
    bool toggleValue = false,
    Function()? onTap,
    Function(bool)? onToggleChanged,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconBackground,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
          if (hasNavigation)
            const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
          if (hasToggle)
            CupertinoSwitch(
              value: toggleValue,
              activeColor: const Color(0xFF0288D1),
              onChanged: onToggleChanged,
            ),
        ],
      ),
    );
  }

  Widget _buildToggleSetting({
    required String title,
    required String description,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),
            CupertinoSwitch(
              value: value,
              activeColor: const Color(0xFF0288D1),
              onChanged: onChanged,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ],
    );
  }
}
