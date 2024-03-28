import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http; // Import HTTP package
import 'dart:convert'; // Import convert for JSON decoding

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Events'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'UPCOMING'),
              Tab(text: 'PAST EVENTS'),
            ],
            indicatorColor: Colors.black12,
            indicatorWeight: 4,
            labelColor: Colors.black87,
            unselectedLabelColor: Colors.grey,
          ),
        ),
        body: TabBarView(
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
  final List<dynamic> eventData;

  const EventList({super.key, required this.isUpcoming});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: eventData.length,
      itemBuilder: (context, index) {
        final event = eventData[index];
        return EventCard(
          eventName: event['event_name'],
          eventDate: DateTime.parse(event['date_time']),
          eventLocation: event['location'],
          eventImagePath: 'assets/images/event_img.png',
          eventCategory: event['cat_name'],
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

  const EventCard({
    Key? key,
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
        onTap: () {
          // Navigate to details page when card is tapped
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EventDetailsPage(
                eventName: eventName,
                eventDate: eventDate,
                eventLocation: eventLocation,
                eventCategory: eventCategory,
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              child: Image.asset(
                eventImagePath,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    eventName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    eventLocation,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Date: ${DateFormat('dd MMMM yyyy').format(eventDate)}',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
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

