// import 'dart:async';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:budy/models/event_model.dart';

// class EventService {
//   static const String _baseUrl = 'YOUR_API_BASE_URL_HERE';

//   Future<List<Event>> fetchEvents() async {
//     try {
//       final response = await http.get(Uri.parse('$_baseUrl/events'));
//       if (response.statusCode == 200) {
//         final List<dynamic> data = jsonDecode(response.body);
//         return data.map((json) => Event.fromJson(json)).toList();
//       } else {
//         throw Exception('Failed to fetch events');
//       }
//     } catch (e) {
//       throw Exception('Failed to fetch events: $e');
//     }
//   }
// }
