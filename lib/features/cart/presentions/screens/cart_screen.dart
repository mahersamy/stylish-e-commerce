import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish/core/%20shared_model/cart_model.dart';
import 'package:stylish/core/helpers/extentions.dart';

import '../../../../core/routes/app_route.dart';
import '../../../../core/shared_widgets/custom_button.dart';
import '../../../../core/utils/app_colors.dart';
import '../../logic/cubits/cart_cubit.dart';
import '../widgets/cart_item.dart';


class CartScreen extends StatefulWidget {
  const CartScreen({super.key, required this.cartList});

  final List<CartModel> cartList;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  @override
  void initState() {
    BlocProvider.of<CartCubit>(context).cartList = widget.cartList;
    BlocProvider.of<CartCubit>(context).totalPriceCalculator(widget.cartList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      buildWhen: (prevState, cartState) {
        if(cartState is TotalPriceChanged){
         return true;
        }else{
          return false;
        }
      },
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(title:  Text("CART",style: Theme.of(context).textTheme.headlineSmall,),centerTitle: true,),
            body: ConditionalBuilder(
              condition: widget.cartList.isNotEmpty,
              builder: (context) =>
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      children: [
                        Expanded(child: ListView.separated(
                          itemBuilder: (context, index) =>
                              CartItem(cartModel: widget.cartList[index]),
                          separatorBuilder: (context, index) => const Divider(),
                          itemCount: widget.cartList.length,
                        ),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total",style: Theme.of(context).textTheme.bodyLarge,),
                            Text("${BlocProvider.of<CartCubit>(context).totalPrice} EGP",style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.mainColor),)
                          ],
                        ),
                        const SizedBox(height: 20,),
                        CustomButton(
                          onPressed: () {
                            context.pushNamed(Routes.checkoutScreen);
                          },
                          height: 50,
                          width: 325,
                          color: AppColors.mainColor,
                          widget: Text("Proceed To Checkout",style: Theme.of(context).textTheme.labelSmall!.copyWith(color: Colors.white),),
                        )
                      ],
                    )
                  ),
              fallback: (context) =>
              const Center(
                child: Text("Cart Is Empty"),
              ),
            )
        );
      },
    );
  }
}
