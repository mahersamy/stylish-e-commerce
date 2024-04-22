import 'package:flutter/material.dart';

import '../../data/repository/sign_in_repo.dart';



class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              ElevatedButton(onPressed: ()async{
                await SignInRepo().signInWithGoogle();
              }, child: Text('Sign In with google')),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: (){
                SignInRepo().signInWithFacebook().then((value){
                  print(value.user?.email);
                });
              }, child: Text('Sign In with facebook')),
            ],
          ),
        ),
      ),
    );
  }
}
