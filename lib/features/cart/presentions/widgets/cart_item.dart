import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/%20shared_model/cart_model.dart';
import 'package:stylish/features/cart/logic/cubits/cart_cubit.dart';

import '../../../../core/utils/app_colors.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.cartModel, this.isChange = true});

  final CartModel? cartModel;
  final bool isChange;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Image.network(
        cartModel!.productModel.image,
        height: 96.h,
        width: 68.w,
      ),
      SizedBox(
        width: 18.w,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            cartModel!.productModel.name,
            style: Theme.of(context).textTheme.labelSmall,
          ),
          Text(
            cartModel!.productModel.price.toString(),
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(color: AppColors.mainColor),
          ),
        ],
      ),
      const Spacer(),
      counterItem(context, cartModel!),
    ]);
  }

  Widget counterItem(context, CartModel cartModel) {
    return BlocBuilder<CartCubit, CartState>(
      buildWhen: (prevState, cartState) => cartState is CounterChanged,
      builder: (context, state) {
        return Row(
          children: [
            isChange
                ? IconButton(
                    onPressed: () {
                      BlocProvider.of<CartCubit>(context).decrement(cartModel);
                    },
                    icon: Icon(
                      Icons.remove,
                      size: 20.w,
                    ))
                : const SizedBox(),
            SizedBox(
              width: 4.w,
            ),
            Text(cartModel.quantity.toString()),
            SizedBox(
              width: 4.w,
            ),
            isChange
                ? IconButton(
                    onPressed: () {
                      BlocProvider.of<CartCubit>(context).increment(cartModel);
                    },
                    icon: Icon(
                      Icons.add,
                      size: 20.w,
                    ),
                  )
                : const SizedBox(),
          ],
        );
      },
    );
  }
}
