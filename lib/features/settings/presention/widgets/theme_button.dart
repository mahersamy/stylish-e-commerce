import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish/features/settings/logic/cubit/setting_cubit.dart';

import '../../../../core/utils/app_colors.dart';


class ThemeButton extends StatelessWidget {
  const ThemeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingCubit, SettingState>(
      buildWhen: (previous, current) {
        if(previous != current) {
          return true;
        }else if(current is ChangeTheme) {
          return true;
        }
        return true;
      },
      builder: (context, state) {
        return Row(
          children: [
            const Icon(
              Icons.sunny,
              color: AppColors.mainColor,
            ),
            Switch.adaptive(
              value: BlocProvider
                  .of<SettingCubit>(context)
                  .isBlack,
              onChanged: (value) {
                print("value $value");
                BlocProvider.of<SettingCubit>(context).changeThemeMode(value);
              },
              activeColor: AppColors.mainColor,
            ),
            const Icon(
              Icons.dark_mode,
              color: AppColors.mainColor,
            ),
          ],
        );
      },
    );
  }
}
