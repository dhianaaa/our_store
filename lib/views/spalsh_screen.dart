import 'package:flutter/material.dart';

class Splash_screen extends StatefulWidget {
  const Splash_screen({super.key});

  @override
  State<Splash_screen> createState() => _Splash_screenState();
}

class _Splash_screenState extends State<Splash_screen> {
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 254, 214, 81),
      body: Center(
      child: splashhD(context, 0),
        
    ),
    );
  }
  Widget splashhD(BuildContext context, int index) {
  return Column(mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon( 
        Icons.shopping_cart,
        color: Colors.white,
        size: 80,
      ),
    ],
  );
}
}