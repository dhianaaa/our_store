// lib/services/product_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:toko_online/model/toko_model.dart';
import 'package:toko_online/model/user_login.dart';
import 'package:toko_online/services/url.dart' as url;

class ProductService {
  Future<ResponseDataList<ProductModel>> getProduct() async {
    try {
      // 1. AMBIL TOKEN
      UserLogin userLogin = UserLogin();
      var user = await userLogin.getUserLogin();

      // 2. CEK LOGIN
      if (user.status == false || user.token == null) {
        print("❌ ERROR: User belum login");
        return ResponseDataList<ProductModel>(
          status: false,
          message: 'Anda belum login / token invalid',
          data: [],
        );
      }

      print("✅ Token: ${user.token}");

      // 3. ENDPOINT
      var uri = Uri.parse("${url.BaseUrl}/admin/getbarang");
      print("📡 URL: $uri");

      // 4. HEADER
      Map<String, String> headers = {
        "Authorization": 'Bearer ${user.token}',
        "Accept": "application/json",
      };

      // 5. REQUEST
      var response = await http.get(uri, headers: headers);
      
      print("📥 Status: ${response.statusCode}");
      print("📦 Body: ${response.body}");

      // 6. CEK RESPONSE
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        
        if (data['status'] == true) {
          List<ProductModel> products = [];
          
          if (data['data'] != null && data['data'] is List) {
            products = (data['data'] as List)
                .map((item) => ProductModel.fromJson(item))
                .toList();
          }
              
          return ResponseDataList<ProductModel>(
            status: true,
            message: 'Success load data',
            data: products,
          );
        } else {
          return ResponseDataList<ProductModel>(
            status: false,
            message: data['message'] ?? 'Failed load data',
            data: [],
          );
        }
      } else {
        return ResponseDataList<ProductModel>(
          status: false,
          message: "Error ${response.statusCode}",
          data: [],
        );
      }
    } catch (e) {
      print("❌ Exception: $e");
      return ResponseDataList<ProductModel>(
        status: false,
        message: "Error: $e",
        data: [],
      );
    }
  }
}