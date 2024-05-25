import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stylish/core/utils/firebase_strings.dart';
import 'package:stylish/features/home/data/models/home_model.dart';

import '../../../../core/utils/app_strings.dart';
import '../models/product_model.dart';

class HomeRepo {
  Future<Either<String, HomeModel>> getHome() async {
    try {
      final response = await FirebaseFirestore.instance
          .collection(FirebaseStrings.home)
          .get();

      return Right(HomeModel.fromJson(response.docs.first.data()));
    } catch (e) {
      throw e;
      return const Left("please try again");
    }
  }

  Future<Either<String, List<ProductModel>>> getCategoryProduct(
      String categoryName) async {
    try {
      final response = await FirebaseFirestore.instance
          .collection(FirebaseStrings.products)
          .where(FirebaseStrings.category, isEqualTo: categoryName)
          .get();

      return Right(
        List<ProductModel>.from(
          response.docs.map(
            (e) => ProductModel.fromJson(
              e.data(),
            ),
          ),
        ),
      );
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<dynamic>>> getFavoriteProduct(String docPath) async {
    try {
      final response = await FirebaseFirestore.instance
          .collection(FirebaseStrings.users)
          .doc(docPath)
          .get();
      return Right(response.data()![FirebaseStrings.favoriteProduct]);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, Unit>> setFavoriteProduct(
      User user, List<int> favoriteProduct) async {
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseStrings.users)
          .doc(user.uid)
          .set(
        {
          AppStrings.uid:user.uid,
          AppStrings.name: user.displayName,
          AppStrings.email: user.email,
          AppStrings.phoneNumber:user.phoneNumber,
          FirebaseStrings.favoriteProduct: favoriteProduct},
      );

      return const Right(unit);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
