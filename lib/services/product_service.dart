import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:toko_online/model/toko_model.dart';
import 'package:toko_online/model/user_login.dart';
import 'package:toko_online/services/url.dart';

class ProductService {
  Future<List<ProductModel>> getProducts() async {
    final user = await UserLogin().getUserLogin();

    final response = await http.get(
      Uri.parse(BaseUrl + "admin/getbarang"),
      headers: {
        "Authorization": "Bearer ${user.token}",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      List list = json['data'];

      return list.map((e) => ProductModel.fromJson(e)).toList();
    } else {
      throw Exception("Gagal mengambil data produk");
    }
  }
}
