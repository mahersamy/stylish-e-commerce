import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/helpers/extentions.dart';
import 'package:stylish/core/helpers/toast_helper.dart';
import 'package:stylish/core/shared_widgets/custom_button.dart';
import 'package:stylish/core/shared_widgets/custom_circular.dart';
import 'package:stylish/core/shared_widgets/custom_text_field.dart';
import 'package:stylish/features/settings/logic/cubit/setting_cubit.dart';

import '../../../../core/routes/app_route.dart';

class AccountSettingScreen extends StatelessWidget {
  const AccountSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingCubit, SettingState>(
      listener: (context, state) {
        // TODO: implement listener
        if(state is ChangeProfileSuccess){
          ToastHelper().showSuccessToast("Profile changed successfully");
          context.pushReplacementNamed(Routes.homeLayout);
        }else if(state is ChangeProfileError){
          ToastHelper().showErrorToast("Profile changed failed");
        }
      },
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0).w,
        child: Column(
          children: [
            CustomTextField(
              isPassword: false,
              hintText: "Name",
              controller: BlocProvider.of<SettingCubit>(context).nameController,
              textInputType: TextInputType.name,
            ),
            SizedBox(
              height: 40.h,
            ),
            CustomTextField(
              isPassword: false,
              hintText: "E-Mail",
              controller: BlocProvider.of<SettingCubit>(context).emailController,
              textInputType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: 40.h,
            ),
            CustomTextField(
              isPassword: false,
              hintText: "Phone",
              controller: BlocProvider.of<SettingCubit>(context).phoneController,
              textInputType: TextInputType.phone,
            ),
            const Spacer(),
            ConditionalBuilder(
              condition: state is! SettingLoading,
              fallback: (context) => const Center(child: CustomCircular()),
              builder:(context)=> CustomButton(
                widget:Text("Save Changes",style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: Colors.white),),
                onPressed: () {
                  BlocProvider.of<SettingCubit>(context).changeProfile();
                },
                height: 40,
                width: 300,
              ),
            )
          ],
        ),
      ),
    );
  },
);
  }
}
