import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/features/cart/logic/cubits/cart_cubit.dart';
import 'package:stylish/features/cart/presentions/widgets/address_item.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      buildWhen: (prevState, cartState) {
        if (cartState is SetAddressIndexSuccess) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: ListView.separated(
              itemCount: BlocProvider.of<CartCubit>(context).addressList.length,
              separatorBuilder: (context, index) => SizedBox(
                    height: 20.h,
                  ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    BlocProvider.of<CartCubit>(context).setAddressIndex(index);
                  },
                  child: AddressItem(
                    addressModel:
                        BlocProvider.of<CartCubit>(context).addressList[index],
                    isSelect:
                        BlocProvider.of<CartCubit>(context).addressIndex ==
                            index,
                  ),
                );
              }),
        );
      },
    );
  }
}
