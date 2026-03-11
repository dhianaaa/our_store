
import 'package:toko_online/services/url.dart' as url;

class Product_Model {
int? id;
String? title;
double? voteAverage;
String? overview;
String? posterPath;
Product_Model({
required this.id,
required this.title,
this.voteAverage,
this.overview,
required this.posterPath,
});
Product_Model.fromJson(Map<String, dynamic> parsedJson) {
id = parsedJson["id"];
title = parsedJson["title"];
voteAverage = double.parse(parsedJson["voteaverage"].toString());
overview = parsedJson["overview"];
posterPath = "${url.BaseUrlTanpaAPi}/${parsedJson["posterpath"]}";
}
}