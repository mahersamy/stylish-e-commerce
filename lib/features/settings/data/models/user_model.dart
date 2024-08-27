import 'package:stylish/core/utils/firebase_strings.dart';

class UserModel {
  final String name;
  final String email;
  final String phone;

  UserModel({required this.name, required this.email, required this.phone});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json[FirebaseStrings.name],
      email: json[FirebaseStrings.email],
      phone: json[FirebaseStrings.phone],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      FirebaseStrings.name: name,
      FirebaseStrings.email: email,
      FirebaseStrings.phone: phone,
    };
  }


}