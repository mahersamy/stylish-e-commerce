import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stylish/core/helpers/extentions.dart';
import 'package:stylish/core/routes/app_route.dart';

import '../../../../core/helpers/toast_helper.dart';
import '../../../../core/shared_widgets/custom_button.dart';
import '../../../../core/shared_widgets/custom_circular.dart';
import '../../../../core/shared_widgets/custom_text_field.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../logic/cubits/auth_cubit.dart';
import '../widgets/password_text_field.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              ToastHelper().showErrorToast(state.message!);
            }
            if (state is AuthSuccess) {
              ToastHelper().showSuccessToast("Login Successful");
              context.pushReplacementNamed(Routes.homeLayout);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Form(
                key: BlocProvider.of<AuthCubit>(context).signInGlobalKey,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 280.h,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40.w),
                          bottomRight: Radius.circular(40.w),
                        ),
                      ),
                      child: Image.asset(
                        AppAssets.loginImage,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      height: 45.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25).w,
                      child: Column(
                        children: [
                          CustomTextField(
                            isPassword: false,
                            hintText: "Email",
                            controller: BlocProvider.of<AuthCubit>(context)
                                .emailController,
                            textInputType: TextInputType.emailAddress,
                            validation: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 35.h,
                          ),
                          PasswordTextField(
                            controller: BlocProvider.of<AuthCubit>(context)
                                .passwordController,
                            hintText: "Password",
                            validation: (value) {
                              if (value!.isEmpty) {
                                return "Password is required";
                              }
                              return null;
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Forgot Password?",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 25.h,
                          ),
                          ConditionalBuilder(
                            condition: state is! AuthLoading,
                            fallback: (context) => const CustomCircular(),
                            builder: (context) => CustomButton(
                              widget: Text(
                                "Sign In",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: AppColors.neutral9),
                              ),
                              onPressed: () {
                                if (BlocProvider.of<AuthCubit>(context)
                                    .signInGlobalKey
                                    .currentState!
                                    .validate()) {
                                  BlocProvider.of<AuthCubit>(context)
                                      .signInWithEmailAndPassword();
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
                              BlocProvider.of<AuthCubit>(context)
                                  .signInWithGoogle();
                            },
                            height: 40,
                            width: 325,
                            color:  Theme.of(context).canvasColor,
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
                            color: Theme.of(context).canvasColor,
                            // AppColors.neutral9:,
                          ),
                          SizedBox(height: 15.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              TextButton(
                                onPressed: () {
                                 context.pushNamed(Routes.signUpScreen);
                                },
                                child: Text(
                                  "Sign Up",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(color: AppColors.mainColor),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
