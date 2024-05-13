import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/features/home/data/models/product_model.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          CachedNetworkImage(imageUrl: productModel.image),
          const Row(
            children: [
               Icon(
                Icons.star,
                color: AppColors.mainColor,
              ),

            ],
          )
        ],
      ),
    );
  }
}
