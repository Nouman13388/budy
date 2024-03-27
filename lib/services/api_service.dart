import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiData {
  Future<Map<String, dynamic>> getData(String url,
      {String? key, dynamic? param}) async {
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'OK') {
          if (param != null && key != null) {
            // Iterate over the data to find the matching item
            dynamic? result;
            for (dynamic item in data['results']) {
              if (item[key] == param) {
                result = item;
                break; // Found the matching item, exit the loop
              }
            }
            if (result != null) {
              return {
                'status': 'OK',
                'results': [result]
              };
            } else {
              // No matching item found
              return {'status': 'OK', 'results': []};
            }
          } else {
            return data; // Return user data directly
          }
        } else {
          throw Exception('Failed to fetch data');
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      // Handle any errors that occur during the API call
      print('Error fetching data: $error');
      throw Exception('Failed to load data');
    }
  }

// Function to post event data
  Future<Map<String, dynamic>> postData(
      String url, Map<String, dynamic> postData) async {
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        body: json.encode(postData), // Encode the data as JSON
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*', // Allow requests from any origin
          'Access-Control-Allow-Headers':
              'Origin, X-Requested-With, Content-Type, Accept', // Specify allowed headers
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'OK') {
          print(data);
          return data; // Return user data directly
        } else {
          throw Exception('Failed to fetch data');
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      // Handle any errors that occur during the API call
      print('Error fetching data: $error');
      throw Exception('Failed to load data');
    }
  }

// Function to edit event data
  Future<Map<String, dynamic>> editData(
      String url, Map<String, dynamic> eventData) async {
    try {
      http.Response response = await http.put(
        Uri.parse(url),
        body: json.encode(eventData), // Encode the event data as JSON
        headers: {'Content-Type': 'application/json'},
        // Set headers for JSON content
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'OK') {
          return data; // Return the response data
        } else {
          throw Exception('Failed to edit event data');
        }
      } else {
        throw Exception('Failed to edit data');
      }
    } catch (error) {
      // Handle any errors that occur during the API call
      print('Error editing event data: $error');
      throw Exception('Failed to edit event data');
    }
  }

// Function to delete event data
  Future<Map<String, dynamic>> deleteData(String url, dynamic itemData) async {
    try {
      // Convert the item data to JSON
      String jsonData = json.encode(itemData);

      http.Response response = await http.delete(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json'
        }, // Set headers for JSON content
        body: jsonData, // Include the item data in the request body
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'OK') {
          print('Item deleted successfully');
          return data; // Return the response data
        } else {
          throw Exception('Failed to delete item');
        }
      } else {
        throw Exception('Failed to delete item');
      }
    } catch (error) {
      // Handle any errors that occur during the API call
      if (kDebugMode) {
        print('Error deleting item: $error');
      }
      throw Exception('Failed to delete item');
    }
  }
}
