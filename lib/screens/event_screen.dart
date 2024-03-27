// //Event Screen
// import 'package:budy/screens/event_details_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:http/http.dart' as http; // Import HTTP package
// import 'dart:convert'; // Import convert for JSON decoding

// class EventScreen extends StatefulWidget {
//   const EventScreen({super.key});

//   @override
//   _EventScreenState createState() => _EventScreenState();
// }

// class _EventScreenState extends State<EventScreen> {
//   late Future<List<dynamic>> _upcomingEvents;
//   late Future<List<dynamic>> _pastEvents;

//   @override
//   void initState() {
//     super.initState();
//     _upcomingEvents = fetchEventData(true);
//     _pastEvents = fetchEventData(false);
//   }

//   Future<List<dynamic>> fetchEventData(bool isUpcoming) async {
//     final url = isUpcoming
//         ? 'http://localhost/budy_project/Tester/eventApi.php'
//         : 'http://localhost/budy_project/Tester/eventApi.php';

//     final response = await http.get(Uri.parse(url));

//     if (response.statusCode == 200) {
//       final List<dynamic> data = json.decode(response.body)['results'];
//       return data;
//     } else {
//       throw Exception('Failed to load events');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Events'),
//           bottom: const TabBar(
//             tabs: [
//               Tab(text: 'UPCOMING'),
//               Tab(text: 'PAST EVENTS'),
//             ],
//             indicatorColor: Colors.black12,
//             indicatorWeight: 4,
//             labelColor: Colors.black87,
//             unselectedLabelColor: Colors.grey,
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             FutureBuilder(
//               future: _upcomingEvents,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasError) {
//                   return Center(child: Text('Error: ${snapshot.error}'));
//                 } else {
//                   return EventList(eventData: snapshot.data as List<dynamic>);
//                 }
//               },
//             ),
//             FutureBuilder(
//               future: _pastEvents,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasError) {
//                   return Center(child: Text('Error: ${snapshot.error}'));
//                 } else {
//                   return EventList(eventData: snapshot.data as List<dynamic>);
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class EventList extends StatelessWidget {
//   final List<dynamic> eventData;

//   const EventList({super.key, required this.eventData});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: eventData.length,
//       itemBuilder: (context, index) {
//         final event = eventData[index];
//         return EventCard(
//           eventName: event['event_name'],
//           eventDate: DateTime.parse(event['date_time']),
//           eventLocation: event['location'],
//           eventImagePath: 'assets/images/event_img.png',
//           eventCategory: event['cat_name'],
//         );
//       },
//     );
//   }
// }

// class EventCard extends StatelessWidget {
//   final String eventName;
//   final DateTime eventDate;
//   final String eventLocation;
//   final String eventImagePath;
//   final String eventCategory;

//   const EventCard({
//     super.key,
//     required this.eventName,
//     required this.eventDate,
//     required this.eventLocation,
//     required this.eventImagePath,
//     required this.eventCategory,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       child: InkWell(
//         onTap: () {
//           // Navigate to details page when card is tapped
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => EventDetailsPage(
//                 eventName: eventName,
//                 eventDate: eventDate,
//                 eventLocation: eventLocation,
//                 eventCategory: eventCategory,
//               ),
//             ),
//           );
//         },
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             ClipRRect(
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(8),
//                 topRight: Radius.circular(8),
//               ),
//               child: Image.asset(
//                 eventImagePath,
//                 height: 200,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     eventName,
//                     style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     eventLocation,
//                     style: const TextStyle(
//                       fontSize: 16,
//                       color: Colors.grey,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'Date: ${DateFormat('dd MMMM yyyy').format(eventDate)}',
//                     style: const TextStyle(
//                       fontSize: 16,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Row(
//                     children: [
//                       const Text(
//                         'Category: ',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 6,
//                           vertical: 2,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Colors.blue[200],
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Text(
//                           eventCategory,
//                           style: const TextStyle(
//                             fontSize: 14,
//                             color: Colors.blue,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:budy/screens/saved_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                        icon: const Icon(Icons.bookmark),
                        onPressed: () {
                          // Handle save button press
                          _saveEvent(context,
                              '$eventName;${DateFormat('dd MMMM yyyy').format(eventDate)};$eventLocation;$eventCategory');
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

    // Navigate to the SavedScreen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SavedScreen()),
    );
  }
}
