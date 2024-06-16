import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/helpers/extentions.dart';

import '../../../../core/routes/app_route.dart';
import '../../../../core/utils/app_colors.dart';
import '../../data/models/product_model.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>context.pushNamed(Routes.productDetailScreen,arguments: [productModel]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 170.h,
            width: 150.w,
            decoration: BoxDecoration(
              color: const Color(0xffD9D9D9),
              image: DecorationImage(
                  image: NetworkImage(productModel.image), fit: BoxFit.fill),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            productModel.name,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const Spacer(),
          Text(
            "\$ ${productModel.price}",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.mainColor),
          ),
        ],
      ),
    );
  }
}
