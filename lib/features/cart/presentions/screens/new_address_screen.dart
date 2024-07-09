import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/helpers/extentions.dart';
import 'package:stylish/core/shared_widgets/custom_circular.dart';
import 'package:stylish/core/shared_widgets/custom_text_field.dart';
import 'package:stylish/features/cart/logic/cubits/cart_cubit.dart';

import '../../../../core/shared_widgets/custom_button.dart';
import '../../../../core/utils/app_colors.dart';

class NewAddressScreen extends StatelessWidget {
  const NewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        if (state is SetAddressSuccess) {
          context.pop();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "New Address",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(25.0).w,
            child: Form(
              key: BlocProvider.of<CartCubit>(context).formKey,
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height - 180.h,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              isPassword: false,
                              hintText: "First Name",
                              controller: BlocProvider.of<CartCubit>(context)
                                  .firstNameController,
                              textInputType: TextInputType.name,
                              validation: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your first name";
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 30.w,
                          ),
                          Expanded(
                            child: CustomTextField(
                              isPassword: false,
                              hintText: "Last Name",
                              controller: BlocProvider.of<CartCubit>(context)
                                  .lastNameController,
                              textInputType: TextInputType.name,
                              validation: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your last name";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      CustomTextField(
                        isPassword: false,
                        hintText: "Country / Region",
                        controller:
                            BlocProvider.of<CartCubit>(context).countryController,
                        textInputType: TextInputType.name,
                        validation: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your country";
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                        isPassword: false,
                        hintText: "Street Address",
                        controller: BlocProvider.of<CartCubit>(context)
                            .streetAddressController,
                        textInputType: TextInputType.name,
                        validation: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your street address";
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                        isPassword: false,
                        hintText: "Town / City",
                        controller:
                            BlocProvider.of<CartCubit>(context).cityController,
                        textInputType: TextInputType.name,
                        validation: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your city";
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                        isPassword: false,
                        hintText: "+20 Phone Number",
                        controller: BlocProvider.of<CartCubit>(context)
                            .phoneNumberController,
                        textInputType: TextInputType.phone,
                        validation: (value) {
                          if (value == null || value.isEmpty || value.length < 10) {
                            return "Please enter your phone number";
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                        isPassword: false,
                        hintText: "Email Address",
                        controller:
                            BlocProvider.of<CartCubit>(context).emailController,
                        textInputType: TextInputType.emailAddress,
                        validation: (value) {
                          if (value == null || value.isEmpty || value.contains("@") == false) {
                            return "Please enter your email";
                          }
                          return null;
                        },
                      ),
                      CustomButton(
                        onPressed: () {
                          BlocProvider.of<CartCubit>(context).setAddress();
                        },
                        height: 50,
                        width: 325,
                        color: AppColors.mainColor,
                        widget: Text(
                          "Add Address",
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(color: Colors.white),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
