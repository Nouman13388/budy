//Saved Events Screen
import 'package:budy/screens/event_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences

class SavedScreen extends StatefulWidget {
  const SavedScreen({Key? key}) : super(key: key);

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  late SharedPreferences _prefs; // Declare SharedPreferences object

  List<String> savedEvents = []; // List to store saved event details

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      // Load saved event details from SharedPreferences
      savedEvents = _prefs.getStringList('savedEvents') ?? [];
    });
  }

  Future<void> _removeBookmark(String eventName) async {
    setState(() {
      savedEvents.remove(eventName); // Remove event from savedEvents list
    });
    await _prefs.setStringList(
        'savedEvents', savedEvents); // Save updated list to SharedPreferences
  }

  void _navigateToEventDetailsPage(String eventDetails) async {
    final details = eventDetails.split(';');
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventDetailsPage(
          eventName: details[0],
          eventDate: DateTime.parse(details[1]),
          eventLocation: details[2],
          eventCategory: details[3],
        ),
      ),
    );

    if (result == true) {
      // Event was deleted, update savedEvents list
      _loadPreferences();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Events'),
      ),
      body: savedEvents.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bookmark,
                    size: 100,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'No items saved',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: savedEvents.length,
              itemBuilder: (context, index) {
                final eventDetails = savedEvents[index];
                final details = eventDetails.split(';');
                final eventName = details[0];
                final eventDate = details[1];
                final eventLocation = details[2];
                final eventCategory = details[3];

                return ListTile(
                  title: GestureDetector(
                    onTap: () => _navigateToEventDetailsPage(
                        eventDetails), // Navigate to event details page on tap
                    child: Text(eventName),
                  ),
                  subtitle: GestureDetector(
                    onTap: () => _navigateToEventDetailsPage(
                        eventDetails), // Navigate to event details page on tap
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Date: $eventDate'),
                        Text('Location: $eventLocation'),
                        Text('Category: $eventCategory'),
                      ],
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      await _removeBookmark(
                          eventDetails); // Call _removeBookmark when delete icon is clicked
                      setState(
                          () {}); // Trigger rebuild to update the list view
                    },
                  ),
                );
              },
            ),
    );
  }
}
