import 'package:flutter/material.dart';

class SearchLocationScreen extends StatefulWidget {
  final String? currentLocation;

  const SearchLocationScreen({super.key, this.currentLocation});

  @override
  State<SearchLocationScreen> createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState extends State<SearchLocationScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _cities = [
    'New York', 'London', 'Paris', 'Tokyo', 'Dubai', 'Singapore',
    'New Delhi', 'Mumbai', 'Bangalore', 'Sydney', 'Melbourne'
  ];
  List<String> _filteredCities = [];

  @override
  void initState() {
    super.initState();
    _filteredCities = _cities;
    _searchController.addListener(() {
      _filterCities();
    });
  }

  void _filterCities() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredCities = _cities.where((city) {
        return city.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search City'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for a city...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredCities.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_filteredCities[index]),
                  onTap: () {
                    Navigator.pop(context, _filteredCities[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
