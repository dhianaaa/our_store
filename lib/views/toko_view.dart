import 'package:flutter/material.dart';
import 'package:toko_online/widgets/bottom_nav.dart';

class TokoView extends StatefulWidget {
  const TokoView({super.key});

  @override
  State<TokoView> createState() => _TokoViewState();
}

class _TokoViewState extends State<TokoView> {
  String promoTitle = "Kelola Produk Toko Kamu";
  String promoSubtitle = "Tambah, ubah, dan atur promo toko";

  final List<Map<String, dynamic>> products = [
    {
      "nama": "Organic Green Capsicum",
      "gambar": "assets/green_capsicum.png",
      "harga": 24000,
      "detail": "Capsicum hijau organik segar",
      "stok": 12,
      "tersedia": true,
    },
    {
      "nama": "Topokki Korean",
      "gambar": "assets/topokki_korean.png",
      "detail": "Topokki korean rasa pedas",
      "harga": 24000,
      "stok": 6,
      "tersedia": true,
    },
    {
      "nama": "Fresh Milk 1L",
      "gambar": "assets/fresh_milk.png",
      "detail": "Susu segar full cream 1 liter",
      "harga": 24000,
      "stok": 1,
      "tersedia": true,
    },
    {
      "nama": "Cavendish Banana",
      "gambar": "assets/cavendish_banana.png",
      "detail": "Pisang cavendish segar",
      "harga": 12000,
      "stok": 0,
      "tersedia": false,
    },
    {
      "nama": "Avocado",
      "gambar": "assets/avocado.png",
      "detail": "Alpukat segar pilihan",
      "harga": 15000,
      "stok": 0,
      "tersedia": false,
    },
    {
      "nama": "Strawberry",
      "gambar": "assets/strawberry.png",
      "detail": "Stroberi merah manis",
      "harga": 12000,
      "stok": 2,
      "tersedia": true,
    },
    {
      "nama": "grapefruit",
      "gambar": "assets/grape.png",
      "detail": "Anggur segar pilihan",
      "harga": 16000,
      "stok": 1,
      "tersedia": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNav(1),
      body: SafeArea(
        child: Column(
          children: [
            /// HEADER
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: const [
                  Text(
                    "Online Store",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  CircleAvatar(radius: 16),
                ],
              ),
            ),

            /// BANNER PROMO
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.green.shade800,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    /// TEXT PROMO
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            promoTitle,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            promoSubtitle,
                            style: const TextStyle(color: Colors.white70),
                          ),
                          const SizedBox(height: 12),

                          /// BUTTON EDIT
                          InkWell(
                            onTap: () => _showEditPromoDialog(),
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                "Edit Promo",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Icon(Icons.campaign, color: Colors.white, size: 42),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// GRID PRODUK
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  itemCount: products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (context, index) {
                    return _productCard(products[index]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// CARD PRODUK
  Widget _productCard(Map<String, dynamic> product) {
    final bool tersedia = product['tersedia'];
    final int stok = product['stok'];

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// IMAGE
          Container(
            height: 135,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Center(
              child: Image.asset(product['gambar'], fit: BoxFit.cover),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product['nama'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                Text(
                  "Rp ${product['harga']}",
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(product['detail'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                    )),
                const SizedBox(height: 27),

                /// STATUS + ADD
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        tersedia ? "Tersedia" : "Habis",
                        style: TextStyle(
                          fontSize: 12,
                          color: tersedia ? Colors.green : Colors.red,
                        ),
                      ),
                    ),
                    Switch(
                      value: tersedia,
                      activeColor: Colors.green,
                      onChanged: stok == 0
                          ? null
                          : (value) {
                              setState(() {
                                product['tersedia'] = value;
                              });
                            },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showEditPromoDialog() {
    final titleController = TextEditingController(text: promoTitle);
    final subtitleController = TextEditingController(text: promoSubtitle);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Promo Toko"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Judul Promo"),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: subtitleController,
                decoration: const InputDecoration(labelText: "Deskripsi Promo"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  promoTitle = titleController.text;
                  promoSubtitle = subtitleController.text;
                });
                Navigator.pop(context);
              },
              child: const Text("Simpan"),
            ),
          ],
        );
      },
    );
  }
}
