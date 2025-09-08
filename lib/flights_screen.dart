import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'search_location_screen.dart';

class FlightsScreen extends StatefulWidget {
  const FlightsScreen({super.key});

  @override
  State<FlightsScreen> createState() => _FlightsScreenState();
}

class _FlightsScreenState extends State<FlightsScreen> {
  int _tripType = 0; // 0 for One-way, 1 for Round-trip, 2 for Multi-city
  String _fromCity = 'New Delhi';
  String _fromAirportCode = 'DEL';
  String _toCity = 'Mumbai';
  String _toAirportCode = 'BOM';
  DateTime? _departureDate;
  DateTime? _returnDate;

  void _navigateToSearchScreen(bool isFrom) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SearchLocationScreen()),
    );

    if (result != null && result is String) {
      setState(() {
        if (isFrom) {
          _fromCity = result;
          // Mock airport code generation
          _fromAirportCode = result.substring(0, 3).toUpperCase();
        } else {
          _toCity = result;
          _toAirportCode = result.substring(0, 3).toUpperCase();
        }
      });
    }
  }

  Future<void> _selectDate(BuildContext context, bool isDeparture) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _departureDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isDeparture) {
          _departureDate = picked;
        } else {
          _returnDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Flights'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Trip Type Radio Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ChoiceChip(
                    label: const Text('One-way'),
                    selected: _tripType == 0,
                    onSelected: (selected) {
                      if (selected) setState(() => _tripType = 0);
                    },
                    selectedColor: Colors.deepPurple.shade100,
                  ),
                  ChoiceChip(
                    label: const Text('Round-trip'),
                    selected: _tripType == 1,
                    onSelected: (selected) {
                      if (selected) setState(() => _tripType = 1);
                    },
                    selectedColor: Colors.deepPurple.shade100,
                  ),
                  ChoiceChip(
                    label: const Text('Multi-city'),
                    selected: _tripType == 2,
                    onSelected: (selected) {
                      if (selected) setState(() => _tripType = 2);
                    },
                    selectedColor: Colors.deepPurple.shade100,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // From and To Fields
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    children: [
                      _buildAirportSelector('FROM', _fromCity, _fromAirportCode, true),
                      const Divider(),
                      _buildAirportSelector('TO', _toCity, _toAirportCode, false),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Date Selection
              Row(
                children: [
                  Expanded(child: _buildDateSelector('DEPARTURE', _departureDate, true)),
                  const SizedBox(width: 16),
                  Expanded(child: _buildDateSelector('RETURN', _returnDate, false)),
                ],
              ),
              const SizedBox(height: 24),

              _buildTravellerSelector(),

              const SizedBox(height: 40),

              // Search Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.orange.shade700,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text(
                    'SEARCH FLIGHTS',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAirportSelector(String label, String city, String airport, bool isFrom) {
    return InkWell(
      onTap: () => _navigateToSearchScreen(isFrom),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                const SizedBox(height: 4),
                Text(city, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                Text(airport, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSelector(String label, DateTime? date, bool isDeparture) {
    return InkWell(
      onTap: () => _selectDate(context, isDeparture),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              const SizedBox(height: 4),
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyLarge,
                  children: date == null
                      ? [const TextSpan(text: 'Select ', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)), const TextSpan(text: 'Date', style: TextStyle(fontSize: 20))]
                      : [
                          TextSpan(text: '${DateFormat('d MMM').format(date)} ', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                          TextSpan(text: DateFormat('EEEE').format(date), style: const TextStyle(fontSize: 16, color: Colors.grey)),
                        ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

    Widget _buildTravellerSelector() {
     return InkWell(
      onTap: () {
        // TODO: Implement traveller & class selection
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('TRAVELLERS & CLASS', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  const SizedBox(height: 4),
                   RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyLarge,
                      children: const [
                        TextSpan(text: '1 ', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        TextSpan(text: 'Adult', style: TextStyle(fontSize: 20)),
                      ]
                    ),
                  ),
                   const Text('Economy/Premium Economy', style: TextStyle(color: Colors.grey)),
                ],
              ),
              const Icon(Icons.arrow_drop_down, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
