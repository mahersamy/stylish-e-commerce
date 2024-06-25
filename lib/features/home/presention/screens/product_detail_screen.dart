import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/%20shared_model/cart_model.dart';
import 'package:stylish/core/helpers/toast_helper.dart';
import 'package:stylish/core/shared_widgets/custom_button.dart';
import 'package:stylish/core/utils/app_assets.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/features/home/data/models/product_model.dart';
import 'package:stylish/features/home/logic/cubits/home_cubit.dart';
import 'package:stylish/features/home/presention/widgets/banner_item.dart';
import 'package:stylish/features/home/presention/widgets/size_selection_item.dart';

import '../widgets/color_selection_item.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  void initState() {
    BlocProvider.of<HomeCubit>(context).getAllFavoriteProduct();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is SetFavoriteProductSuccess) {
          // ToastHelper().showSuccessToast("Added To Favorite");
        } else if (state is SetFavoriteProductError) {
          ToastHelper().showErrorToast("Failed To update To Favorite");
        } else if (state is GetFavoriteProductError) {
          ToastHelper().showErrorToast("Failed To Get Favorite");
        }
      },
      builder: (context, state) {
        return PopScope(
          canPop: false,
          onPopInvoked: (val){
            BlocProvider.of<HomeCubit>(context).getAllFavoriteProduct();
          },
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  headerScreen(context, widget.productModel),
                  Padding(
                    padding: const EdgeInsets.all(8.0).w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ratingSelection(context, widget.productModel),
                        Text(
                          widget.productModel.name,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          widget.productModel.description!,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: AppColors.neutral4),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        colorSelection(context, widget.productModel),
                        sizeSelection(context, widget.productModel),
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
                      child: Text(
                        "\$ ${widget.productModel.price.toDouble()}",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    Container(
                      width: 2.w,
                      height: 30.h,
                      color: AppColors.neutral5,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    IconButton(
                      onPressed: () {
                        BlocProvider.of<HomeCubit>(context).setFavoriteProduct(widget.productModel.id);

                      },
                      icon: Icon(BlocProvider.of<HomeCubit>(context).checkFavorite(widget.productModel.id)?Icons.favorite:Icons.favorite_outline),
                      color: AppColors.mainColor,
                    ),
                    CustomButton(
                        widget: Text(
                          "Add To Cart",
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(color: AppColors.neutral9),
                        ),
                        onPressed: () {
                          BlocProvider.of<HomeCubit>(context).addToCart(widget.productModel);

                          print(BlocProvider.of<HomeCubit>(context).cartList[0].selectedSize);
                        },
                        height: 40,
                        width: 138)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
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
              onPressed: () {
                BlocProvider.of<HomeCubit>(context).getCategoryProduct(widget.productModel.categoryName!);
                Navigator.pop(context);
              },
              child: Image.asset(AppAssets.vector)),
        ),
      ],
    );
  }

  Column sizeSelection(BuildContext context, ProductModel productModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Size :",
          style: Theme.of(context).textTheme.labelSmall,
        ),
        SizedBox(
          height: 12.h,
        ),
        SizeSelectionItem(
          sizes: productModel.sizes!,
        )
      ],
    );
  }

  Column colorSelection(BuildContext context, ProductModel productModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Color :",
          style: Theme.of(context).textTheme.labelSmall,
        ),
        SizedBox(
          height: 12.h,
        ),
        ColorSelectionItem(
          colors: productModel.colors!,
        )
      ],
    );
  }

  Column ratingSelection(BuildContext context, ProductModel productModel) {
    return Column(
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
      ],
    );
  }
}
