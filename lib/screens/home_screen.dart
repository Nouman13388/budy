import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'qr_screen.dart';
import 'event_screen.dart';
import 'explore_screen.dart';
import 'profile_screen.dart';
import 'saved_screen.dart';
import 'setting_screen.dart';
import 'signin_screen.dart';
import '../services/location_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String currentLocation = 'Loading...';
  bool _showSearchBar = false;
  User? _user;

  @override
  void initState() {
    super.initState();
    _getLocation();
    _getUser();
  }

  Future<void> _getLocation() async {
    try {
      final locationData = await LocationService.getLocation();
      if (locationData != null) {
        final List<Placemark> placemarks = await placemarkFromCoordinates(
          locationData['latitude']!,
          locationData['longitude']!,
        );
        if (placemarks.isNotEmpty) {
          final Placemark placemark = placemarks[0];
          final String locationName = placemark.name ?? 'Unknown Location';
          final String address = placemark.street ?? '';
          setState(() {
            currentLocation = '$locationName, $address';
          });
        } else {
          setState(() {
            currentLocation = 'Unknown Location';
          });
        }
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

  Future<void> _getUser() async {
    _user = FirebaseAuth.instance.currentUser;
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
    const MobileScannerScreen(),
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
              child: Text(
                currentLocation,
                style: const TextStyle(fontSize: 11),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.location_on),
              onPressed: () {
                Navigator.pushNamed(context, '/googlemap');
              },
            ),
            IconButton(
              icon: Icon(_showSearchBar ? Icons.close : Icons.search),
              onPressed: () {
                setState(() {
                  _showSearchBar = !_showSearchBar;
                });
              },
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: const CircleAvatar(
                child: Icon(Icons.person),
              ),
              accountName:
                  _user != null ? Text(_user!.displayName ?? '') : null,
              accountEmail: _user != null ? Text(_user!.email ?? '') : null,
            ),
            ListTile(
              title: const Text('Settings'),
              leading: const Icon(Icons.settings),
              onTap: _openSettings,
            ),
            ListTile(
              title: const Text('Logout'),
              leading: const Icon(Icons.logout),
              onTap: _logout,
            ),
          ],
        ),
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
        selectedItemColor: Colors.blue, // Set the selected item color to blue
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
