import 'package:flutter/material.dart';

class HelpAndSupportScreen extends StatefulWidget {
  const HelpAndSupportScreen({super.key});

  @override
  State<HelpAndSupportScreen> createState() => _HelpAndSupportScreenState();
}

class _HelpAndSupportScreenState extends State<HelpAndSupportScreen> {
  final TextEditingController _messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Help & Support',
          style: TextStyle(
            color: Color.fromRGBO(32, 134, 203, 1),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with version info
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Last updated: March 20, 2025',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(32, 134, 203, 1),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromRGBO(61, 184, 110, 1),
                    ),
                    padding: const EdgeInsets.all(7),
                    child: const Text(
                      'Version 3.2',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Contact Support Section
              const Text(
                'Contact Support',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(32, 134, 203, 1),
                ),
              ),
              const SizedBox(height: 16),

              // Support Form Container
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(132, 183, 236, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(text: 'This message will be sent to '),
                          TextSpan(
                            text: 'emd@edufun.net',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Your Message Section
                    const Text(
                      'Your Message',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _messageController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: 'Describe your issue or question',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please describe your issue';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Attachment Options
                    Row(
                      children: [
                        _buildAttachmentOption(Icons.attach_file, 'Attach'),
                        const SizedBox(width: 16),
                        _buildAttachmentOption(Icons.camera_alt, 'Screenshot'),
                      ],
                    ),
                    const SizedBox(height: 30),
                    const Divider(height: 1),
                    const SizedBox(height: 30),

                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Support ticket submitted successfully',
                                ),
                              ),
                            );
                            _messageController.clear();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: const Color(0xFF2086CB),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Submit Support Ticket',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Privacy Policy Section
              const Text(
                'Privacy Policy',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(32, 134, 203, 1),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color.fromRGBO(32, 134, 203, 1),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section 1: Information We Collect
                    const Text(
                      '1. Information We Collect',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(32, 134, 203, 1),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'We collect information that you provide directly to us, such as when you create an account, set up profiles for your children, or contact customer support.',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    const SizedBox(height: 16),

                    const Text(
                      'Information you provide:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildBulletPoint(
                      'Personal information (name, email address, phone number)',
                    ),
                    _buildBulletPoint(
                      'Child information (name, age, learning preferences)',
                    ),
                    _buildBulletPoint('Payment information'),
                    _buildBulletPoint('Content you upload or create'),

                    const SizedBox(height: 12),
                    const Text(
                      'Information collected automatically:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildBulletPoint('Usage data (features used, time spent)'),
                    _buildBulletPoint(
                      'Device information (device type, operating system)',
                    ),
                    _buildBulletPoint('Log data (IP address, browser type)'),
                    _buildBulletPoint('Learning progress and achievements'),

                    const Divider(height: 40),

                    // Section 2: How We Use Your Information
                    const Text(
                      '2. How We Use Your Information',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(32, 134, 203, 1),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'We use the information we collect to provide, maintain, and improve our services, as well as to personalize your experience.',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    const SizedBox(height: 16),

                    const Text(
                      'Specific uses include:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildBulletPoint('Providing and maintaining our services'),
                    _buildBulletPoint(
                      'Processing transactions and sending related information',
                    ),
                    _buildBulletPoint(
                      'Personalizing learning experiences for children',
                    ),
                    _buildBulletPoint(
                      'Monitoring and analyzing usage patterns and trends',
                    ),
                    _buildBulletPoint(
                      'Communicating with you about products, services, and updates',
                    ),
                    _buildBulletPoint(
                      'Detecting and preventing fraudulent activity',
                    ),

                    const Divider(height: 40),

                    // Section 3: Data Security
                    const Text(
                      '3. Data Security',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(32, 134, 203, 1),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'We implement appropriate technical and organizational measures to protect your personal information against unauthorized access, alteration, disclosure, or destruction.',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    const SizedBox(height: 16),

                    const Text(
                      'Security measures include:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildBulletPoint('Encryption of sensitive data'),
                    _buildBulletPoint('Regular security audits'),
                    _buildBulletPoint('Access controls and authentication'),
                    _buildBulletPoint('Secure data storage practices'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAttachmentOption(IconData icon, String label) {
    return Expanded(
      child: OutlinedButton.icon(
        icon: Icon(icon, color: Colors.white),
        label: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12),
          backgroundColor: const Color.fromRGBO(111, 148, 188, 1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () {
          // Handle attachment action
        },
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(color: Colors.black87)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
