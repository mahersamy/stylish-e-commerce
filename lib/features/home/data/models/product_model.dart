import '../../../../core/utils/firebase_strings.dart';

class ProductModel {
  final String name;
  final int price;
  final String image;
  final String? description;
  final List<String>? colors;

  ProductModel(
      {required this.colors,
      required this.name,
      required this.price,
      required this.image,
      required this.description});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json[FirebaseStrings.name],
      price: json[FirebaseStrings.price],
      image: json[FirebaseStrings.image],
      description: json[FirebaseStrings.description],
      colors: List.from(json[FirebaseStrings.colors].map((color) => color.toString())),
    );
  }
}
