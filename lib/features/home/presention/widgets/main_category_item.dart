import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/helpers/extentions.dart';

import '../../../../core/routes/app_route.dart';
import '../../data/models/home_model.dart';
import '../../data/models/product_model.dart';


class MainCategoryItem extends StatelessWidget {
  const MainCategoryItem({super.key, required this.categoryModel});
  final CategoryModel categoryModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>context.pushNamed(Routes.categoryScreen,arguments: [categoryModel]),
      child: Padding(
        padding: const EdgeInsets.only(top: 25.0,right: 25.0,left: 25.0,bottom: 2).w,
        child: Image.network(categoryModel.image,fit: BoxFit.fill,),
      ),
    );
  }
}
