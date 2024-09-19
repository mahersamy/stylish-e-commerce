import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stylish/core/utils/firebase_strings.dart';
import 'package:stylish/features/settings/data/models/user_model.dart';



class SettingRepo{

  Future<Either<String, UserModel>> getProfile() async{
    try {
      final response = await FirebaseFirestore.instance
          .collection(FirebaseStrings.users).doc(FirebaseAuth.instance.currentUser!.uid).get();
      return Right(UserModel.fromJson(response.data()!));
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, Unit>> changeProfile(Map<String, dynamic> json) async{
    try {
       await FirebaseFirestore.instance.collection(FirebaseStrings.users)
      .doc(FirebaseAuth.instance.currentUser!.uid).update(json);
      return const Right(unit);
    } catch (e) {
      return Left(e.toString());
    }
  }


}
