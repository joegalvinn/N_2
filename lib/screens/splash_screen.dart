import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'map_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    // Set the system UI to immersive sticky to hide the status and navigation bars
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
        overlays: []);
    Future.delayed(Duration.zero, () {
      setState(() {
        _opacity = 1.0;
      });
    });

    // Navigate after the fade-out animation
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _opacity = 0.0;
      });
      Future.delayed(const Duration(seconds: 1), () {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const MapScreen(),
          ),
        );
      });
    });
  }

  @override
  void dispose() {
    // Restore system UI overlays when the splash screen is disposed
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedOpacity(
        duration: const Duration(seconds: 1),
        opacity: _opacity,
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: Image.asset(
              'images/splash-gif.gif',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
