import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stylish/core/utils/firebase_strings.dart';

import '../models/address_model.dart';

class CartRepo {

  Future<Either<String,List<AddressModel>>> getAddress() async{
    try {
      final response = await FirebaseFirestore.instance
          .collection(FirebaseStrings.users)
          .doc(FirebaseAuth.instance.currentUser!.uid).get();
      return Right(List<AddressModel>.from(response.data()![FirebaseStrings.address].toList().map((e) => AddressModel.fromJson(e))));
    }catch(e){
      return const Left("please try again");
    }

  }



  Future<Either<String,Unit>> setAddress(List<AddressModel> address) async{
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseStrings.users)
          .doc(FirebaseAuth.instance.currentUser!.uid).update({
          FirebaseStrings.address :address.map((e) =>e.toJson(e) ).toList(),
          });


      return const Right(unit);
    }catch(e){
      return const Left("please try again");
    }

  }


}