import 'package:budy/screens/budy_screen.dart';
import 'package:budy/screens/event_screen.dart';
import 'package:budy/screens/explore_screen.dart';
import 'package:budy/screens/profile_screen.dart';
import 'package:budy/screens/saved_screen.dart';
import 'package:budy/screens/setting_screen.dart';
import 'package:budy/screens/signin_screen.dart';
import 'package:budy/services/location_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String currentLocation = 'Loading...';
  double? currentLatitude;
  double? currentLongitude;
  bool _showSearchBar = false;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    try {
      final locationData = await LocationService.getLocation();
      if (locationData != null) {
        setState(() {
          currentLatitude = locationData['latitude'];
          currentLongitude = locationData['longitude'];
          currentLocation = 'Lat: $currentLatitude, Lng: $currentLongitude';
        });
      } else {
        setState(() {
          currentLocation = 'Unknown Location';
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error getting location: $e');
      }
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

  final List<Widget> _widgetOptions = <Widget>[
    const ExploreScreen(),
    const EventScreen(),
    const BudyScreen(),
    const SavedScreen(),
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
                child: PopupMenuButton(
                  icon: const Icon(Icons.menu),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: ListTile(
                        leading: const Icon(Icons.logout),
                        title: const Text('Logout'),
                        onTap: _logout,
                      ),
                    ),
                    PopupMenuItem(
                      child: ListTile(
                        leading: const Icon(Icons.settings),
                        title: const Text('Settings'),
                        onTap: _openSettings,
                      ),
                    ),
                  ],
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
                const SizedBox(width: 10),
                const Icon(Icons.location_on, size: 20),
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
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.location_searching),
            label: 'Explore',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Event',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              height: 50, // Adjust height as needed
              child: Image.asset(
                'assets/images/budy_logo.png', // Replace 'assets/your_image.png' with your image path
              ),
            ),
            label: '',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.save),
            label: 'Saved',
          ),
          const BottomNavigationBarItem(
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

  void _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      // Navigate to sign-in screen and remove all previous routes from the stack
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        ),
        (route) => false, // Prevents going back to the previous route
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error logging out: $e');
      }
      // Show error message to the user if needed
    }
  }

  void _openSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }
}
