import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:toko_online/services/user.dart';
import 'package:toko_online/widgets/alert.dart';

class RegisterUserView extends StatefulWidget {
  const RegisterUserView({super.key});

  @override
  State<RegisterUserView> createState() => _RegisterUserViewState();
}

class _RegisterUserViewState extends State<RegisterUserView> {
  UserService user = UserService();
  final formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  List<String> roleChoice = ["admin", "user"];
  String? role;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 35, 81, 107),
              Color.fromARGB(255, 14, 51, 94),
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  width: 350,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                    ),
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Icon(Icons.real_estate_agent_rounded,
                              size: 70, color: Colors.white),
                        ),
                        const Text(
                          "REGISTER USER",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 25),

                        /// NAME
                        _inputField(
                          controller: name,
                          label: "Nama",
                          icon: Icons.person,
                          validator: (v) =>
                              v!.isEmpty ? "Nama wajib diisi" : null,
                        ),
                        const SizedBox(height: 15),

                        /// EMAIL
                        _inputField(
                          controller: email,
                          label: "Email",
                          icon: Icons.email,
                          validator: (v) =>
                              v!.isEmpty ? "Email wajib diisi" : null,
                        ),
                        const SizedBox(height: 15),

                        /// ROLE
                        DropdownButtonFormField<String>(
                          dropdownColor: const Color.fromARGB(255, 13, 89, 151),
                          value: role,
                          style: const TextStyle(color: Colors.white),
                          decoration: _glassDecoration(
                            label: "Role",
                            icon: Icons.badge,
                          ),
                          items: roleChoice.map((r) {
                            return DropdownMenuItem(
                              value: r,
                              child: Text(
                                r.toUpperCase(),
                                style: const TextStyle(color: Colors.white),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() => role = value);
                          },
                          validator: (value) =>
                              value == null ? "Role harus dipilih" : null,
                        ),
                        const SizedBox(height: 15),

                        /// PASSWORD
                        _inputField(
                          controller: password,
                          label: "Password",
                          icon: Icons.lock,
                          obscure: true,
                          validator: (v) =>
                              v!.isEmpty ? "Password wajib diisi" : null,
                        ),
                        const SizedBox(height: 25),

                        /// BUTTON
                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white.withOpacity(0.85),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                var data = {
                                  "name": name.text,
                                  "email": email.text,
                                  "role": role,
                                  "password": password.text,
                                };

                                var result =
                                    await user.registerUser(data);

                                AlertMessage().showAlert(
                                  context,
                                  result.message,
                                  result.status,
                                );

                                if (result.status == true) {
                                  name.clear();
                                  email.clear();
                                  password.clear();
                                  setState(() => role = null);
                                }
                              }
                            },
                            child: const Text(
                              "REGISTER",
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        const Text(
                          "Toko Management System",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// =======================
  /// WIDGET REUSABLE
  /// =======================
  Widget _inputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscure = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      style: const TextStyle(color: Colors.white),
      decoration: _glassDecoration(label: label, icon: icon),
      validator: validator,
    );
  }

  InputDecoration _glassDecoration({
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      prefixIcon: Icon(icon, color: Colors.white70),
      filled: true,
      fillColor: Colors.white.withOpacity(0.12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}