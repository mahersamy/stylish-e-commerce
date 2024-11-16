import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:stylish/features/settings/data/repository/setting_repo.dart';

import '../../data/models/user_model.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit(this.settingRepo) : super(SettingInitial());

  late UserModel userModel;
  final SettingRepo settingRepo;
   ThemeMode themeMode = ThemeMode.light;
  bool isBlack=false;

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


  Future<void> logout() async {
    emit(SettingLoading());
    await FirebaseAuth.instance.signOut();
    emit(LogOut());
  }


  void changeThemeMode(bool isBlack) {
    if(isBlack){
      this.isBlack=true;
       themeMode=ThemeMode.dark;
    }else{
      this.isBlack=false;
      themeMode=ThemeMode.light;
    }
    emit(ChangeTheme());
  }
}
