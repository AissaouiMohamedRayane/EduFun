import 'package:flutter/material.dart';

class EduFunPremiumScreen extends StatefulWidget {
  const EduFunPremiumScreen({super.key});

  @override
  State<EduFunPremiumScreen> createState() => _EduFunPremiumScreenState();
}

class _EduFunPremiumScreenState extends State<EduFunPremiumScreen> {
  String selectedPlan = 'Monthly';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'EDUFUN Premium',
          style: TextStyle(
            color: Color.fromRGBO(32, 134, 203, 1),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: const Color(0xFF2086CB),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(
                      Icons.workspace_premium,
                      color: Colors.amber,
                      size: 32,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
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
                            "Ruh Sik Hyatek a Sawim",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 24,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Visualize All Our Premium Services',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 30),
            const Text(
              'Choose Your Plan',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Monthly Plan
            _buildPlanCard(
              title: 'Monthly',
              price: '9,995 per month',
              features: const [
                'Unlimited access to premium content',
                'Ad-free experience',
                'Advanced progress tracking',
                'Personalized learning paths',
                'Priority support',
              ],
              isSelected: selectedPlan == 'Monthly',
              onChanged: (value) => setState(() => selectedPlan = 'Monthly'),
            ),

            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 20),

            // Annual Plan
            _buildPlanCard(
              title: 'Annual',
              price: '89.99 per year',
              features: const [
                'All monthly features',
                'Download content for offline use',
                'Exclusive seasonal content',
                'Early access to new features',
              ],
              isSelected: selectedPlan == 'Annual',
              onChanged: (value) => setState(() => selectedPlan = 'Annual'),
            ),

            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 20),
            _buildPlanCard(
              title: "Family Plus",
              price: "14.99",
              features: const [
                "All Annual features",
                "Cross-device Synchronization",
                "Premium Educational Resources",
              ],
              isSelected: selectedPlan == 'Family Plus',
              onChanged:
                  (value) => setState(() => selectedPlan = 'Family Plus'),
            ),
            const SizedBox(height: 40),
            const Divider(),
            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _showSubscriptionOverlay(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2086CB),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Subscribe Now',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            const Divider(),
            const SizedBox(height: 20),
            const Text(
              "Frequently Asked Questions",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(32, 134, 203, 1),
              ),
            ),
            const SizedBox(height: 40),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(54, 136, 222, 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  _buildFAQItem(
                    title: "Can I cancel anytime",
                    subTitle:
                        "Yes, you can cancel your subscription at any time. Your premium access will continue until the end of your current billing period.",
                  ),
                  _buildFAQItem(
                    title: "Will I be charged automatically?",
                    subTitle:
                        "Yes, your subscription will automatically renew at the end of each billing period unless you cancel",
                  ),
                  _buildFAQItem(
                    title: "Can I switch plans later?",
                    subTitle:
                        "Yes, you can upgrade or downgrade your plan at any time. Changes will take effect at the start of your next billing cycle",
                  ),
                  _buildFAQItem(
                    title: "Is there a free trial?",
                    subTitle:
                        "New subscribers get a 7-day free trial to experience all premium features before being charged.",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40), // Extra padding at bottom
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard({
    required String title,
    required String price,
    required List<String> features,
    required bool isSelected,
    required Function(bool?) onChanged,
  }) {
    return Card(
      elevation: 2,
      color: const Color.fromRGBO(132, 183, 236, 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected ? Colors.blue : Colors.grey.shade300,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Radio<bool>(
                  value: true,
                  groupValue: isSelected,
                  onChanged: onChanged,
                  activeColor: Colors.black,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Text(
                price,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ...features
                .map(
                  (feature) => Padding(
                    padding: const EdgeInsets.only(left: 40, bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '• ',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            feature,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQItem({required String title, required String subTitle}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(subTitle, style: const TextStyle(color: Colors.white)),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  void _showSubscriptionOverlay(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const Text(
                'Complete Subscription',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2086CB),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Enter your payment details to subscribe\nto EDUFUN Premium.',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 20),
              // ... rest of your bottom sheet content
            ],
          ),
        );
      },
    );
  }
}
