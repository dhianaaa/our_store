// lib/models/user_login.dart

import 'package:shared_preferences/shared_preferences.dart';

class UserLogin {
  bool status;
  String? token;
  String? namaUser;
  String? message;
  int? id;
  String? email;
  String? role;

  UserLogin({
    this.status = false, 
    this.token, 
    this.namaUser,
    this.message,
    this.id,
    this.email,
    this.role,
  });

  // Simpan data login ke SharedPreferences
  Future<void> prefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token ?? '');
    await prefs.setString('nama_user', namaUser ?? '');
    await prefs.setInt('user_id', id ?? 0);
    await prefs.setString('email', email ?? '');
    await prefs.setString('role', role ?? '');
    await prefs.setBool('is_login', status);
  }

  // Ambil data login dari SharedPreferences
  Future<UserLogin> getUserLogin() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    bool isLogin = prefs.getBool('is_login') ?? false;
    
    if (token != null && token.isNotEmpty && isLogin) {
      return UserLogin(
        status: true,
        token: token,
        namaUser: prefs.getString('nama_user'),
        id: prefs.getInt('user_id'),
        email: prefs.getString('email'),
        role: prefs.getString('role'),
      );
    } else {
      return UserLogin(status: false);
    }
  }

  // Hapus data login (logout)
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('nama_user');
    await prefs.remove('user_id');
    await prefs.remove('email');
    await prefs.remove('role');
    await prefs.setBool('is_login', false);
  }
}