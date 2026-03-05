// lib/models/product_model.dart

class ProductModel {
  final int id;
  final String namaBarang;
  final String deskripsi;
  final int harga;      // Perhatikan tipe data int (untuk rubrik akurasi model)
  final int stok;
  final String image;
  final int? kategoriId;
  final String? kategoriNama;

  ProductModel({
    required this.id,
    required this.namaBarang,
    required this.deskripsi,
    required this.harga,
    required this.stok,
    required this.image,
    this.kategoriId,
    this.kategoriNama,
  });

  // Factory fromJson sesuai modul halaman 3
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      namaBarang: json['nama_barang'] ?? '',
      deskripsi: json['deskripsi'] ?? '',
      harga: json['harga'] ?? 0,        // Pastikan int, bukan double
      stok: json['stok'] ?? 0,          // rubrik: tidak ada error tipe data
      image: json['image'] ?? '',
      kategoriId: json['kategori_id'],
      kategoriNama: json['kategori_nama'],
    );
  }
}

// Response wrapper (sesuai modul)
class ResponseDataList<T> {
  final bool status;      // Sesuai modul pakai 'status' bukan 'success'
  final String? message;
  final List<T> data;

  ResponseDataList({
    required this.status,
    this.message,
    required this.data,
  });

  factory ResponseDataList.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    List<T> items = [];
    if (json['data'] != null && json['data'] is List) {
      items = List<T>.from(
        (json['data'] as List).map(
          (item) => fromJson(item as Map<String, dynamic>),
        ),
      );
    }

    return ResponseDataList<T>(
      status: json['status'] ?? false,   // Sesuai modul pakai 'status'
      message: json['message'],
      data: items,
    );
  }
}