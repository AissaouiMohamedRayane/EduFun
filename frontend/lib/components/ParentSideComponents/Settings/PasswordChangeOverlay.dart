// lib/widgets/password_change_overlay.dart

import 'package:flutter/material.dart';

class PasswordChangeOverlay extends StatefulWidget {
  @override
  _PasswordChangeOverlayState createState() => _PasswordChangeOverlayState();
}

class _PasswordChangeOverlayState extends State<PasswordChangeOverlay> {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();

  // Focus nodes for each text field
  final _currentPasswordFocus = FocusNode();
  final _newPasswordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();

  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();

    // Add listeners to focus nodes to scroll to the focused field
    _currentPasswordFocus.addListener(_handleFocusChange);
    _newPasswordFocus.addListener(_handleFocusChange);
    _confirmPasswordFocus.addListener(_handleFocusChange);

    // Add a post-frame callback to ensure the widget is built before scrolling
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Initial delay to let the dialog animate in
      Future.delayed(Duration(milliseconds: 300), () {
        _currentPasswordFocus.requestFocus();
      });
    });
  }

  void _handleFocusChange() {
    // Determine which focus node is active
    FocusNode? focusNode;
    double scrollOffset = 0;

    if (_currentPasswordFocus.hasFocus) {
      focusNode = _currentPasswordFocus;
      scrollOffset = 0;
    } else if (_newPasswordFocus.hasFocus) {
      focusNode = _newPasswordFocus;
      scrollOffset = 80; // Approximate offset for the second field
    } else if (_confirmPasswordFocus.hasFocus) {
      focusNode = _confirmPasswordFocus;
      scrollOffset = 160; // Approximate offset for the third field
    }

    if (focusNode != null && _scrollController.hasClients) {
      // Animate to the position with a slight delay to ensure keyboard is visible
      Future.delayed(Duration(milliseconds: 100), () {
        _scrollController.animateTo(
          scrollOffset,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  @override
  void dispose() {
    // Dispose all controllers and focus nodes
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _scrollController.dispose();

    _currentPasswordFocus.removeListener(_handleFocusChange);
    _newPasswordFocus.removeListener(_handleFocusChange);
    _confirmPasswordFocus.removeListener(_handleFocusChange);

    _currentPasswordFocus.dispose();
    _newPasswordFocus.dispose();
    _confirmPasswordFocus.dispose();

    super.dispose();
  }

  bool _validatePassword(String password) {
    bool hasMinLength = password.length >= 8;
    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    bool hasNumber = password.contains(RegExp(r'[0-9]'));
    bool hasSpecialChar = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    return hasMinLength && hasUppercase && hasNumber && hasSpecialChar;
  }

  void _updatePassword() {
    if (_formKey.currentState!.validate()) {
      print('Password updated successfully');
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final screenHeight = MediaQuery.of(context).size.height;

    // Calculate a dynamic max height based on screen size and keyboard visibility
    final maxHeight =
        bottomInset > 0
            ? screenHeight *
                0.5 // When keyboard is visible, make dialog smaller
            : screenHeight *
                0.7; // When keyboard is hidden, allow larger dialog

    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 16),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        constraints: BoxConstraints(maxHeight: maxHeight),
        decoration: BoxDecoration(
          color: Color(0xFF64B5F6),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header with title and close button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Change Password',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Icon(Icons.close, color: Colors.white),
                  ),
                ],
              ),
            ),

            // Instruction text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Enter your current password and a new password to update your credentials.',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),

            // Scrollable content with smooth physics
            Expanded(
              child: GestureDetector(
                // Close keyboard when tapping outside of text fields
                onTap: () => FocusScope.of(context).unfocus(),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  padding: EdgeInsets.only(
                    bottom: bottomInset > 0 ? bottomInset + 20 : 0,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Current Password
                          Text(
                            'Current Password',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 4),
                          TextFormField(
                            controller: _currentPasswordController,
                            focusNode: _currentPasswordFocus,
                            obscureText: _obscureCurrentPassword,
                            textInputAction:
                                TextInputAction
                                    .next, // Move to next field on submit
                            onFieldSubmitted: (_) {
                              _newPasswordFocus
                                  .requestFocus(); // Move to next field
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide.none,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureCurrentPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureCurrentPassword =
                                        !_obscureCurrentPassword;
                                  });
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your current password';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16),

                          // New Password
                          Text(
                            'New Password',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 4),
                          TextFormField(
                            controller: _newPasswordController,
                            focusNode: _newPasswordFocus,
                            obscureText: _obscureNewPassword,
                            textInputAction:
                                TextInputAction
                                    .next, // Move to next field on submit
                            onFieldSubmitted: (_) {
                              _confirmPasswordFocus
                                  .requestFocus(); // Move to next field
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide.none,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureNewPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureNewPassword = !_obscureNewPassword;
                                  });
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a new password';
                              }
                              if (!_validatePassword(value)) {
                                return 'Password does not meet requirements';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16),

                          // Confirm New Password
                          Text(
                            'Confirm New Password',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 4),
                          TextFormField(
                            controller: _confirmPasswordController,
                            focusNode: _confirmPasswordFocus,
                            obscureText: _obscureConfirmPassword,
                            textInputAction:
                                TextInputAction.done, // Complete form on submit
                            onFieldSubmitted: (_) {
                              _updatePassword(); // Submit form when done
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide.none,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureConfirmPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureConfirmPassword =
                                        !_obscureConfirmPassword;
                                  });
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please confirm your new password';
                              }
                              if (value != _newPasswordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16),

                          // Password Requirements
                          Text(
                            'Password Requirements:',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          SizedBox(height: 4),
                          _buildRequirementItem('At least 8 characters'),
                          _buildRequirementItem('Contains uppercase letters'),
                          _buildRequirementItem('Contains numbers'),
                          _buildRequirementItem('Contains special characters'),
                          SizedBox(height: 16),

                          // Buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                    color: Color(0xFF64B5F6),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                ),
                              ),
                              SizedBox(width: 8),
                              TextButton(
                                onPressed: _updatePassword,
                                child: Text(
                                  'Update Password',
                                  style: TextStyle(
                                    color: Color(0xFF64B5F6),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRequirementItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: TextStyle(color: Colors.white, fontSize: 12)),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
