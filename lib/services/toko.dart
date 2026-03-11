import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:toko_online/model/product_model.dart';
import 'package:toko_online/model/response_data_list.dart';
import 'package:toko_online/model/user_login.dart';
import 'package:toko_online/services/url.dart' as url;

class ProductService {

  Future<ResponseDataList<ProductModel>> getProducts() async {

    UserLogin userLogin = UserLogin();
    var user = await userLogin.getUserLogin();

    if (user!.status == false) {
      return ResponseDataList<ProductModel>(
        status: false,
        message: 'anda belum login / token invalid',
        data: [],
      );
    }

    var uri = Uri.parse(url.BaseUrl + "admin/getbarang");

    Map<String, String> headers = {
      "Authorization": 'Bearer ${user.token}'
    };

    var getBarang = await http.get(uri, headers: headers);

    if (getBarang.statusCode == 200) {

      var data = json.decode(getBarang.body);

      if (data["status"] == true) {

        List<ProductModel> products =
            (data["data"] as List).map((r) => ProductModel.fromJson(r)).toList();

        return ResponseDataList<ProductModel>(
          status: true,
          message: 'success load data',
          data: products,
        );

      } else {

        return ResponseDataList<ProductModel>(
          status: false,
          message: 'Failed load data',
          data: [],
        );

      }

    } else {

      return ResponseDataList<ProductModel>(
        status: false,
        message: "gagal load barang dengan code error ${getBarang.statusCode}",
        data: [],
      );

    }
  }
}