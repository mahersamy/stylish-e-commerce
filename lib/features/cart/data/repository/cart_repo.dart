import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stylish/core/%20shared_model/cart_model.dart';
import 'package:stylish/core/database/api/api_consumer.dart';
import 'package:stylish/core/database/api/end_points.dart';
import 'package:stylish/core/di/dependency_injection.dart';
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


  Future<Either<String,String>> getAuthToken(String token) async{
    try {
      final response = await getIt<ApiConsumer>().post(EndPoint.authToken, data: {
        ApiKeys.apiKey:token,
      });
      return Right(response[ApiKeys.token]);
    }catch(e){
      return const Left("please try again");
    }
  }

  Future<Either<String,String>> payOrder({required AddressModel address,required List<CartModel> cart,required String authToken,required int total}) async{
    try {
      final response =await getIt<ApiConsumer>().post(
          EndPoint.orders,
          data: {
            ApiKeys.authToken:authToken,
            ApiKeys.apiSource: "INVOICE",
            ApiKeys.currency: "EGP",
            ApiKeys.amountCents:total,
            ApiKeys.items: [
              {
                ApiKeys.name:"products",
                ApiKeys.amountCents:total,
              }
            ],
            ApiKeys.shippingData: {
              ApiKeys.firstName:address.firstName,
              ApiKeys.lastName:address.lastName,
              ApiKeys.email:address.email,
              ApiKeys.phone:address.phoneNumber,

            },
            ApiKeys.integrations: ["3529315"],
            ApiKeys.deliveryNeeded: false,



          }
      );

      return  Right(response[ApiKeys.url]);
    }catch(e){
      return const Left("Error in payment process");
    }

  }


}