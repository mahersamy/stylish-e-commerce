import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/helpers/extentions.dart';
import 'package:stylish/features/cart/data/models/address_model.dart';
import 'package:stylish/features/cart/logic/cubits/cart_cubit.dart';
import 'package:stylish/features/cart/presentions/widgets/address_item.dart';

import '../../../../core/routes/app_route.dart';
import '../../../../core/shared_widgets/custom_button.dart';
import '../../../../core/utils/app_colors.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      buildWhen: (prevState, cartState) {
        if (cartState is SetAddressIndexSuccess) {
          return true;
        }else if(cartState is RemoveAddress){
          return true;
        }
        return false;
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text("Address",style: Theme.of(context).textTheme.headlineSmall,),centerTitle: true,),
          body:Column(
            children: [
              Expanded(
                child: ListView.separated(
                    itemCount: BlocProvider.of<CartCubit>(context).addressList.length,
                    separatorBuilder: (context, index) => SizedBox(
                      height: 20.h,
                    ),
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key:ValueKey<AddressModel>(BlocProvider.of<CartCubit>(context).addressList[index]),
                        onDismissed: (direction) {
                          BlocProvider.of<CartCubit>(context).removeAddress(index);
                        },
                        child: InkWell(
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
                        ),
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0).w,
                child: CustomButton(
                  onPressed: () {
                    context.pushNamed(Routes.newAddressScreen);
                  },
                  height: 50,
                  width: 325,
                  color: AppColors.mainColor,
                  widget: Text(
                    "Add New Address",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(color: Colors.white),
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
