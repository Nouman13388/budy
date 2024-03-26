import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Add logic to handle settings changes here
            // For example, you can show a dialog to confirm changes
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Settings Updated'),
                content: const Text('Your settings have been updated.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          },
          child: const Text('Update Settings'),
        ),
      ),
    );
  }
}
