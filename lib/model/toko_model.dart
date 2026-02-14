import 'package:toko_online/services/url.dart' as url;

class ProductModel {
  int? id;
  String? title;
  double? voteAverage;
  String? overview;
  String? posterPath;
  ProductModel({
    required this.id,
    required this.title,
    this.voteAverage,
    this.overview,
    required this.posterPath,
  });
  ProductModel.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson["id"];
    title = parsedJson["title"];
    voteAverage = double.parse(parsedJson["voteaverage"].toString());
    overview = parsedJson["overview"];
    posterPath = "${url.BaseUrlTanpaAPi}/${parsedJson["posterpath"]}";
  }
}
