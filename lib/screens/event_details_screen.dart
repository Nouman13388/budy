//Event Detailed Screen
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'saved_screen.dart';

class EventDetailsPage extends StatefulWidget {
  final String eventName;
  final DateTime eventDate;
  final String eventLocation;
  final String eventCategory;

  const EventDetailsPage({
    super.key,
    required this.eventName,
    required this.eventDate,
    required this.eventLocation,
    required this.eventCategory,
  });

  @override
  _EventDetailsPageState createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  late SharedPreferences _prefs;
  bool isBookmarked = false;
  bool isBookmarkYellow = false; // Boolean variable to track the bookmark color

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      isBookmarked = _prefs.getBool(widget.eventName) ?? false;
      isBookmarkYellow =
          isBookmarked; // Initialize isBookmarkYellow based on isBookmarked
    });
  }

  Future<void> _toggleBookmark() async {
    setState(() {
      isBookmarked = !isBookmarked;
      isBookmarkYellow =
          isBookmarked; // Update isBookmarkYellow based on isBookmarked
    });

    if (isBookmarked) {
      // If bookmarked, save event details to saved events list
      List<Map<String, dynamic>> savedEvents =
          _prefs.getStringList('savedEvents')?.map((eventDataString) {
                Map<String, dynamic> eventData = {};
                List<String> parts = eventDataString.split(';');
                eventData['name'] = parts[0];
                eventData['date'] = DateTime.parse(parts[1]);
                eventData['location'] = parts[2];
                eventData['category'] = parts[3];
                // Add more fields if needed
                return eventData;
              }).toList() ??
              [];
      savedEvents.add({
        'name': widget.eventName,
        'date': widget.eventDate.toString(),
        'location': widget.eventLocation,
        'category': widget.eventCategory,
        // Add more fields if needed
      });
      await _prefs.setStringList(
          'savedEvents',
          savedEvents
              .map((eventData) =>
                  '${eventData['name']};${eventData['date']};${eventData['location']};${eventData['category']}')
              .toList());
    } else {
      // If not bookmarked, remove event details from saved events list
      List<Map<String, dynamic>> savedEvents =
          _prefs.getStringList('savedEvents')?.map((eventDataString) {
                Map<String, dynamic> eventData = {};
                List<String> parts = eventDataString.split(';');
                eventData['name'] = parts[0];
                eventData['date'] = DateTime.parse(parts[1]);
                eventData['location'] = parts[2];
                eventData['category'] = parts[3];
                // Add more fields if needed
                return eventData;
              }).toList() ??
              [];
      savedEvents
          .removeWhere((eventData) => eventData['name'] == widget.eventName);
      await _prefs.setStringList(
          'savedEvents',
          savedEvents
              .map((eventData) =>
                  '${eventData['name']};${eventData['date']};${eventData['location']};${eventData['category']}')
              .toList());
    }

    // Update the bookmark color on the current screen
    setState(() {
      if (isBookmarked) {
        // If bookmarked, save the event name with true value
        _prefs.setBool(widget.eventName, true);
      } else {
        // If not bookmarked, remove the event name from SharedPreferences
        _prefs.remove(widget.eventName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.eventName),
        leading: const Icon(
            Icons.event), // You can replace this with an actual event icon
        actions: [
          IconButton(
            icon: Icon(
              isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: isBookmarkYellow
                  ? Colors.yellow
                  : null, // Set color based on isBookmarkYellow
            ),
            onPressed: _toggleBookmark,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Text(
                'Event Details',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            _buildDetailRow('Event Name', widget.eventName),
            _buildDetailRow('Location', widget.eventLocation),
            _buildDetailRow(
              'Date',
              DateFormat('dd MMMM yyyy').format(widget.eventDate),
            ),
            _buildDetailRow('Category', widget.eventCategory),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SavedScreen(),
                  ),
                );
              },
              child: const Text('Search'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
