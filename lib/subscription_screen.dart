import 'package:flutter/material.dart';

class SubscriptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subscription Packages'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SubscriptionPackage(
              packageName: 'Basic',
              price: '\$10/month',
              onSelect: () {
                // Navigate to payment method selection screen with package details
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PaymentMethodSelectionScreen(
                      packageName: 'Basic',
                      price: '\$10/month',
                    ),
                  ),
                );
              },
            ),
            SubscriptionPackage(
              packageName: 'Standard',
              price: '\$20/month',
              onSelect: () {
                // Navigate to payment method selection screen with package details
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PaymentMethodSelectionScreen(
                      packageName: 'Standard',
                      price: '\$20/month',
                    ),
                  ),
                );
              },
            ),
            SubscriptionPackage(
              packageName: 'Premium',
              price: '\$30/month',
              onSelect: () {
                // Navigate to payment method selection screen with package details
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PaymentMethodSelectionScreen(
                      packageName: 'Premium',
                      price: '\$30/month',
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SubscriptionPackage extends StatefulWidget {
  final String packageName;
  final String price;
  final VoidCallback onSelect;

  const SubscriptionPackage({
    required this.packageName,
    required this.price,
    required this.onSelect,
  });

  @override
  _SubscriptionPackageState createState() => _SubscriptionPackageState();
}

class _SubscriptionPackageState extends State<SubscriptionPackage> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(_isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down),
                    const SizedBox(width: 10),
                    Text(
                      widget.packageName,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (_isExpanded) ...[
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.price,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Feature 1, Feature 2, Feature 3',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: widget.onSelect,
            child: const Text('Proceed'),
          ),
        ],
      ],
    );
  }
}

class PaymentMethodSelectionScreen extends StatelessWidget {
  final String packageName;
  final String price;

  const PaymentMethodSelectionScreen({
    required this.packageName,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Payment Method'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Selected Package: $packageName',
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              'Price: $price',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to payment page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentScreen(
                      packageName: packageName,
                      price: price,
                    ),
                  ),
                );
              },
              child: const Text('Continue to Payment'),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentScreen extends StatelessWidget {
  final String packageName;
  final String price;

  const PaymentScreen({
    required this.packageName,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Selected Package: $packageName',
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              'Price: $price',
              style: const TextStyle(fontSize: 18),
            ),
            // Add payment method selection UI here
          ],
        ),
      ),
    );
  }
}
