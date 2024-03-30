import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              const Text('Events'),
              IconButton(
                onPressed: () {
                  // Display form to add details
                  _showAddEventForm(context);
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
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
        body: const TabBarView(
          children: [
            EventList(isUpcoming: true),
            EventList(isUpcoming: false),
          ],
        ),
      ),
    );
  }

  void _showAddEventForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Event'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Event Name'),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Event Date'),
                ),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Event Location'),
                ),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Event Category'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Save event details
                _saveEventDetails(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _saveEventDetails(BuildContext context) async {
    // Assuming you have variables for event details like eventName, eventDate, eventLocation, etc.
    String eventName = "Event Name";
    DateTime eventDate = DateTime.now();
    String eventLocation = "Event Location";

    try {
      // Get instance of SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Serialize event details into a string
      String eventDetails =
          '$eventName;$eventDate;$eventLocation'; // You can add more details here

      // Get the existing saved event details or create an empty list
      List<String> savedEvents = prefs.getStringList('savedEvents') ?? [];

      // Add the new event details to the list
      savedEvents.add(eventDetails);

      // Save the updated list back to SharedPreferences
      await prefs.setStringList('savedEvents', savedEvents);

      // Display a confirmation dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Save Event Details'),
            content: Text('Event details saved successfully.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  Navigator.of(context)
                      .pop(); // Navigate back to the previous screen
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (error) {
      print('Error saving event details: $error');
      // Handle error if necessary
    }
  }
}

class EventList extends StatelessWidget {
  final bool isUpcoming;

  const EventList({Key? key, required this.isUpcoming}) : super(key: key);

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
              'assets/images/event_img.png', // Replace with actual image path
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
    Key? key,
    required this.eventName,
    required this.eventDate,
    required this.eventLocation,
    required this.eventImagePath,
    required this.eventCategory,
    required this.isUpcoming,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isBookmarked = false; // Change this to the actual bookmark status
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: () {
          // Handle card tap
          if (kDebugMode) {
            print('Card tapped');
          }
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
                eventImagePath, // Replace with actual image path
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Date: ${DateFormat('dd MMMM yyyy').format(eventDate)}',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Handle details button press
                          if (kDebugMode) {
                            print('Details button pressed');
                          }
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
                      IconButton(
                        icon: Icon(
                          Icons.bookmark,
                          color: isBookmarked ? Colors.blue : Colors.grey,
                        ),
                        onPressed: () {
                          // Check if the event is already bookmarked
                          if (isBookmarked) {
                            // Event is already bookmarked, show a message or perform another action
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Event is already bookmarked!'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          } else {
                            // Event is not bookmarked, save it and update the bookmark icon
                            _saveEvent(context,
                                '$eventName;${DateFormat('dd MMMM yyyy').format(eventDate)};$eventLocation;$eventCategory');
                            // Update the bookmark status to true
                            isBookmarked = true;
                          }
                        },
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

  void _saveEvent(BuildContext context, String eventDetails) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> savedEvents =
        prefs.getStringList('savedEvents') ?? <String>[];
    savedEvents.add(eventDetails);
    await prefs.setStringList('savedEvents', savedEvents);
  }
}
