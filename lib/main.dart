import 'package:flutter/material.dart';
import 'services/api_service.dart';
import 'models/location.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('TCS Locator App'),
        ),
        body: Center(
          child: LocationListScreen(),
        ),
      ),
    );
  }
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'TCS Locater App',
//       home: LocationListScreen(),
//     );
//   }
// }

class LocationListScreen extends StatefulWidget {
  @override
  _LocationListScreenState createState() => _LocationListScreenState();
}

class _LocationListScreenState extends State<LocationListScreen> {
  List<Location> _locations = [];
  List<Location> _filteredLocations = [];
  bool _isLoading = true;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _fetchLocations();
  }

  Future<void> _fetchLocations() async {
    try {
      final apiService = ApiService();
      final apiResponse = await apiService.fetchApiResponse();
      print(apiResponse.locations);
      setState(() {
        print(apiResponse.locations);
        _locations = apiResponse.locations;
        _filteredLocations = _locations;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
      print(e);
        _isLoading = false;
      });
      print(e);
    }
  }

  void _filterLocations(String query) {
    final filtered = _locations.where((location) {
      final locationName = location.geo.toLowerCase();
      final searchQuery = query.toLowerCase();
      return locationName.contains(searchQuery);
    }).toList();

    setState(() {
      _searchQuery = query;
      _filteredLocations = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('TCS Locator App'),
      // ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(  
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Search',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: _filterLocations,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _filteredLocations.length,
                    itemBuilder: (context, index) {
                      final location = _filteredLocations[index];
                      return ListTile(
                        title: Text(location.location),
                        subtitle: Text(location.geo + ' - ' + location.area),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}