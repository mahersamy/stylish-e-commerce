import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
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

import '../widgets/banner_item.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

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
          print(state.message);
        }
      },
      builder: (context, state) {
        if (state is HomeSuccess) {
          return Column(
            children: [
              SizedBox(
                height: 222.h,
                  width: double.infinity,
                  child: BannerItem(
                listOfImages: state.homeModel.banner,
              )),
              category(context, state.homeModel),
            ],
          );
        } else {
          return const Center(child: CustomCircular());
        }
      },
    );
  }

  Widget category(BuildContext context, HomeModel homeModel) {
    return Expanded(
      child: Column(
        children: [
          Row(
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
                      arguments: homeModel.category);
                },
                child: Text(
                  "All Categories",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5.sp,
          ),
          Expanded(
              child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => CircularCategoryItem(
              name: homeModel.category[index].name,
              image: homeModel.category[index].image,
            ),
            itemCount: homeModel.category.length,
          ))
        ],
      ),
    );
  }
}
