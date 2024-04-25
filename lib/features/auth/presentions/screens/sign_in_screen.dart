import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish/features/auth/logic/cubits/auth_cubit.dart';




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
                BlocProvider.of<AuthCubit>(context).signUpWithGoogle();
              }, child: Text('Sign In with google')),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: (){

              }, child: Text('Sign In with facebook')),
            ],
          ),
        ),
      ),
    );
  }
}
