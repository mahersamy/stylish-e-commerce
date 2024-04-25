import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/errors/firebase_auth_hundler.dart';
import '../../../../core/utils/app_strings.dart';

class AuthRepo {


  Future<Either<String?, UserCredential>> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return Right(userCredential);
    } on FirebaseAuthException catch (e) {
      return Left(firebaseAuthHundler(e));
    }
  }

  Future<Either<String?, UserCredential>> signInWithGoogle(bool isSignUp) async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential userCredential =await FirebaseAuth.instance.signInWithCredential(credential);

      if(isSignUp==true) {
        print("add user");
        await addUserToFireStore(userCredential);
      }
      return Right(userCredential);
    } on FirebaseAuthException catch (e) {
      return Left(firebaseAuthHundler(e));
    }
  }

  Future<Either<String?, UserCredential>> signInWithFacebook(bool isSignUp) async {
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential
      UserCredential userCredential =await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
      if(isSignUp) {
        await addUserToFireStore(userCredential);
      }
      return Right(userCredential);
    } on FirebaseAuthException catch (e) {
      return Left(firebaseAuthHundler(e));
    }
  }

  Future<Either<String?, UserCredential>> signUpWithEmailAndPassword(String emailAddress, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return Right(userCredential);
    } on FirebaseAuthException catch (e) {
      return Left(firebaseAuthHundler(e));
    } catch (e) {
      return const Left('An unknown error occurred');
    }
  }

  Future<void> addUserToFireStore(UserCredential userCredential) async {
    try{
      FirebaseFirestore.instance.collection(AppStrings.users).add({
        AppStrings.uid: userCredential.user?.uid,
        AppStrings.name: userCredential.user?.displayName,
        AppStrings.email: userCredential.user?.email,
        AppStrings.phoneNumber: userCredential.user?.phoneNumber,
      });
    }on FirebaseException catch (e){
        print(e);
    }
  }




}
