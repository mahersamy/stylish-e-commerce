import 'package:stylish/features/home/data/models/product_model.dart';

class CartModel{
  ProductModel productModel;
  int quantity;
  String selectedColor;
  String selectedSize;

  CartModel({
    required this.productModel,
    required this.quantity,
    required this.selectedColor,
    required this.selectedSize
  });

  toJson(){
    return {
      "productModel":productModel.toJson(),
      "quantity":quantity,
      "selectedColor":selectedColor,
      "selectedSize":selectedSize,
    };
  }
}