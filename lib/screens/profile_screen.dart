import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
  }

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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfileScreen(
                          currentName: currentUser?.displayName ?? '',
                          currentEmail: currentUser?.email ?? '',
                          onSave: (newName, newEmail) {
                            setState(() {
                              currentUser?.updateDisplayName(newName);
                              currentUser?.updateEmail(newEmail);
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
            ElevatedButton(
              onPressed: () {
                // Navigate to a separate screen for changing interests
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeInterestsScreen(
                      onSelectInterests: (selected) {
                        setState(() {
                          // Update selected interests
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
              future: fetchUserData(),
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

  Future<UserData> fetchUserData() async {
    // Fetch user data from Firebase or any other source
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
    return UserData(
      name: currentUser?.displayName ??
          FirebaseAuth.instance.currentUser?.displayName ??
          'John Doe',
      email: currentUser?.email ?? 'johndoe@example.com',
    );
  }
}

class UserData {
  final String name;
  final String email;

  UserData({required this.name, required this.email});
}

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

class ChangeInterestsScreen extends StatelessWidget {
  final Function(List<int>) onSelectInterests;

  const ChangeInterestsScreen({
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
            const Text('SelectInterests'),
            const SizedBox(height: 16),
// Display a list of selectable interests
// For simplicity, I'll just use hardcoded interests here
            Wrap(
              spacing: 8,
              children: List.generate(
                4,
                (index) => GestureDetector(
                  onTap: () {
                    if (selectedIndexes.contains(index)) {
                      selectedIndexes.remove(index);
                    } else {
                      selectedIndexes.add(index);
                    }
                  },
                  child: Chip(
                    label: Text('Interest ${index + 1}'),
                    backgroundColor: selectedIndexes.contains(index)
                        ? Colors.blue
                        : Colors.grey[300],
                  ),
                ),
              ),
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
