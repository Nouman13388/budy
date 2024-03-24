import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = 'John Doe'; // Replace with actual user name
  String email = 'johndoe@example.com'; // Replace with actual user email
  List<String> interests = [
    'Interest 1',
    'Interest 2',
    'Interest 3',
    'Interest 4',
  ];
  List<int> selectedInterests = []; // List to store selected interest indexes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/images/budy_logo.png'),
              backgroundColor: Colors.transparent,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle edit profile button tap
                    // Navigate to a new screen (or modal) for editing
                    // Update name and email variables in this state
                  },
                  child: const Text('Edit Profile'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    // Handle manage button tap (optional functionality)
                  },
                  child: const Text('Manage'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              runSpacing: 8,
              children: interests.asMap().entries.map((entry) {
                final index = entry.key;
                final interest = entry.value;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (selectedInterests.contains(index)) {
                        selectedInterests.remove(index);
                      } else {
                        selectedInterests.add(index);
                      }
                    });
                  },
                  child: Chip(
                    label: Text(interest),
                    backgroundColor: selectedInterests.contains(index)
                        ? Colors.blue
                        : Colors.grey[300],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle change interests button tap
                // This button currently doesn't have functionality
                // You could navigate to a separate screen for adding/removing
              },
              child: const Text('Change Interests'),
            ),
            const SizedBox(height: 16),
            FutureBuilder(
              future:
                  fetchUserData(), // Replace with function to fetch user data
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final userData = snapshot.data
                      as UserData; // Replace UserData with your data model
                  return Column(
                    children: [
                      Text('Name: ${userData.name}'),
                      Text('Email: ${userData.email}'),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  // Function to fetch user data from cloud storage or database
  Future<UserData> fetchUserData() async {
    // Replace this with actual implementation to fetch user data
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
    return UserData(name: 'John Doe', email: 'johndoe@example.com');
  }
}

// Example data model representing user data
class UserData {
  final String name;
  final String email;

  UserData({required this.name, required this.email});
}
