import 'package:flutter/material.dart';
import 'package:toko_online/widgets/bottom_nav.dart';

class AktivitasView extends StatefulWidget {
  const AktivitasView({super.key});

  @override
  State<AktivitasView> createState() => _AktivitasViewState();
}

class _AktivitasViewState extends State<AktivitasView> {
  int selectedTab = 0;

  final List<Map<String, dynamic>> aktivitas = [
    {
      "tanggal": "18 Jan, 17:36",
      "judul": "Penjualan Beras Premium",
      "image": "assets/beras_premium.png",
      "status": "Selesai",
      "harga": 11500,
    },
    {
      "tanggal": "15 Jan, 16:14",
      "judul": "Restock Susu Fresh Milk",
      "image": "assets/fresh_milk.png",
      "status": "Selesai",
      "harga": 7500,
    },
    {
      "tanggal": "14 Jan, 16:23",
      "judul": "Pesanan Topokki Korean",
      "image": "assets/topokki_korean.png",
      "status": "Diproses",
      "harga": 31000,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNav(1),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// HEADER
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Aktivitas",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: const [
                      Icon(Icons.help_outline),
                      SizedBox(width: 12),
                      Icon(Icons.download),
                    ],
                  ),
                ],
              ),
            ),

            /// TAB MENU
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _tabItem("Riwayat", 0),
                  _tabItem("Dalam Proses", 1),
                  _tabItem("Terjadwal", 2),
                  _tabItem("Draf", 3),
                ],
              ),
            ),

            const SizedBox(height: 12),

            /// LIST AKTIVITAS
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: aktivitas.length,
                itemBuilder: (context, index) {
                  final item = aktivitas[index];
                  return _aktivitasCard(item);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// TAB ITEM
  Widget _tabItem(String title, int index) {
    final bool isActive = selectedTab == index;
    return GestureDetector(
      onTap: () {
        setState(() => selectedTab = index);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isActive ? Color.fromARGB(255, 46, 125, 50) : Colors.transparent,
              width: 3,
            ),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: isActive ? Color.fromARGB(255, 46, 125, 50) : Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _aktivitasCard(Map<String, dynamic> item) {
    final bool selesai = item['status'] == "Selesai";

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// HEADER STATUS
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item['tanggal'],
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
                Text(
                  selesai ? "Selesai" : "Perlu Dikirim",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: selesai ? Colors.green : Colors.orange,
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          /// PRODUK
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// IMAGE
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    item['image'],
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),

                /// INFO
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['judul'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "1 produk",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          /// TOTAL & BUTTON
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black),
                    children: [
                      const TextSpan(
                        text: "Total Pesanan: ",
                        style: TextStyle(fontSize: 13),
                      ),
                      TextSpan(
                        text: "Rp ${item['harga']}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: selesai ? Colors.green : Colors.orange,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    selesai ? "Detail" : "Atur Pengiriman",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
