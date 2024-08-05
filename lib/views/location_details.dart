import 'package:flutter/material.dart';
import '../models/location.dart';


class LocationDetails extends StatelessWidget {
  final Location location;

  const LocationDetails({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(location.location),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          // Map in the top half of the screen
          const Expanded(
            flex: 1,
            child: Text('Map goes here'),
          ),
          // Details in the bottom half of the screen
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(location.location,
                      style: const TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      const Icon(Icons.email),
                      const SizedBox(width: 8.0),
                      Text(location.email),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      const Icon(Icons.location_on),
                      const SizedBox(width: 8.0),
                      Text(location.address),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      if (location.phone.isNotEmpty)
                        ...[
                          const Icon(Icons.phone),
                          const SizedBox(width: 8.0),
                          Text(location.phone),
                        ]
                      else
                        ...[
                          const Icon(Icons.phone),
                          const SizedBox(width: 8.0),
                          const Text('No phone number available'),
                        ]
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      Row(
                        children: [
                          if (location.websites.isNotEmpty)
                            for (var website in location.websites) ...{
                                const Icon(Icons.web),
                                const SizedBox(width: 8.0),
                               Text(website.url, style: const TextStyle(color: Colors.blue)),
                            }
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
