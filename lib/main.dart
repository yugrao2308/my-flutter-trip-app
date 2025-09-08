import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yourtrip/screens.dart';
import 'flights_screen.dart'; // Import the new flights screen

void main() {
  runApp(const GoFlutterApp());
}

class GoFlutterApp extends StatelessWidget {
  const GoFlutterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YourTrip',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.poppinsTextTheme(),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          pinned: true,
          expandedHeight: 120.0,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              'YourTrip',
              style: GoogleFonts.pacifico(
                fontSize: 30,
                color: Colors.indigo,
              ),
            ),
            centerTitle: true,
          ),
        ),
        SliverToBoxAdapter(
          child: BookingCard(),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Popular Destinations',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.5,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              final destinations = [
                {'label': 'Beach', 'icon': Icons.beach_access},
                {'label': 'Mountain', 'icon': Icons.terrain},
                {'label': 'City', 'icon': Icons.location_city},
                {'label': 'Forest', 'icon': Icons.forest},
              ];
              return DestinationCard(
                icon: destinations[index]['icon'] as IconData,
                label: destinations[index]['label'] as String,
              );
            },
            childCount: 4,
          ),
        ),
      ],
    );
  }
}

class BookingCard extends StatelessWidget {
  const BookingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BookingOption(icon: Icons.flight, label: 'Flights'),
            BookingOption(icon: Icons.hotel, label: 'Hotels'),
            BookingOption(icon: Icons.train, label: 'Trains'),
            BookingOption(icon: Icons.directions_car, label: 'Cabs'),
          ],
        ),
      ),
    );
  }
}

class BookingOption extends StatelessWidget {
  final IconData icon;
  final String label;

  const BookingOption({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (label == 'Flights') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FlightsScreen()),
          );
        }
        // TODO: Add navigation for other options
      },
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Icon(icon, color: Colors.indigo, size: 30.0),
            const SizedBox(height: 5.0),
            Text(label, style: const TextStyle(fontSize: 12.0)),
          ],
        ),
      ),
    );
  }
}

class DestinationCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const DestinationCard({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Widget screen;
        switch (label) {
          case 'Beach':
            screen = const BeachScreen();
            break;
          case 'Mountain':
            screen = const MountainScreen();
            break;
          case 'City':
            screen = const CityScreen();
            break;
          case 'Forest':
            screen = const ForestScreen();
            break;
          default:
            return;
        }
        Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
      },
      child: Card(
        margin: const EdgeInsets.all(10.0),
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.indigo),
            const SizedBox(height: 10),
            Text(label, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Favorites Page',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Profile Page',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
