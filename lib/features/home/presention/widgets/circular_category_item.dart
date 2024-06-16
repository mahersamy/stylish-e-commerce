import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/helpers/extentions.dart';
import 'package:stylish/features/home/data/models/home_model.dart';

import '../../../../core/routes/app_route.dart';
import '../../data/models/product_model.dart';



class CircularCategoryItem extends StatelessWidget {
  const CircularCategoryItem({super.key, required this.categoryModel, required this.productModels,});
  final CategoryModel categoryModel;
  final List<ProductModel> productModels;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>context.pushNamed(Routes.categoryScreen,arguments: [categoryModel,productModels]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CircleAvatar(radius: 35.w,child: ClipOval(
              child: Image.network(categoryModel.image,fit: BoxFit.fill,height: 100.h,width: 100.w,),
            ),),
            SizedBox(height: 5.sp,),
            Text(categoryModel.name,style: Theme.of(context).textTheme.labelSmall,),
          ],
        ),
      ),
    );
  }
}
