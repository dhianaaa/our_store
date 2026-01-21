import 'package:flutter/material.dart';
import 'package:toko_online/model/user_login.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  UserLogin userLogin = UserLogin();
  String? nama;
  String? role;

  getUserLogin() async {
    var user = await userLogin.getUserLogin();
    if (user.status != false) {
      setState(() {
        nama = user.nama_user;
        role = user.role;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUserLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 235, 221, 22),
              Color.fromARGB(255, 211, 201, 15),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// HEADER
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Our Store",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8),
                      const SizedBox(height: 16), // Spacing
                      Text(
                        "Selamat datang, ${nama ?? '-'}",
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Role anda sebagai : ${role ?? '-'}",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),

              /// CONTENT
              Expanded(
                // to fill the remaining space
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),

                      /// LOGOUT
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Color.fromARGB(255, 243, 187, 33),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          onPressed: () {
                            _confirmLogout(context);
                          },

                          child: const Text(
                            "Log out",
                            style: TextStyle(
                              color: Color.fromARGB(255, 243, 177, 33),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _confirmLogout(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            "Log out",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Colors.red),
          ),
          content: const Text("Apakah kamu yakin ingin log out?",style: TextStyle(fontSize: 12),),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // tutup dialog
              },
              child: const Text("Batal", style: TextStyle(color: Color.fromARGB(255, 82, 82, 82),)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // tutup dialog
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text("Log out", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
