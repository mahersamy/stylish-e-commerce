import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../data/repository/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo) : super(AuthInitial());

  final AuthRepo authRepo;
  late UserCredential userCredential;

  Future<void> signInWithGoogle() async {
    authRepo.signInWithGoogle(false).then((value) {
      value.fold((l) {
        emit(AuthError(l));
      }, (r) {
        userCredential = r;
      });
    });
  }

  Future<void> signInWithFacebook() async {
    authRepo.signInWithFacebook(false).then((value) {
      value.fold((l) {
        emit(AuthError(l));
      }, (r) {
        userCredential = r;
      });
    });
  }


  Future<void> signUpWithGoogle() async {
    authRepo.signInWithGoogle(true).then((value) {
      value.fold((l) {
        emit(AuthError(l));
      }, (r) {
        userCredential = r;
      });
    });
  }

  Future<void> signUpWithFacebook() async {
    authRepo.signInWithFacebook(false).then((value) {
      value.fold((l) {
        emit(AuthError(l));
      }, (r) {
        userCredential = r;
      });
    });
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    authRepo.signIn(email, password).then((value) {
      value.fold((l) {
        emit(AuthError(l));
      }, (r) {
        userCredential = r;
      });
    });
  }

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    authRepo.signUpWithEmailAndPassword(email, password).then((value) {
      value.fold((l) {
        emit(AuthError(l));
      }, (r) {
        userCredential = r;
      });
    });
  }


  Future<void> verifiedEmail() async {
    if (FirebaseAuth.instance.currentUser?.emailVerified == true) {
      emit(AuthSuccess());
    }else{
      FirebaseAuth.instance.currentUser?.sendEmailVerification();
    }
  }


  // void setTimerAutoRedirect() {
  //   Timer.periodic(const Duration(seconds: 3), (timer) {
  //     FirebaseAuth.instance.currentUser?.reload();
  //     if(FirebaseAuth.instance.currentUser?.emailVerified == true){
  //       emit(AuthSuccess());
  //       timer.cancel();
  //     }
  //   });
  // }



  void redirect() {
    FirebaseAuth.instance.currentUser?.reload();
    if(FirebaseAuth.instance.currentUser?.emailVerified == true){
      emit(AuthSuccess());
    }else{
      emit(AuthError("Please verify your email"));
    }

  }




}
