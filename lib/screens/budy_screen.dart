import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class BudyScreen extends StatefulWidget {
  const BudyScreen({super.key});

  @override
  _BudyScreenState createState() => _BudyScreenState();
}

class _BudyScreenState extends State<BudyScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "Welcome to Budy",
          body: "Connect with your buddies and explore events together!",
          image: Image.asset(
              'assets/images/budy_logo.png'), // Replace with your image path
          decoration: const PageDecoration(
            pageColor: Colors.white,
            bodyTextStyle: TextStyle(fontSize: 18),
          ),
        ),
        PageViewModel(
          title: "Discover Events",
          body: "Find exciting events happening near you.",
          image: Image.asset(
              'assets/images/budy_logo.png'), // Replace with your image path
          decoration: const PageDecoration(
            pageColor: Colors.white,
            bodyTextStyle: TextStyle(fontSize: 18),
          ),
        ),
        PageViewModel(
          title: "Save Favorites",
          body: "Save your favorite events for easy access.",
          image: Image.asset(
              'assets/images/budy_logo.png'), // Replace with your image path
          decoration: const PageDecoration(
            pageColor: Colors.white,
            bodyTextStyle: TextStyle(fontSize: 18),
          ),
        ),
      ],
      onDone: () {
        // Navigate to the next screen or perform any action on done
      },
      done: const Text("Done"),
      showSkipButton: true,
      skip: const Text("Skip"),
      next: const Text("Next"),
    );
  }
}
