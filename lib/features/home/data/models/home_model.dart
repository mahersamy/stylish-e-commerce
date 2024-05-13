import 'package:stylish/core/utils/firebase_strings.dart';
import 'package:stylish/features/home/data/models/product_model.dart';


class HomeModel{
  final List<String> banner;
  final List<CategoryModel> category;
  final List<ProductModel> products;
  HomeModel({required this.products,required this.category, required this.banner});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      products: List<ProductModel>.from(json[FirebaseStrings.products].map((x) => ProductModel.fromJson(x))),
      banner: List<String>.from(json[FirebaseStrings.banner]),
      category: List<CategoryModel>.from(json[FirebaseStrings.categories].map((x) => CategoryModel.fromJson(x))),
    );
  }
}

class CategoryModel{
  final String name;
  final String image;

  CategoryModel({required this.name, required this.image});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      name: json[FirebaseStrings.name],
      image: json[FirebaseStrings.image],
    );
  }

}