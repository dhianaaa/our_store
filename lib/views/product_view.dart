import 'package:flutter/material.dart';
import 'package:toko_online/model/toko_model.dart';
import '../services/product_service.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {

  List<ProductModel>? products;
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    final data = await ProductService().getProducts();

    setState(() {
      products = data;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // contoh navigasi
    if (index == 0) {
      Navigator.pushNamed(context, "/home");
    } else if (index == 2) {
      Navigator.pushNamed(context, "/profile");
    }
  }

  @override
  Widget build(BuildContext context) {

    if (products == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Produk"),
      ),

      body: ListView.builder(
        itemCount: products!.length,
        itemBuilder: (context, index) {

          final product = products![index];

          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: Image.network(product.image ?? ""),
              title: Text(product.namaBarang ?? ""),
              subtitle: Text("Stok : ${product.stok}"),
              trailing: Text("Rp ${product.harga}"),
            ),
          );
        },
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: "Produk",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profil",
          ),
        ],
      ),
    );
  }
}