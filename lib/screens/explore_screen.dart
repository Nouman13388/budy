import 'package:flutter/material.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: const Text(
            'Upcoming Events:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    title: const Text('Community Music & Entertainment'),
                    subtitle: const Text('No upcoming events available'),
                    trailing: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        // Handle add button tap
                      },
                    ),
                  ),
                  const Divider(),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
