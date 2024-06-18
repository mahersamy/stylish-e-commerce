import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish/features/cart/data/repository/cart_repo.dart';

import '../../../../core/shared_widgets/custom_button.dart';
import '../../../../core/utils/app_colors.dart';
import '../../data/models/address_model.dart';
import '../../logic/cubits/cart_cubit.dart';
import '../widgets/cart_item.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  void initState() {
    BlocProvider.of<CartCubit>(context).getAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cartList = BlocProvider.of<CartCubit>(context).cartList;

    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      buildWhen: (prevState, cartState) {
        if (cartState is TotalPriceChanged) {
          return true;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "CHECKOUT",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            centerTitle: true,
          ),
          body: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) =>
                          CartItem(cartModel: cartList[index]),
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: cartList.length,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        "${BlocProvider.of<CartCubit>(context).totalPrice} EGP",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: AppColors.mainColor),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    onPressed: () {},
                    height: 50,
                    width: 325,
                    color: AppColors.mainColor,
                    widget: Text(
                      "Order Now",
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: Colors.white),
                    ),
                  )
                ],
              )),
        );
      },
    );
  }
}
