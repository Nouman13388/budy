import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

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
                    // Navigate to a new screen for editing profile
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfileScreen(
                          currentName: name,
                          currentEmail: email,
                          onSave: (newName, newEmail) {
                            setState(() {
                              name = newName;
                              email = newEmail;
                            });
                          },
                        ),
                      ),
                    );
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
                // Navigate to a separate screen for changing interests
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeInterestsScreen(
                      currentInterests: interests,
                      onSelectInterests: (selected) {
                        setState(() {
                          selectedInterests = selected;
                        });
                      },
                    ),
                  ),
                );
              },
              child: const Text('Change Interests'),
            ),
            const SizedBox(height: 16),
            FutureBuilder<UserData>(
              future: fetchUserData(), // Function to fetch user data
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final userData = snapshot.data!;
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

// Screen for editing user profile
class EditProfileScreen extends StatelessWidget {
  final String currentName;
  final String currentEmail;
  final Function(String, String) onSave;

  const EditProfileScreen({
    required this.currentName,
    required this.currentEmail,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    String newName = currentName;
    String newEmail = currentEmail;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name'),
            TextField(
              onChanged: (value) => newName = value,
              decoration: InputDecoration(
                hintText: currentName,
              ),
            ),
            const SizedBox(height: 16),
            Text('Email'),
            TextField(
              onChanged: (value) => newEmail = value,
              decoration: InputDecoration(
                hintText: currentEmail,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Save changes and pop the screen
                onSave(newName, newEmail);
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

// Screen for changing interests
class ChangeInterestsScreen extends StatelessWidget {
  final List<String> currentInterests;
  final Function(List<int>) onSelectInterests;

  const ChangeInterestsScreen({
    required this.currentInterests,
    required this.onSelectInterests,
  });

  @override
  Widget build(BuildContext context) {
    final List<int> selectedIndexes = [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Interests'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Select Interests'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: currentInterests.asMap().entries.map((entry) {
                final index = entry.key;
                final interest = entry.value;
                return GestureDetector(
                  onTap: () {
                    if (selectedIndexes.contains(index)) {
                      selectedIndexes.remove(index);
                    } else {
                      selectedIndexes.add(index);
                    }
                  },
                  child: Chip(
                    label: Text(interest),
                    backgroundColor: selectedIndexes.contains(index)
                        ? Colors.blue
                        : Colors.grey[300],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Return selected indexes to the previous screen
                onSelectInterests(selectedIndexes);
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
