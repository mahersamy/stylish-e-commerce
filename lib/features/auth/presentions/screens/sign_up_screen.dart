import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stylish/core/helpers/extentions.dart';
import 'package:stylish/core/routes/app_route.dart';
import 'package:stylish/core/shared_widgets/custom_circular.dart';
import 'package:stylish/core/shared_widgets/custom_text_field.dart';
import 'package:stylish/features/auth/logic/cubits/auth_cubit.dart';
import 'package:stylish/features/auth/presentions/widgets/password_text_field.dart';

import '../../../../core/helpers/toast_helper.dart';
import '../../../../core/shared_widgets/custom_button.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ToastHelper().showErrorToast(state.message!);
        } else {
          ToastHelper().showSuccessToast("Registration Successful");
          context.pushNamedAndRemoveUntil(Routes.signInScreen,
            predicate: (route) => false
          );
        }
      },
      builder: (context, state) {
        return SafeArea(
            child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25).w,
            child: Form(
              key: BlocProvider.of<AuthCubit>(context).signUpGlobalKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      "create your account".toUpperCase(),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedBox(
                      height: 55.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            isPassword: false,
                            hintText: "First Name",
                            controller: BlocProvider.of<AuthCubit>(context)
                                .firstNameController,
                            textInputType: TextInputType.text,
                            validation: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your first name';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: 10.sp,
                        ),
                        Expanded(
                          child: CustomTextField(
                              isPassword: false,
                              hintText: "Last Name",
                              controller: BlocProvider.of<AuthCubit>(context)
                                  .lastNameController,
                              textInputType: TextInputType.text,
                              validation: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your last name';
                                }
                                return null;
                              }),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomTextField(
                      isPassword: false,
                      hintText: "E-mail",
                      controller: BlocProvider.of<AuthCubit>(context)
                          .signupEmailController,
                      textInputType: TextInputType.text,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomTextField(
                      isPassword: false,
                      hintText: "Phone Number",
                      controller:
                          BlocProvider.of<AuthCubit>(context).phoneController,
                      textInputType: TextInputType.number,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    PasswordTextField(
                        hintText: "Password",
                        controller: BlocProvider.of<AuthCubit>(context)
                            .signupPasswordController,
                        validation: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        }),
                    SizedBox(
                      height: 10.h,
                    ),
                    PasswordTextField(
                        hintText: "Confirm Password",
                        controller: BlocProvider.of<AuthCubit>(context)
                            .signupConfirmPasswordController,
                        validation: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your confirm password';
                          }
                          return null;
                        }),
                    SizedBox(
                      height: 51.h,
                    ),
                    ConditionalBuilder(
                      condition: state is! AuthLoading,
                      fallback: (context) => const CustomCircular(),
                      builder: (context) => CustomButton(
                        widget: Text(
                          "Sign Up".toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: AppColors.neutral9),
                        ),
                        onPressed: () {
                          if (BlocProvider.of<AuthCubit>(context)
                              .signUpGlobalKey
                              .currentState!
                              .validate()) {
                            if (BlocProvider.of<AuthCubit>(context)
                                    .signupPasswordController
                                    .text ==
                                BlocProvider.of<AuthCubit>(context)
                                    .signupConfirmPasswordController
                                    .text) {
                              BlocProvider.of<AuthCubit>(context)
                                  .signUpWithEmailAndPassword();
                            } else {
                              ToastHelper()
                                  .showErrorToast("Passwords don't match");
                            }
                          }
                        },
                        height: 40,
                        width: 325,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomButton(
                      widget: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppAssets.googleIcon,
                            width: 20.w,
                            height: 20.h,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            "sign in with google".toUpperCase(),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      onPressed: () {
                        BlocProvider.of<AuthCubit>(context).signInWithGoogle();
                      },
                      height: 40,
                      width: 325,
                      color: AppColors.neutral9,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomButton(
                      widget: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppAssets.facebookIcon,
                            width: 20.w,
                            height: 20.h,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            "sign in with facebook".toUpperCase(),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      onPressed: () {
                        BlocProvider.of<AuthCubit>(context)
                            .signInWithFacebook();
                      },
                      height: 40,
                      width: 325,
                      color: AppColors.neutral9,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
      },
    );
  }
}
