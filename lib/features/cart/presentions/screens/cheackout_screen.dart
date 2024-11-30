import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/helpers/extentions.dart';
import 'package:stylish/core/helpers/toast_helper.dart';

import '../../../../core/routes/app_route.dart';
import '../../../../core/shared_widgets/custom_button.dart';
import '../../../../core/utils/app_colors.dart';
import '../../logic/cubits/cart_cubit.dart';
import '../widgets/address_item.dart';
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
        if(state is PaymentProcessSuccess){
          ToastHelper().showSuccessToast("Payment successful");
          context.pushNamed(Routes.payScreen);

        }else if(state is PaymentProcessError){
          ToastHelper().showErrorToast("Payment failed");
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ConditionalBuilder(
                    condition: BlocProvider.of<CartCubit>(context)
                        .addressList
                        .isNotEmpty,
                    builder: (context) => InkWell(
                      onTap: () => context.pushNamed(Routes.addressScreen),
                      child: AddressItem(
                        addressModel: BlocProvider.of<CartCubit>(context)
                                .addressList[
                            BlocProvider.of<CartCubit>(context).addressIndex],
                        isSelect: false,
                      ),
                    ),
                    fallback: (context) => CustomButton(widget: const Text("Add Address"), onPressed: () => context.pushNamed(Routes.addressScreen), height: 50, width: 350),

                  ),
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) =>
                          CartItem(cartModel: cartList[index], isChange: false),
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
                    onPressed: () {
                      BlocProvider.of<CartCubit>(context).pay();



                    },
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
