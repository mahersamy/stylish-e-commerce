import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:stylish/features/home/data/models/home_model.dart';

class HomeRepo {
  Future<Either<String, HomeModel>> getHome() async{
    try {
      final response = await FirebaseFirestore.instance.collection("home").get();
      return Right(HomeModel.fromJson(response.docs.first.data()));
    }catch(e){
      return Left(e.toString());
    }

  }
}
