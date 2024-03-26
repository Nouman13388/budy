import 'package:flutter/material.dart';
import 'package:budy/screens/signin_screen.dart'; // Import the SignInScreen

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  final PageController controller = PageController();

  @override
  void initState() {
    controller.addListener(() {
      setState(() {
        currentIndex = controller.page!.round();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            if (currentIndex == items.length - 1) {
              // If it's the last page, navigate to the SignInScreen
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SignInScreen()),
              );
            }
          },
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: controller,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Image.asset(
                          'assets/images/onboard1.png', // Use your image asset
                          height: 300,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 15),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: Colors.blue, // Customize background color
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  items[index].title,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white, // Customize text color
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24, // Customize font size
                                  ),
                                ),
                                SizedBox(height: 30),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 38.0),
                                  child: Text(
                                    items[index].subtitle,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color:
                                          Colors.white, // Customize text color
                                      fontSize: 16, // Customize font size
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Container(
                color: Colors.blue, // Customize container color
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 35,
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle SKIP button press
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInScreen()),
                          );
                        },
                        child: Text(
                          "SKIP",
                          style: TextStyle(fontSize: 16), // Customize font size
                        ),
                      ),
                    ),
                    Row(
                      children: List.generate(
                        items.length,
                        (index) => buildDotContainer(index),
                      ),
                    ),
                    SizedBox(
                      height: 35,
                      child: ElevatedButton(
                        onPressed: () {
                          if (currentIndex == items.length - 1) {
                            // Handle GET STARTED button press
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignInScreen()),
                            );
                          } else {
                            controller.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          }
                        },
                        child: Text(
                          currentIndex == items.length - 1
                              ? "GET STARTED"
                              : "NEXT",
                          style: TextStyle(fontSize: 16), // Customize font size
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildDotContainer(int index) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      height: 10,
      width: currentIndex == index ? 15 : 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentIndex == index ? Colors.white : Colors.pink.shade50,
      ),
    );
  }
}

class OnboardingItem {
  final String upperImage;
  final String title;
  final String subtitle;

  OnboardingItem({
    required this.upperImage,
    required this.title,
    required this.subtitle,
  });
}

final List<OnboardingItem> items = [
  OnboardingItem(
    upperImage: 'assets/images/image1.png',
    title: 'Title 1',
    subtitle: 'Subtitle 1',
  ),
  OnboardingItem(
    upperImage: 'assets/images/image2.png',
    title: 'Title 2',
    subtitle: 'Subtitle 2',
  ),
  OnboardingItem(
    upperImage: 'assets/images/image3.png',
    title: 'Title 3',
    subtitle: 'Subtitle 3',
  ),
];
