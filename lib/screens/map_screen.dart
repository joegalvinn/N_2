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

  // Track the selected index for drawer
  int _selectedIndex = -1;

  void _toggleOverlay() {
    setState(() {
      _showOverlay = !_showOverlay;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(height: 50),
            InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Profile()),
              ),
              splashColor: Colors.blue.withOpacity(0.3),
              highlightColor: Colors.blue.withOpacity(0.3),
              child: const ListTile(
                leading: Icon(Icons.person),
                iconColor: Colors.black,
                title: Column(
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
            ),
            const SizedBox(height: 25),
            ...[
              {
                'title': 'Current Sessions',
                'icon': Icons.play_arrow_rounded,
                'page': const CurrentSessions()
              },
              {
                'title': 'Recent Casts',
                'icon': Icons.replay,
                'page': const RecentCasts()
              },
              {
                'title': 'Places',
                'icon': Icons.location_on_sharp,
                'page': const Places()
              },
              {
                'title': 'Catches',
                'icon': Icons.sports_handball_sharp,
                'page': const Catches()
              },
              {
                'title': 'Weather',
                'icon': Icons.wb_sunny,
                'page': const Weather()
              },
              {
                'title': 'Store',
                'icon': Icons.storefront,
                'page': const Store()
              },
              {
                'title': 'Settings',
                'icon': Icons.settings,
                'page': const Settings()
              },
              {
                'title': 'Support',
                'icon': Icons.contact_support_rounded,
                'page': const Support()
              },
            ].asMap().entries.map((entry) {
              int index = entry.key;
              var item = entry.value;
              return Column(
                children: [
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.blue.withOpacity(0.3),
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => item['page'] as Widget,
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      color:
                          _selectedIndex == index ? Colors.blue.shade100 : null,
                      child: SizedBox(
                        height: 55,
                        child: ListTile(
                          leading: Icon(
                            item['icon'] as IconData,
                            color: Colors.black,
                          ),
                          title: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                item['title'] as String,
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
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
              icon: const Icon(Icons.menu_outlined,
                  size: 35, color: Color.fromARGB(255, 33, 184, 243)),
              onPressed: () {
                scaffoldKey.currentState?.openDrawer();
              },
            ),
          ),
          // Floating Search Bar
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
              mainAxisSize: MainAxisSize.min,
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
                    offset: const Offset(0, -10),
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
            bottom: 35,
            left: 30,
            child: Center(
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 33, 184, 243),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.camera_alt_rounded,
                    color: Colors.white,
                  ),
                  onPressed: _toggleOverlay,
                  iconSize: 22,
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
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CurrentSessions()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 33, 184, 243),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text(
                    'Start Session',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ),
          if (_showOverlay)
            if (_showOverlay)
              GestureDetector(
                onTap: _toggleOverlay,
                child: Container(
                  color: Colors.black.withOpacity(0.5), // Dimmed background
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment
                            .bottomCenter, // Moves buttons to the bottom
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 120.0), // Space from bottom
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceEvenly, // Space buttons evenly
                            children: [
                              // First Button with Icon + Text
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const CameraPage(),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                          255, 33, 184, 243),
                                      padding: const EdgeInsets.all(
                                          15), // Adjust padding
                                      shape:
                                          const CircleBorder(), // Makes it a circle button
                                    ),
                                    child: const Icon(Icons.camera,
                                        color: Colors.white,
                                        size: 30), // Icon inside button
                                  ),
                                  const SizedBox(
                                      height: 8), // Space between icon and text
                                  const Text(
                                    'Camera',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),

                              // Second Button with Icon + Text
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const CameraPage(),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                          255, 33, 184, 243),
                                      padding: const EdgeInsets.all(15),
                                      shape: const CircleBorder(),
                                    ),
                                    child: const Icon(Icons.photo,
                                        color: Colors.white,
                                        size: 30), // Icon inside button
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Gallery',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
