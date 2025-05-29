import 'package:flutter/material.dart';
import 'package:EduFun/components/ParentSideComponents/HeadingandDushboard.dart';
import 'package:EduFun/components/ParentSideComponents/BottomNavBar.dart';
import 'package:EduFun/components/ParentSideComponents/screens/familycontrole/EduFunPremiumScreen.dart';
import 'package:EduFun/services/models/store.dart';
import '../../../services/models/users.dart';
import 'package:provider/provider.dart';

class RewardStore extends StatefulWidget {
  final Child? child;

  RewardStore({super.key, this.child});

  @override
  State<RewardStore> createState() => _RewardStoreState();
}

class _RewardStoreState extends State<RewardStore> {
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      context.read<StoreProvider>().initializeProducts();
      _isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final storeProvider = Provider.of<StoreProvider>(context);

    return storeProvider.isLoading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            backgroundColor: Color.fromRGBO(223, 246, 242, 1),
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          const SizedBox(height: 50),
                          const Heading(),
                          const SizedBox(height: 30),
                          _buildTitle(
                              "Available Rewards for ${widget.child!.firstname}"),
                          const SizedBox(height: 20),
                          _buildCurrencyGrid(storeProvider),
                          const SizedBox(
                              height: 30), // Space before back button
                        ],
                      ),
                    ),
                  ),
                ),

                // Back button placed outside the scrollable area
              ],
            ),
          );
  }

  Widget _buildTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFF2086CB),
      ),
    );
  }

  Widget _buildCurrencyGrid(StoreProvider storeProvider) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.1,
      ),
      itemCount: storeProvider.products.length,
      itemBuilder: (context, index) {
        final product = storeProvider.products[index];
        return _buildCurrencyItem(product);
      },
    );
  }

  Widget _buildCurrencyItem(Product product) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                "${product.price} DA",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                product.name,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (product.descreption != '') {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Center(
                        child: Dialog(
                          alignment: Alignment.topCenter,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  "Description",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(product.descreption),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: const Text("Go Back"),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        child: const Text("Buy"),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2086CB),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text("Detail"),
            ),
          )
        ],
      ),
    );
  }
}
