import 'package:flutter/material.dart';
import '../models/location.dart';
import '../services/api_service.dart';
import 'location_details.dart';

class LocationListScreen extends StatefulWidget {
  const LocationListScreen({super.key});

  @override
  _LocationListScreenState createState() => _LocationListScreenState();
}

class _LocationListScreenState extends State<LocationListScreen> {
  List<Location> _locations = [];
  List<Location> _filteredLocations = [];
  bool _isLoading = true;
  String _searchInputText = '';

  @override
  void initState() {
    super.initState();
    _fetchLocations();
  }

  Future<void> _fetchLocations() async {
    try {
      final apiService = ApiService();
      final apiResponse = await apiService.fetchApiResponse();
      setState(() {
        _locations = apiResponse.locations;
        _filteredLocations = _locations;
        _isLoading = false;
        _searchInputText = '';
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _filterLocations(String query) {
    print(query);
    print(_searchInputText);
  
    final filtered = _locations.where((location) {
      final locationName = location.geo.toLowerCase();
      final searchQuery = query.toLowerCase();
      return locationName.contains(searchQuery);
    }).toList();

    setState(() {
      _filteredLocations = filtered;
    });

    setState(() {
      _searchInputText = query;
    });
  }

  List<String> _getUniqueAreas() {
    final areas = _locations.map((location) => location.area).toSet().toList();
    return areas;
  }

  void _filterLocationsByArea(String area) {
    final filtered = _locations.where((location) {
      return location.area == area;
    }).toList();

    setState(() {
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
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                            // key: const Key('search_input'),
                            decoration: const InputDecoration(
                            labelText: 'Search',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: _filterLocations,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.filter_list),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Filter by Area'),
                                content: SingleChildScrollView(
                                  child: Column(
                                    children: _getUniqueAreas().map((area) {
                                      return ListTile(
                                        title: Text(area),
                                        onTap: () {
                                          _filterLocationsByArea(area);
                                          Navigator.of(context).pop();
                                        },
                                      );
                                    }).toList(),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        _filteredLocations = _locations;
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Clear Filter'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Close'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _filteredLocations.length,
                    itemBuilder: (context, index) {
                      final location = _filteredLocations[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  LocationDetails(location: location),
                            ),
                          );
                        },
                        child: ListTile(
                          title: Text(location.location),
                          subtitle: Text('${location.geo} - ${location.area}'),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
