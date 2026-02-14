import '../services/url.dart' as url;

class ProductModel {
  int id;
  String namaBarang;
  String deskripsi;
  int harga;
  int stok;
  String image;

  ProductModel({
    required this.id,
    required this.namaBarang,
    required this.deskripsi,
    required this.harga,
    required this.stok,
    required this.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    int parseInt(dynamic v) => int.tryParse(v?.toString() ?? '') ?? 0;

    final rawImage =
        json['image'] ??
        json['gambar'] ??
        json['foto'] ??
        json['posterPath'] ??
        json['posterpath'] ??
        '';
    String resolvedImage;
    if (rawImage == null || rawImage.toString().isEmpty) {
      resolvedImage = '';
    } else {
      final s = rawImage.toString();
      resolvedImage = s.startsWith('http') ? s : '${url.BaseUrlTanpaAPi}/$s';
    }

    return ProductModel(
      id: parseInt(json['id'] ?? json['ID']),
      namaBarang:
          json['namaBarang'] ?? json['nama_barang'] ?? json['title'] ?? '',
      deskripsi:
          json['deskripsi'] ?? json['description'] ?? json['overview'] ?? '',
      harga: parseInt(json['harga'] ?? json['price']),
      stok: parseInt(json['stok'] ?? json['stock']),
      image: resolvedImage,
    );
  }
}
