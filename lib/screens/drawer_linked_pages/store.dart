import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:nash_app_2/screens/map_screen.dart';

class Store extends StatefulWidget {
  const Store({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://www.nashtackle.co.uk/en/tackle/'));
  }

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
                MaterialPageRoute(builder: (context) => const MapScreen()),
              );
            },
          ),
        ],
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
