import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../data/repository/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo) : super(AuthInitial());
  final AuthRepo authRepo;
  late UserCredential userCredential;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController signupEmailController = TextEditingController();
  TextEditingController signupPasswordController = TextEditingController();
  TextEditingController signupConfirmPasswordController = TextEditingController();
  GlobalKey<FormState> signUpGlobalKey=GlobalKey<FormState>();
  GlobalKey<FormState> signInGlobalKey=GlobalKey<FormState>();

  Future<void> signInWithGoogle() async {
    authRepo.signInWithGoogle(false).then((value) {
      value.fold((l) {
        emit(AuthError(l));
      }, (r) {
        userCredential = r;
        emit(AuthSuccess());

      });
    });
  }

  Future<void> signInWithFacebook() async {
    authRepo.signInWithFacebook(false).then((value) {
      value.fold((l) {
        emit(AuthError(l));
      }, (r) {
        userCredential = r;
        emit(AuthSuccess());
      });
    });
  }

  Future<void> signUpWithGoogle() async {
    authRepo.signInWithGoogle(true).then((value) {
      value.fold((l) {
        emit(AuthError(l));
      }, (r) async {
        userCredential = r;
        emit(AuthSuccess());

      });
    });
  }

  Future<void> signUpWithFacebook() async {
    authRepo.signInWithFacebook(false).then((value) {
      value.fold((l) {
        emit(AuthError(l));
      }, (r) {
        userCredential = r;
        emit(AuthSuccess());

      });
    });
  }

  Future<void> signInWithEmailAndPassword() async {
    emit(AuthLoading());

    authRepo
        .signIn(emailController.text, passwordController.text)
        .then((value) {
      value.fold((l) {
        emit(AuthError(l));
      }, (r) async{
        userCredential = r;
        await verifiedEmail();
      });
    });
  }

  Future<void> signUpWithEmailAndPassword() async {
    emit(AuthLoading());
    authRepo
        .signUpWithEmailAndPassword(
            signupEmailController.text, signupPasswordController.text)
        .then((value) {
      value.fold((l) {
        emit(AuthError(l));
      }, (r) async {
        userCredential = r;
        await authRepo.addUserToFireStoreNotWithCredential(userCredential, "${firstNameController.text} ${lastNameController.text}", phoneController.text,);
        await verifiedEmail();
      });
    });
  }



  Future<void> verifiedEmail() async {
    if (FirebaseAuth.instance.currentUser?.emailVerified == true) {
      emit(AuthSuccess());
    } else {
     try {
       await FirebaseAuth.instance.currentUser?.sendEmailVerification();
       emit(AuthError("Please verify your email"));
     }catch (e) {
       emit(AuthError("please wait for 5 minutes and try again"));
     }

    }
  }










}
