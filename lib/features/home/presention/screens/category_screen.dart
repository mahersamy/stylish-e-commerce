import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/shared_widgets/custom_circular.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/features/home/logic/cubits/home_cubit.dart';

import '../../../../core/helpers/toast_helper.dart';
import '../../data/models/home_model.dart';
import '../widgets/custom_grid_view.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key, required this.categoryModel});

  final CategoryModel categoryModel;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {



  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeCubit>(context).getCategoryProduct(widget.categoryModel.name);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is GetCategoryProductError) {
          ToastHelper().showErrorToast("Something went wrong");
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              SizedBox(
                height: 250.h,
                width: double.infinity,
                child: Image.network(
                  widget.categoryModel.image,
                  fit: BoxFit.fill,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.h),
                        height: 620.h,
                        color: AppColors.neutral9,
                        child: state is GetCategoryProductSuccess || BlocProvider.of<HomeCubit>(context).categoryProductList.isNotEmpty
                            ? CustomGridView(
                                productModel: BlocProvider.of<HomeCubit>(context).categoryProductList,
                              )
                            : const Center(child: CustomCircular()),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
