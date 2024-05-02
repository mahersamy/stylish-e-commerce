import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:stylish/features/home/data/models/home_model.dart';
import 'package:stylish/features/home/data/repository/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeRepo) : super(HomeInitial());

  final HomeRepo homeRepo;
  PageController pageController=PageController();

  List screens = [];

  Future<void> getHome() async {
    HomeRepo().getHome().then((value) {
      value.fold((l) {
        emit(HomeError(l));
      }, (r) {
        emit(HomeSuccess(r));
      });
    });
  }
}
