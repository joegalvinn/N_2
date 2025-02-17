import 'package:flutter/material.dart';
import 'package:nash_app_2/screens/map_screen.dart';

class Catches extends StatelessWidget {
  const Catches({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PlaceholderPage(),
    );
  }
}

class PlaceholderPage extends StatelessWidget {
  const PlaceholderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.keyboard_double_arrow_left,
              size: 40, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MapScreen()),
            );
          },
        ),
        title: null,
        backgroundColor: const Color.fromARGB(255, 33, 150, 243),
        flexibleSpace: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Image.asset(
              'images/nash-top-logo.png',
              width: 100,
              height: 50,
              fit: BoxFit.contain,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.map_outlined, size: 40, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const MapScreen()), // Change to your desired screen
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Container(
          width: 200,
          height: 200,
          color: Colors.grey[300], // Placeholder color
          child: const Center(
            child: Text(
              'Placeholder',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
