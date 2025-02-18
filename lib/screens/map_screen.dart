import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'drawer_linked_pages/profile_page.dart';
import 'drawer_linked_pages/recent_casts.dart';
import 'drawer_linked_pages/current_sessions.dart';
import 'drawer_linked_pages/places.dart';
import 'drawer_linked_pages/catches.dart';
import 'drawer_linked_pages/weather.dart';
import 'drawer_linked_pages/support.dart';
import 'drawer_linked_pages/store.dart';
import 'drawer_linked_pages/settings.dart';
import 'hotspot_settings.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  final double _minZoom = 2.0;
  final double _maxZoom = 18.0;

  // GlobalKey for Scaffold
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  void _resetOrientation() {
    _mapController.rotate(0.0);
  }

  void _zoomIn() {
    double currentZoom = _mapController.zoom;
    if (currentZoom < _maxZoom) {
      _mapController.move(_mapController.center, currentZoom + 1);
    }
  }

  void _zoomOut() {
    double currentZoom = _mapController.zoom;
    if (currentZoom > _minZoom) {
      _mapController.move(_mapController.center, currentZoom - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey, // Assign the global key here
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(height: 35),
            ListTile(
              leading: const Icon(Icons.cloud),
              title: const Center(
                // Centers the entire text block horizontally
                child: Column(
                  mainAxisSize:
                      MainAxisSize.min, // Prevents unnecessary stretching
                  crossAxisAlignment: CrossAxisAlignment
                      .start, // Aligns text to the left within the block
                  children: [
                    Text(
                      'Username Here',
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'email here',
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0), fontSize: 14),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Profile()),
                );
              },
            ),
            const SizedBox(height: 15),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.cloud),
              title: const Text(
                'Current Sessions',
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CurrentSessions()),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.web),
              title: const Text('Recent Casts'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RecentCasts()),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.web),
              title: const Text('Places'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Places()),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.web),
              title: const Text('Catches'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Catches()),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.web),
              title: const Text('Weather'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Weather()),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.web),
              title: const Text('Store'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Store()),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.web),
              title: const Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Settings()),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.web),
              title: const Text('Support'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Support()),
                );
              },
            ),
            const Divider(),
          ],
        ),
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: LatLng(51.509364, -0.128928),
              zoom: 3.2,
              minZoom: _minZoom,
              maxZoom: _maxZoom,
              maxBounds: LatLngBounds(
                LatLng(-85.05112878, -180.0),
                LatLng(85.05112878, 180.0),
              ),
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer/tile/{z}/{y}/{x}.jpg',
                userAgentPackageName: 'com.example.app',
              ),
            ],
          ),
          Positioned(
            top: 30,
            left: 22,
            child: IconButton(
              icon: const Icon(Icons.menu, size: 35, color: Colors.blue),
              onPressed: () {
                scaffoldKey.currentState?.openDrawer();
              },
            ),
          ),
          // Floating Search Bar Positioned at the Top Center
          Positioned(
            top: 30,
            left: 90,
            child: Container(
              width: 230,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: _isSearching
                  ? Center(
                      // Use Center widget to ensure the TextField is centered
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                _searchController.clear();
                              });
                            },
                          ),
                        ),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'locations',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w200),
                        ),
                        IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            setState(() {
                              _isSearching = true;
                            });
                          },
                        ),
                      ],
                    ),
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: Column(
              mainAxisSize:
                  MainAxisSize.min, // Ensures tight wrapping of children
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.warning_amber_rounded,
                    size: 40,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Hotspot()),
                    );
                  },
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Hotspot()),
                    );
                  },
                  child: Transform.translate(
                    offset: const Offset(0, -10), // Moves text up slightly
                    child: const Text(
                      'Hotspots',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            bottom: 190,
            right: 20,
            child: FloatingActionButton(
              onPressed: _resetOrientation,
              backgroundColor: Colors.blue,
              child: const Icon(
                Icons.compass_calibration,
                size: 35,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            bottom: 130,
            right: 20,
            child: FloatingActionButton(
              onPressed: _zoomIn,
              backgroundColor: Colors.blue,
              child: const Icon(
                Icons.zoom_in,
                size: 35,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            bottom: 70,
            right: 20,
            child: FloatingActionButton(
              onPressed: _zoomOut,
              backgroundColor: Colors.blue,
              child: const Icon(
                Icons.zoom_out,
                size: 35,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
