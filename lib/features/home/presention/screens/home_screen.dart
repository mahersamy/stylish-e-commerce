import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/helpers/extentions.dart';
import 'package:stylish/core/routes/app_route.dart';
import 'package:stylish/core/shared_widgets/custom_circular.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/features/home/data/models/home_model.dart';
import 'package:stylish/features/home/logic/cubits/home_cubit.dart';
import 'package:stylish/features/home/presention/widgets/circular_category_item.dart';
import 'package:stylish/features/home/presention/widgets/custom_grid_view.dart';

import '../../../../core/helpers/toast_helper.dart';
import '../widgets/banner_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<HomeCubit>(context).getHome();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeError) {
          ToastHelper().showErrorToast(state.message);
        }
      },
      builder: (context, state) {
        if (state is HomeSuccess || BlocProvider.of<HomeCubit>(context).homeModel != null) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 222.h,
                    width: double.infinity,
                    child: BannerItem(
                      listOfImages: BlocProvider.of<HomeCubit>(context).homeModel!.banner,
                    ),
                  ),
                  category(context, BlocProvider.of<HomeCubit>(context).homeModel!),
                  SizedBox(
                    height: 10.h,
                  ),
                  hotDealHeader(context),
                  CustomGridView(productModel: BlocProvider.of<HomeCubit>(context).homeModel!.products),
                ],
              ),
            ),
          );
        } else {
          return const Center(child: CustomCircular());
        }
      },
    );
  }

  Widget category(BuildContext context, HomeModel homeModel) {
    return SizedBox(
      height: 200.h,
      child: Column(
        children: [
          categoryHeader(context, homeModel),
          SizedBox(
            height: 5.sp,
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => CircularCategoryItem(
                categoryModel: homeModel.category[index],
                productModels: homeModel.products,
              ),
              itemCount: homeModel.category.length,
            ),
          ),
        ],
      ),
    );
  }

  Row categoryHeader(BuildContext context, HomeModel homeModel) {
    return Row(
      children: [
        Container(
          width: 2.w,
          height: 25.h,
          color: AppColors.mainColor,
        ),
        SizedBox(
          width: 5.w,
        ),
        Text("Categories".toUpperCase(),
            style: Theme.of(context).textTheme.titleLarge),
        const Spacer(),
        TextButton(
          onPressed: () {
            context.pushNamed(Routes.allCategoryScreen,
                arguments: [homeModel.category, homeModel.products]);
          },
          child: Text(
            "All Categories",
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }

  Row hotDealHeader(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 2.w,
          height: 25.h,
          color: AppColors.mainColor,
        ),
        SizedBox(
          width: 5.w,
        ),
        Text("Hot Deals".toUpperCase(),
            style: Theme.of(context).textTheme.titleLarge),
      ],
    );
  }
}
