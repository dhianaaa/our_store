import 'package:flutter/material.dart';
import 'package:toko_online/model/toko_model.dart';
import 'package:toko_online/services/toko.dart';
import 'package:toko_online/widgets/bottom_nav.dart';

class TokoView extends StatefulWidget {
  const TokoView({super.key});

  @override
  State<TokoView> createState() => _TokoViewState();
}

class _TokoViewState extends State<TokoView> {
  String promoTitle = "Kelola Produk Toko Kamu";
  String promoSubtitle = "Tambah, ubah, dan atur promo toko";
  
  late Future<List<ProductModel>> _productsFuture;
  final ProductService _productService = ProductService();
  
  String selectedCategory = "Semua";
  final TextEditingController _searchController = TextEditingController();
  List<ProductModel> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _productsFuture = _productService.getProducts(); // PANGGIL SERVICE
    _searchController.addListener(_filterProducts);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterProducts() {
    // Akan dipanggil otomatis saat search berubah
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      bottomNavigationBar: BottomNav(1),
      body: SafeArea(
        child: Column(
          children: [
            /// HEADER
            Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 46, 125, 50),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white24,
                        child: Icon(Icons.store, color: Colors.white, size: 20),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Toko Online",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Kelola produkmu di sini",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        children: [
                          const CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.white24,
                            child: Icon(Icons.notifications_none, color: Colors.white, size: 18),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  /// SEARCH BAR
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: Colors.grey, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            onChanged: (value) {
                              setState(() {});
                            },
                            decoration: const InputDecoration(
                              hintText: "Cari produk...",
                              border: InputBorder.none,
                              hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ),
                        ),
                        if (_searchController.text.isNotEmpty)
                          GestureDetector(
                            onTap: () {
                              _searchController.clear();
                              setState(() {});
                            },
                            child: const Icon(Icons.close, size: 18, color: Colors.grey),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /// BANNER PROMO
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                height: 130,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color.fromARGB(255, 46, 125, 50),
                      const Color.fromARGB(255, 65, 145, 70),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
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
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            promoSubtitle,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 12),
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
                                  color: Color.fromARGB(255, 46, 125, 50),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.campaign,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// KATEGORI FILTER
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildCategoryChip("Semua"),
                    const SizedBox(width: 8),
                    _buildCategoryChip("Sayuran"),
                    const SizedBox(width: 8),
                    _buildCategoryChip("Buah"),
                    const SizedBox(width: 8),
                    _buildCategoryChip("Susu"),
                    const SizedBox(width: 8),
                    _buildCategoryChip("Makanan"),
                    const SizedBox(width: 8),
                    _buildCategoryChip("Minuman"),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// GRID PRODUK - PAKAI FUTUREBUILDER
            Expanded(
              child: FutureBuilder<List<ProductModel>>(
                future: _productsFuture,
                builder: (context, snapshot) {
                  // LOADING STATE
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                          Text('Memuat produk...'),
                        ],
                      ),
                    );
                  }
                  
                  // ERROR STATE
                  else if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                          const SizedBox(height: 16),
                          Text(
                            snapshot.error.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 14),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _productsFuture = _productService.getProducts();
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 46, 125, 50),
                            ),
                            child: const Text('Coba Lagi'),
                          ),
                        ],
                      ),
                    );
                  }
                  
                  // DATA TERSEDIA
                  else if (snapshot.hasData) {
                    List<ProductModel> allProducts = snapshot.data!;
                    
                    // Filter berdasarkan search
                    List<ProductModel> displayProducts = _searchController.text.isEmpty
                        ? allProducts
                        : allProducts.where((p) => 
                            p.namaBarang.toLowerCase().contains(_searchController.text.toLowerCase())
                          ).toList();
                    
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          /// HEADER JUMLAH PRODUK
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Daftar Produk",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${displayProducts.length} produk",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          
                          /// GRID PRODUK
                          Expanded(
                            child: displayProducts.isEmpty
                                ? Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.inventory_2_outlined, size: 64, color: Colors.grey[400]),
                                        const SizedBox(height: 16),
                                        Text(
                                          'Produk tidak ditemukan',
                                          style: TextStyle(color: Colors.grey[600]),
                                        ),
                                      ],
                                    ),
                                  )
                                : GridView.builder(
                                    itemCount: displayProducts.length,
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 16,
                                      crossAxisSpacing: 16,
                                      childAspectRatio: 0.7,
                                    ),
                                    itemBuilder: (context, index) {
                                      return _productCard(displayProducts[index]);
                                    },
                                  ),
                          ),
                        ],
                      ),
                    );
                  }
                  
                  // EMPTY STATE
                  else {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.inventory_2_outlined, size: 64, color: Colors.grey[400]),
                          const SizedBox(height: 16),
                          const Text('Belum ada produk'),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label) {
    bool isSelected = selectedCategory == label;
    return InkWell(
      onTap: () {
        setState(() {
          selectedCategory = label;
        });
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected 
              ? const Color.fromARGB(255, 46, 125, 50) 
              : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[700],
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _productCard(ProductModel product) {
    final bool tersedia = product.stok > 0;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// IMAGE
          Stack(
            children: [
              Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: product.image.isNotEmpty
                      ? Image.network(
                          product.image,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            color: Colors.grey[300],
                            child: const Icon(Icons.image_not_supported, color: Colors.grey),
                          ),
                        )
                      : Container(
                          color: Colors.grey[300],
                          child: const Icon(Icons.image_not_supported, color: Colors.grey),
                        ),
                ),
              ),
              if (!tersedia)
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "Habis",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              if (product.stok <= 3 && product.stok > 0)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 46, 125, 50),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "Sisa ${product.stok}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.namaBarang,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                
                const SizedBox(height: 4),
                
                Text(
                  product.deskripsi,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 11,
                  ),
                ),
                
                const SizedBox(height: 8),
                
                Text(
                  "Rp ${product.harga}",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 46, 125, 50),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: tersedia ? Colors.green : Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            tersedia ? "Tersedia" : "Habis",
                            style: TextStyle(
                              fontSize: 11,
                              color: tersedia ? Colors.green : Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: tersedia,
                      activeColor: const Color.fromARGB(255, 46, 125, 50),
                      onChanged: product.stok == 0
                          ? null
                          : (value) {
                              setState(() {
                                // Update status
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            "Edit Promo",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 46, 125, 50),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "Judul Promo",
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromARGB(255, 46, 125, 50)),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: subtitleController,
                decoration: const InputDecoration(
                  labelText: "Deskripsi Promo",
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromARGB(255, 46, 125, 50)),
                  ),
                ),
                maxLines: 2,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Batal",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  promoTitle = titleController.text;
                  promoSubtitle = subtitleController.text;
                });
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 46, 125, 50),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text("Simpan"),
            ),
          ],
        );
      },
    );
  }
}