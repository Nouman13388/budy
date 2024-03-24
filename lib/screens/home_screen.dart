import 'package:budy/screens/event_screen.dart';
import 'package:budy/screens/explore_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:budy/screens/profile_screen.dart';
import 'package:budy/services/location_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String currentLocation = 'Loading...';
  bool _showSearchBar = false;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    try {
      String? location = await LocationService.getLocationName();
      if (location != null) {
        setState(() {
          currentLocation = location;
        });
      } else {
        setState(() {
          currentLocation = 'Unknown Location';
        });
      }
    } catch (e) {
      print('Error getting location: $e');
      setState(() {
        currentLocation = 'Unknown Location';
      });
    }
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static final List<Widget> _widgetOptions = <Widget>[
    const ExploreScreen(),
    const EventScreen(),
    const Text('Budy'),
    const Text('Saved'),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    // Handle menu icon tap
                  },
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentLocation,
                  style: const TextStyle(fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
                const Icon(Icons.location_on),
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(_showSearchBar ? Icons.close : Icons.search),
                  onPressed: () {
                    setState(() {
                      _showSearchBar = !_showSearchBar;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Handle notification icon tap
            },
          ),
        ],
        bottom: _showSearchBar
            ? PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            borderSide: const BorderSide(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : null,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.location_searching),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Event',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Budy',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.save),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
