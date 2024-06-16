import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/features/home/presention/widgets/product_item.dart';

import '../../data/models/product_model.dart';


class CustomGridView extends StatelessWidget {
  const CustomGridView({super.key, this.productModel=const []});
  final List<ProductModel> productModel;
  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: productModel.isNotEmpty,
      fallback: (context)=> const Center(child: Text("We did not found any product")),
      builder: (context)=> GridView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          primary: false,
          padding: EdgeInsets.only(top:10.h ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10.h,
            crossAxisSpacing: 10.w,
            childAspectRatio: 0.8,
          ),
          itemCount: productModel.length,
          itemBuilder: (context, index) =>
              ProductItem(productModel: productModel[index])),
    );
  }
}
