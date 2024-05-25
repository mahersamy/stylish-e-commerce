import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:stylish/features/home/data/models/home_model.dart';
import 'package:stylish/features/home/data/repository/home_repo.dart';
import 'package:stylish/features/home/presention/screens/favorite_screen.dart';
import 'package:stylish/features/home/presention/screens/home_screen.dart';

import '../../data/models/product_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeRepo) : super(HomeInitial());

  final HomeRepo homeRepo;
  HomeModel? homeModel;
  List screens = [const HomeScreen(),const FavoriteScreen()];
  List<int> favoriteProductId=[];
  int currentIndex=0;


  void changeIndex(int index){
    currentIndex=index;
    emit(HomeInitial());
  }

  Future<void> getHome() async {
    emit(HomeLoading());
    homeRepo.getHome().then((value) {
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
    homeRepo.getCategoryProduct(categoryName).then((value) {
      value.fold((l) {
        emit(GetCategoryProductError(message: l));
      }, (r) {
        emit(GetCategoryProductSuccess(productModels: r));
      });
    });
  }


  Future<void> getFavoriteProduct() async {
    homeRepo.getFavoriteProduct(FirebaseAuth.instance.currentUser!.uid).then((value) {
      value.fold((l) {
        emit(GetFavoriteProductError());
      }, (r) {
        favoriteProductId=List.from(r).cast<int>();
        emit(GetFavoriteProductSuccess());
      });
    });
  }

  Future<void> setFavoriteProduct(int id) async {
    if(checkFavorite(id)){
      favoriteProductId.remove(id);
    }else{
      favoriteProductId.add(id);
    }
    homeRepo.setFavoriteProduct(FirebaseAuth.instance.currentUser!, favoriteProductId).then((value) {
      value.fold((l) {
        emit(SetFavoriteProductError());
      }, (r) {
        emit(SetFavoriteProductSuccess());
      });
    });
  }


  bool checkFavorite(int id){
    if(favoriteProductId.contains(id)){
      return true;
    }else{
      return false;
    }
  }








}
