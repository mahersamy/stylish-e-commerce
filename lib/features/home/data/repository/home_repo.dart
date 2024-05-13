import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:stylish/core/utils/firebase_strings.dart';
import 'package:stylish/features/home/data/models/home_model.dart';

import '../models/product_model.dart';

class HomeRepo {
  Future<Either<String, HomeModel>> getHome() async {
    try {
      final response = await FirebaseFirestore.instance
          .collection(FirebaseStrings.home)
          .get();
      return Right(HomeModel.fromJson(response.docs.first.data()));
    } catch (e) {
      throw e.toString();
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
}
