import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/shared_widgets/custom_button.dart';
import 'package:stylish/core/utils/app_assets.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/features/home/data/models/product_model.dart';
import 'package:stylish/features/home/presention/widgets/banner_item.dart';
import 'package:stylish/features/home/presention/widgets/size_selection_item.dart';

import '../widgets/color_selection_item.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            headerScreen(context, productModel),
            Padding(
              padding: const EdgeInsets.all(8.0).w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: AppColors.mainColor,
                      ),
                      Text(productModel.rating!),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    productModel.name!,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    productModel.description!,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: AppColors.neutral4),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Text(
                    "Color :",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  ColorSelectionItem(colors: productModel.colors!,),
                  Text(
                    "Color :",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  SizeSelectionItem(sizes: ["S","M","L","XL","XXL"],),
        
        
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Material(
        elevation: 5,
        child: SizedBox(
          height: 85.h,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25).w,
                child: Text("\$ ${productModel.price.toDouble()}",style: Theme.of(context).textTheme.displaySmall,),
              ),
              Container(
                width: 2.w,
                height: 30.h,
                color: AppColors.neutral5,
              ),
              SizedBox(
                width: 8.w,
              ),
              IconButton(onPressed: (){}, icon: Icon(Icons.favorite_outline),color: AppColors.mainColor,),
              CustomButton(widget: Text("Add To Cart",style: Theme.of(context).textTheme.labelSmall!.copyWith(color: AppColors.neutral9),), onPressed: (){}, height: 40, width: 138)
            ],
          ),
        ),
      ),
    );
  }
}

Widget headerScreen(BuildContext context, ProductModel productModel) {
  return Stack(
    children: [
      SizedBox(
          height: 350.h,
          width: double.infinity,
          child: BannerItem(
            listOfImages: productModel.headImages!,
            alignment: Alignment.bottomRight,
          )),
      Padding(
        padding: const EdgeInsets.only(top: 55, left: 10),
        child: TextButton(
            onPressed: () => Navigator.pop(context),
            child: Image.asset(AppAssets.vector)),
      ),
    ],
  );
}
