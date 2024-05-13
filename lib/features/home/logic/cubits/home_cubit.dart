import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:stylish/features/home/data/models/home_model.dart';
import 'package:stylish/features/home/data/repository/home_repo.dart';

import '../../data/models/product_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeRepo) : super(HomeInitial());

  final HomeRepo homeRepo;
  HomeModel? homeModel;
  PageController pageController=PageController();

  List screens = [];

  Future<void> getHome() async {
    emit(HomeLoading());
    HomeRepo().getHome().then((value) {
      value.fold((l) {
        emit(HomeError(l));
      }, (r) {
        homeModel = r;
        emit(HomeSuccess());
      });
    });
  }

  Future<void> getCategoryProduct(String categoryName) async {
    emit(GetCategoryProductLoading());
    HomeRepo().getCategoryProduct(categoryName).then((value) {
      value.fold((l) {
        emit(GetCategoryProductError(message: l));
      }, (r) {
        print(r);
        emit(GetCategoryProductSuccess(productModels: r));
      });
    });
  }

}
