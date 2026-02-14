import 'package:flutter/material.dart';
import 'package:toko_online/views/dashboard.dart';
import 'package:toko_online/views/login_view.dart';
import 'package:toko_online/views/pesan_view.dart';
import 'package:toko_online/views/register_user_view.dart';
import 'package:toko_online/views/spalsh_screen.dart';
import 'package:toko_online/views/toko_view.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/splash',
    routes: {
      '/login': (context) => LoginView(),
      '/dashboard': (context) => DashboardView(),
      '/splash': (context) => SplashScreen(),
      '/aktivitas': (context) => AktivitasView(),
      '/toko': (context) => TokoView(),
    },
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
    );
  }
}