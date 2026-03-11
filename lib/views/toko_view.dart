import 'package:flutter/material.dart';
import 'package:toko_online/model/response_data_list.dart';
import 'package:toko_online/model/toko_model.dart';
import 'package:toko_online/services/toko.dart';
import 'package:toko_online/widgets/bottom_nav.dart';

class TokoView extends StatefulWidget {
  const TokoView({super.key});

  @override
  State<TokoView> createState() => _TokoViewState();
}

class _TokoViewState extends State<TokoView> {
  int selectedTab = 0;
  ProductService ProductModel = ProductService();
  List? film;
  getFilm() async {
    ResponseDataList getProdukModel = await ProductModel.getProducts();
    setState(() {
      film = getProdukModel.data;
    });
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    getFilm();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Our Product"),
        backgroundColor: const Color.fromARGB(255, 46, 125, 50),
        foregroundColor: Colors.white,
      ),
      body: film != null
          ? ListView.builder(
              itemCount: film!.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: Image(
                      image: NetworkImage(film![index].posterPath),
                    ),
                    title: Text(film![index].title),
                  ),
                );
              },
            )
          : Center(child: CircularProgressIndicator()),
      bottomNavigationBar: BottomNav(1),
    );
  }
}