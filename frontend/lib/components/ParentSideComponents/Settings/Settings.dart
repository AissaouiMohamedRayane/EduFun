import 'package:flutter/material.dart';
import 'package:EduFun/components/ParentSideComponents/Settings/EditProfile.dart';
import 'package:EduFun/components/ParentSideComponents/HeadingandDushboard.dart';
import 'package:EduFun/components/ParentSideComponents/HelpAndSupportScreen.dart';
import 'package:EduFun/components/ParentSideComponents/Settings/NotificationBar.dart';
import 'package:EduFun/components/ParentSideComponents/Settings/PasswordChangeOverlay.dart';
import 'package:EduFun/components/ParentSideComponents/Settings/Privacy/Privacy.dart';
import 'package:EduFun/components/ParentSideComponents/screens/auth/registration/Mychoice.dart';
import 'package:EduFun/components/ParentSideComponents/screens/familycontrole/EduFunPremiumScreen.dart';
import 'package:EduFun/services/models/users.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  final Child child;
  Settings({super.key, required this.child});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final parentProvider = Provider.of<ParentProvider>(context);
    return Container(
      decoration: const BoxDecoration(color: Color.fromRGBO(223, 246, 242, 1)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              const Heading(),
              const SizedBox(height: 30),
              _buildSettingsSection("Account", [
                _buildSettingsItem(
                  "Edit Profile Informations",
                  Icons.person,
                  onTap: () => _navigateToEditProfile(context, parentProvider),
                ),
                _buildSettingsItem(
                  "Change Password",
                  Icons.lock,
                  onTap: () => _navigateToChangePassword(context),
                ),
                _buildSettingsItem(
                  "Privacy Settings",
                  Icons.privacy_tip,
                  onTap: () => _navigateToPrivacySettings(context),
                ),
              ]),
              const SizedBox(height: 20),
              _buildSettingsSection("Preferences", [
                _buildSettingsItem(
                  "Notifications",
                  Icons.notifications,
                  onTap: () => _navigateToNotifications(context),
                ),
                _buildSettingsItem(
                  "Theme",
                  Icons.color_lens,
                  onTap: () => _navigateToThemeSettings(context),
                ),
                _buildSettingsItem(
                  "Language",
                  Icons.language,
                  onTap: () => _navigateToLanguageSettings(context),
                ),
              ]),
              const SizedBox(height: 20),
              _buildSettingsSection("About", [
                _buildSettingsItem(
                  "Help & Support",
                  Icons.help,
                  onTap: () => _navigateToHelpSupport(context),
                ),
                _buildSettingsItem(
                  "Terms of Service",
                  Icons.description,
                  onTap: () => _navigateToTermsOfService(context),
                ),
                _buildSettingsItem(
                  "Log Out",
                  Icons.logout,
                  isDestructive: true,
                  onTap: () => _logout(context, parentProvider),
                ),
              ]),
              const SizedBox(height: 30),
              Card(
                color: const Color(0xFF2086CB),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.workspace_premium,
                            color: Colors.amber,
                            size: 32,
                          ),
                          const SizedBox(width: 30),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "EDU FUN PREMIUM",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "For a better experience",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const EduFunPremiumScreen(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 24,
                        ),
                        splashRadius: 20,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // Navigation methods for each setting item
  void _navigateToEditProfile(
      BuildContext context, ParentProvider parentProvider) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(
        builder: (context) => EditProfile(
              parentProvider: parentProvider,
            )));
  }

  void _navigateToChangePassword(BuildContext context) {
    print("Navigate to Change Password");
    showDialog(context: context, builder: (context) => PasswordChangeOverlay());
  }

  void _navigateToPrivacySettings(BuildContext context) {
    print("Navigate to Privacy Settings");
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => Privacy()));
  }

  void _navigateToNotifications(BuildContext context) {
    print("Navigate to Notifications Settings");
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => NotificationBar()));
  }

  void _navigateToThemeSettings(BuildContext context) {
    print("Navigate to Theme Settings");
  }

  void _navigateToLanguageSettings(BuildContext context) {
    // Implement navigation to language settings screen
    print("Navigate to Language Settings");
  }

  void _navigateToHelpSupport(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => HelpAndSupportScreen()));
  }

  void _navigateToTermsOfService(BuildContext context) {
    // Implement navigation to terms of service screen
    print("Navigate to Terms of Service");
  }

  void _logout(BuildContext context, ParentProvider parentProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Log Out"),
        content: const Text("Are you sure you want to log out?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              // Perform logout
              parentProvider.logoutParent();
              Navigator.pushReplacementNamed(context, '/');

              print("User logged out");
            },
            child: const Text(
              "Log Out",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2086CB),
            ),
          ),
        ),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(children: items),
        ),
      ],
    );
  }

  Widget _buildSettingsItem(
    String title,
    IconData icon, {
    bool isDestructive = false,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive ? Colors.red : const Color(0xFF2086CB),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: isDestructive ? Colors.red : Colors.black87,
        ),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
