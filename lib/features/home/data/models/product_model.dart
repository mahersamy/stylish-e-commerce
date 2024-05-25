import '../../../../core/utils/firebase_strings.dart';

class ProductModel {
  final String name;
  final int price;
  final int id;
  final String image;
  final List<String>? headImages;
  final String? description;
  final List<String>? sizes;
  final List<String>? colors;
  final String? rating;

  ProductModel(
      {required this.headImages,
      required this.colors,
      required this.name,
      required this.price,
      required this.image,
      required this.description,
      required this.rating,
        required this.sizes,
      required this.id
     });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"],
      name: json[FirebaseStrings.name],
      price: json[FirebaseStrings.price],
      image: json[FirebaseStrings.image],
      description: json[FirebaseStrings.description],
      colors: List.from(
          json[FirebaseStrings.colors].map((color) => color.toString())),
      headImages: List.from(
          json[FirebaseStrings.headImages]),
      sizes:List.from(json[FirebaseStrings.sizes]),
      rating: json[FirebaseStrings.rating],

    );
  }
}
