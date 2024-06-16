import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:stylish/core/%20shared_model/cart_model.dart';
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
  List<CartModel> cartList=[];
  List<ProductModel> categoryProductList=[];
  String? selectedColor;
  String? selectedSize;
  int currentIndex=0;



  addToCart(ProductModel productModel){
    bool isAdded=false;
    cartList.forEach((element){
      if(element.productModel.id==productModel.id){
        element.quantity++;
        element.selectedSize=selectedSize!;
        element.selectedColor=selectedColor!;
        isAdded=true;
        return;
      }
    });

    if(isAdded){
      emit(UpdateCartSuccess());
    }else{
      cartList.add(CartModel(productModel: productModel,quantity: 1,selectedColor: selectedColor!,selectedSize: selectedSize!));
      emit(AddToCartSuccess());
    }

  }


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
        categoryProductList=List.from(r).cast<ProductModel>();
        emit(GetCategoryProductSuccess(productModels: r));
      });
    });
  }


  Future<void> getFavoriteProductID() async {
    homeRepo.getFavoriteProductID(FirebaseAuth.instance.currentUser!.uid).then((value) {
      value.fold((l) {
        emit(GetFavoriteProductError());
      }, (r) {
        favoriteProductId=List.from(r).cast<int>();
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



  Future<void> getAllFavoriteProduct() async {
    await getFavoriteProductID();
    Future.delayed(const Duration(milliseconds: 600), () {
      homeRepo.getAllFavoriteProduct(favoriteProductId).then((value) {
        value.fold((l) {
          emit(GetAllFavoriteProductError());
        }, (r) {
          emit(GetAllFavoriteProductSuccess(productModels: r));
        });
      });
    });




  }








}
