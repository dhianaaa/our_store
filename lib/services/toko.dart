import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toko_online/model/toko_model.dart';

class ProductService {
  static const String baseUrl = "https://learn.smktelkom-mlg.sch.id";
  static const String endpoint = "/admin/getbarang"; // Sesuaikan!

  Future<List<ProductModel>> getProducts() async {
    try {
      // 1. Ambil token dari SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('user_token'); // Sesuaikan key penyimpanan

      if (token == null || token.isEmpty) {
        throw Exception('Token tidak ditemukan. Silakan login ulang.');
      }

      // 2. Panggil API dengan Bearer Token
      var uri = Uri.parse('$baseUrl$endpoint');
      var response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      // 3. Handle response
      if (response.statusCode.toString().startsWith('2')) {
        var jsonData = json.decode(response.body);
        
        // Sesuaikan dengan struktur response API kamu
        // Jika response: {"status": true, "data": [...]}
        if (jsonData['status'] == true && jsonData['data'] != null) {
          List<dynamic> dataList = jsonData['data'];
          return dataList.map((item) => ProductModel.fromJson(item)).toList();
        } else {
          return [];
        }
      } else if (response.statusCode == 401) {
        throw Exception('Token tidak valid. Silakan login ulang.');
      } else {
        throw Exception('Gagal memuat data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}