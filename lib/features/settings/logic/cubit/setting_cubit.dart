import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:stylish/features/settings/data/repository/setting_repo.dart';

import '../../data/models/user_model.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit(this.settingRepo) : super(SettingInitial());

  late UserModel userModel;
  final SettingRepo settingRepo;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  Future<void> changeProfile() async {
    emit(SettingLoading());
    userModel = UserModel(
      name: nameController.text,
      email: emailController.text,
      phone: phoneController.text,
    );
    final response = await settingRepo.changeProfile(userModel.toJson());
    response.fold(
      (l) => emit(ChangeProfileError()),
      (r) => emit(
        ChangeProfileSuccess(),
      ),
    );
  }

  Future<void> getProfile() async {
    emit(SettingLoading());
    final response = await settingRepo.getProfile();
    response.fold(
      (l) => emit(GetProfileError()),
      (r) {
        userModel = r;
        nameController.text = userModel.name;
        emailController.text = userModel.email;
        phoneController.text = userModel.phone??"";
        emit(GetProfileSuccess());

      }
    );
  }



}
