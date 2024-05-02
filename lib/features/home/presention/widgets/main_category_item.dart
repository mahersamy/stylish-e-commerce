import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/home_model.dart';


class MainCategoryItem extends StatelessWidget {
  const MainCategoryItem({super.key, required this.categoryModel});
  final CategoryModel categoryModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0,right: 25.0,left: 25.0,bottom: 2).w,
      child: Image.network(categoryModel.image,fit: BoxFit.cover,),
    );
  }
}
