import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../core/utils/firebase_strings.dart';
import '../../home/data/models/product_model.dart';

class SearchRepo {

  Future<Either<String, List<ProductModel>>> search(String query) async {

    try {
      final response = await FirebaseFirestore.instance
          .collection(FirebaseStrings.products)
          .where(FirebaseStrings.name, isGreaterThanOrEqualTo: query)
          .where(FirebaseStrings.name, isLessThan: '${query}z')
          .get();
      return Right(response.docs.map((e) => ProductModel.fromJson(e.data())).toList());
    } catch (e) {
      return Left(e.toString());
    }

  }


}