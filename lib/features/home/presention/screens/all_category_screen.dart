import 'package:flutter/material.dart';
import 'package:stylish/core/shared_widgets/bottom_nav_bar.dart';
import 'package:stylish/features/home/presention/widgets/main_category_item.dart';

import '../../data/models/home_model.dart';
import '../../data/models/product_model.dart';


class AllCategoryScreen extends StatelessWidget {
  const AllCategoryScreen({super.key, required this.categoryModelList});
  final List<CategoryModel> categoryModelList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("categories".toUpperCase(),style: Theme.of(context).textTheme.headlineSmall,),centerTitle: true,),
      body: ListView.builder(
          itemCount: categoryModelList.length,

          itemBuilder: (context, index) {
        return MainCategoryItem(categoryModel: categoryModelList[index]);
      }),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
