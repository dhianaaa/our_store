class ProductModel {
  int? id;
  String? namaBarang;
  String? deskripsi;
  double? harga;
  int? stok;
  String? image;

  ProductModel({
    this.id,
    this.namaBarang,
    this.deskripsi,
    this.harga,
    this.stok,
    this.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      namaBarang: json['nama_barang'],
      deskripsi: json['deskripsi'],
      harga: (json['harga'] as num).toDouble(),
      stok: json['stok'],
      image: json['image'],
    );
  }
}