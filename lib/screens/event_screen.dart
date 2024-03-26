import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Events'),
          bottom: TabBar(
            tabs: const [
              Tab(text: 'UPCOMING'),
              Tab(text: 'PAST EVENTS'),
            ],
            indicatorColor: Colors.black12,
            indicatorWeight: 4,
            labelColor: Colors.black87,
            unselectedLabelColor: Colors.grey[400],
          ),
        ),
        body: const TabBarView(
          children: [
            EventList(isUpcoming: true),
            EventList(isUpcoming: false),
          ],
        ),
      ),
    );
  }
}

class EventList extends StatelessWidget {
  final bool isUpcoming;

  const EventList({super.key, required this.isUpcoming});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: isUpcoming ? 5 : 3,
      itemBuilder: (context, index) {
        return EventCard(
          eventName: isUpcoming
              ? 'Upcoming Event ${index + 1}'
              : 'Past Event ${index + 1}',
          eventDate: isUpcoming
              ? DateTime.now().add(Duration(days: index + 1))
              : DateTime.now().subtract(Duration(days: index + 1)),
          eventLocation: 'Event Location',
          eventImagePath:
              'assets/event_image_path', // Replace with actual image path
          eventCategory: 'Category',
          isUpcoming: isUpcoming,
        );
      },
    );
  }
}

class EventCard extends StatelessWidget {
  final String eventName;
  final DateTime eventDate;
  final String eventLocation;
  final String eventImagePath;
  final String eventCategory;
  final bool isUpcoming;

  const EventCard({
    super.key,
    required this.eventName,
    required this.eventDate,
    required this.eventLocation,
    required this.eventImagePath,
    required this.eventCategory,
    required this.isUpcoming,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              child: Image.asset(
                'assets/images/event_img.png', // Replace with actual image path
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'eventName',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'eventLocation',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isUpcoming
                            ? 'Date: ${DateFormat('dd MMMM yyyy').format(eventDate)}'
                            : 'Date: ${DateFormat('dd MMMM yyyy').format(eventDate)}',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Handle details button press
                        },
                        child: const Text(
                          'Details',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text(
                        'Category: ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.blue[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          eventCategory,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
