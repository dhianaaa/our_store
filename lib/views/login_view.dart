import 'package:flutter/material.dart';
import 'package:toko_online/services/user.dart';
import 'package:toko_online/widgets/alert.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  UserService user = UserService();
  final formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isLoading = false;
  bool showPass = true;
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 254, 246),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// HEADER
            Container(
              height: size.height * 0.38, // ⬅ lebih mirip desain
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color.fromARGB(255, 254, 220, 84), Color.fromARGB(255, 255, 215, 35)],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                  bottomRight: Radius.circular(60),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.shopping_cart, color: Colors.white, size: 64),
                  SizedBox(height: 3),// ⬅ jarak antara icon dan teks
                  Text(
                    "Our Store",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(height: 25), // ⬅ jarak antara teks
                ],
              ),
            ),

            /// CARD LOGIN
            Transform.translate(
              offset: const Offset(0, -70), // ⬅ naik sedikit
              child: Container(
                width: size.width * 0.9,
                padding: const EdgeInsets.fromLTRB(24, 30, 24, 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 25,
                    ),
                  ],
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const Text(
                        "Welcome back !",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 30),

                      /// EMAIL
                      _inputField(
                        controller: email,
                        hint: "E-mail",
                        icon: Icons.alternate_email,
                        validator: (v) =>
                            v!.isEmpty ? "Email harus diisi" : null,
                      ),

                      const SizedBox(height: 18),

                      /// PASSWORD
                      _inputField(
                        controller: password,
                        hint: "Password",
                        icon: Icons.lock_outline,
                        obscure: showPass,
                        suffix: IconButton(
                          icon: Icon(
                            showPass ? Icons.visibility_off : Icons.visibility,
                            size: 16,
                          ),
                          onPressed: () {
                            setState(() => showPass = !showPass);
                          },
                        ),
                        validator: (v) =>
                            v!.isEmpty ? "Password harus diisi" : null,
                      ),

                      const SizedBox(height: 14),

                      /// REMEMBER
                      Row(
                        children: [
                          Checkbox(
                            value: rememberMe,
                            activeColor: const Color.fromARGB(255, 243, 194, 33),
                            onChanged: (v) {
                              setState(() => rememberMe = v!);
                            },
                          ),
                          const Text("Remember me", 
                          style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500)),
                          const Spacer(),
                          const Text(
                            "Forget password?",
                            style: TextStyle(fontSize: 12, color: Color.fromARGB(255, 243, 177, 33)),
                          ),
                        ],
                      ),

                      const SizedBox(height: 22),

                      /// LOGIN BUTTON
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Color.fromARGB(255, 243, 177, 33),
                              width: 1.6,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              setState(() => isLoading = true);

                              var data = {
                                "email": email.text,
                                "password": password.text,
                              };

                              var result = await user.loginUser(data);
                              setState(() => isLoading = false);

                              if (result.status == true) {
                                AlertMessage().showAlert(
                                  context,
                                  result.message,
                                  true,
                                );
                                Future.delayed(const Duration(seconds: 2), () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    '/dashboard',
                                  );
                                });
                              } else {
                                AlertMessage().showAlert(
                                  context,
                                  result.message,
                                  false,
                                );
                              }
                            }
                          },
                          child: isLoading
                              ? const CircularProgressIndicator()
                              : const Text(
                                  "Login",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 243, 198, 33),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),

                      const SizedBox(height: 18),// ⬅ jarak tombol login dan teks bawah
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// INPUT FIELD (UI ONLY)
  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    Widget? suffix,
    bool obscure = false,
    String? Function(String?)? validator,
  }) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        validator: validator,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon),
          suffixIcon: suffix,
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
