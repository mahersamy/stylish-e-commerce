import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish/core/%20shared_model/cart_model.dart';

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
    BlocProvider.of<CartCubit>(context).totalPriceCalculator(widget.cartList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(),
            body: ConditionalBuilder(
              condition: widget.cartList.isNotEmpty,
              builder: (context) =>
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: ListView.separated(
                      itemBuilder: (context, index) =>
                          CartItem(cartModel: widget.cartList[index]),
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: widget.cartList.length,
                    ),
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
