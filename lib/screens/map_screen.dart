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
import 'mapscreen_linked_pages/hotspot_settings.dart';
import 'mapscreen_linked_pages/camera_page.dart';

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
  bool _showOverlay = false;
  // bool _isSearching = false;

  void _toggleOverlay() {
    setState(() {
      _showOverlay = !_showOverlay;
    });
  }
//!----------------------------- map buttons if needed

  // void _resetOrientation() {
  //   _mapController.rotate(0.0);
  // }

  // void _zoomIn() {
  //   double currentZoom = _mapController.zoom;
  //   if (currentZoom < _maxZoom) {
  //     _mapController.move(_mapController.center, currentZoom + 1);
  //   }
  // }

  // void _zoomOut() {
  //   double currentZoom = _mapController.zoom;
  //   if (currentZoom > _minZoom) {
  //     _mapController.move(_mapController.center, currentZoom - 1);
  //   }
  // }

//!-----------------------------

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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Username Here',
                        style: TextStyle(color: Colors.black)),
                    SizedBox(height: 4),
                    Text('email here',
                        style: TextStyle(color: Colors.black, fontSize: 14)),
                  ],
                ),
              ),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Profile())),
            ),
            ...[
              {'title': 'Current Sessions', 'page': const CurrentSessions()},
              {'title': 'Recent Casts', 'page': const RecentCasts()},
              {'title': 'Places', 'page': const Places()},
              {'title': 'Catches', 'page': const Catches()},
              {'title': 'Weather', 'page': const Weather()},
              {'title': 'Store', 'page': const Store()},
              {'title': 'Settings', 'page': const Settings()},
              {'title': 'Support', 'page': const Support()},
            ].map((item) => Column(
                  children: [
                    const Divider(),
                    ListTile(
                      title: Text(item['title'] as String),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => item['page'] as Widget)),
                    ),
                  ],
                )),
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
            top: 40,
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
            top: 40,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 90),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search location',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                    },
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            top: 30,
            right: 20,
            child: Column(
              mainAxisSize:
                  MainAxisSize.min, // Ensures tight wrapping of children
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.warning_amber_rounded,
                    size: 37,
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
                        fontSize: 11,
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
            bottom: 32,
            left: 30,
            child: Center(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.blue, // Blue background color
                  shape: BoxShape.circle, // Circular shape
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.camera_alt_rounded,
                    color: Colors.white, // Icon color
                  ),
                  onPressed: _toggleOverlay,
                  iconSize: 25, // Icon size
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                height: 55,
                width: 150, // Adjust the width as needed
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CurrentSessions()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15), // Only vertical padding
                  ),
                  child: const Text(
                    'Start Session',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          if (_showOverlay)
            GestureDetector(
              onTap: _toggleOverlay,
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const CameraPage()), // Navigate to CameraPage
                          );
                        },
                        child: const Text('Go to Camera Page'),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const CameraPage()), // Navigate to CameraPage
                          );
                        },
                        child: const Text('Go to Camera Page'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
//!----------------------------- map buttons if needed
          // Positioned(
          //   bottom: 190,
          //   right: 20,
          //   child: FloatingActionButton(
          //     onPressed: _resetOrientation,
          //     backgroundColor: Colors.blue,
          //     child: const Icon(
          //       Icons.compass_calibration,
          //       size: 35,
          //       color: Colors.white,
          //     ),
          //   ),
          // ),
          // Positioned(
          //   bottom: 130,
          //   right: 20,
          //   child: FloatingActionButton(
          //     onPressed: _zoomIn,
          //     backgroundColor: Colors.blue,
          //     child: const Icon(
          //       Icons.zoom_in,
          //       size: 35,
          //       color: Colors.white,
          //     ),
          //   ),
          // ),
          // Positioned(
          //   bottom: 70,
          //   right: 20,
          //   child: FloatingActionButton(
          //     onPressed: _zoomOut,
          //     backgroundColor: Colors.blue,
          //     child: const Icon(
          //       Icons.zoom_out,
          //       size: 35,
          //       color: Colors.white,
          //     ),
          //   ),
          // ),
//!-----------------------------
        ],
      ),
    );
  }
}
