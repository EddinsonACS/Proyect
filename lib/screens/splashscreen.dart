import 'package:flutter/material.dart';
import 'package:primerospasosapp/screens/screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticInOut,
    );

    _controller.forward();

    _controller.addListener(() {
      if (_controller.isCompleted) {
        Navigator.pushReplacement(
            context,
            PageRouteBuilder(
                pageBuilder: (_, __, ___) => const CheckAuthScreen(),
                transitionDuration: const Duration(seconds: 0)));
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Scaffold(
          body: Center(
              child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF06606E), Color(0xA9037584)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Transform.scale(
              scale: _animation.value,
              child: Image.asset(
                width: 100,
                height: 100,
                'assets/logo2.png',
              ),
            ),
          )),
        );
      },
    );
  }
}
