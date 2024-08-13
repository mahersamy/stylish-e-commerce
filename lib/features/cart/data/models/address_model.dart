import 'package:flutter/material.dart';

import '../../../../core/utils/firebase_strings.dart';



class AddressModel {
  final String firstName;
  final String lastName;
  final String streetAddress;
  final String city;
  final String country;
  final String email;
  final String phoneNumber;




  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      firstName: json[FirebaseStrings.firstName],
      lastName: json[FirebaseStrings.lastName],
      streetAddress: json[FirebaseStrings.streetAddress],
      city: json[FirebaseStrings.city],
      country: json[FirebaseStrings.country],
      email: json[FirebaseStrings.email],
      phoneNumber: json[FirebaseStrings.phoneNumber],
    );
  }

  AddressModel({required this.firstName, required this.lastName, required this.streetAddress, required this.city, required this.country, required this.email, required this.phoneNumber});

 Map<String, dynamic> toJson(AddressModel addressModel) {
    final Map<String, dynamic> data ={};
    data[FirebaseStrings.firstName] = addressModel.firstName;
    data[FirebaseStrings.lastName] = addressModel.lastName;
    data[FirebaseStrings.streetAddress] = addressModel.streetAddress;
    data[FirebaseStrings.city] = addressModel.city;
    data[FirebaseStrings.country] = addressModel.country;
    data[FirebaseStrings.email] = addressModel.email;
    data[FirebaseStrings.phoneNumber] = addressModel.phoneNumber;
    return data;
  }
}