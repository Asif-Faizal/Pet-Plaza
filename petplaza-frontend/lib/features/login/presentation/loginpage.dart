import 'dart:io';

import 'package:flutter/material.dart';
import 'package:petplaza/features/register/presentation/createacc.dart';

class Loginpage extends StatefulWidget {
   Loginpage({super.key});

  final TextEditingController _emailorphonenumberController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: SizedBox.shrink(),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 50,top: 70,right: 50),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Login",style: theme.textTheme.labelLarge,),
              Text("To proceed with your account, you must login",
              style: theme.textTheme.bodySmall,textAlign: TextAlign.center,),
              SizedBox(height: 100,),
              Text("Email or Phone number",style: theme.textTheme.bodyMedium,),
              SizedBox(height: 5,),
              TextFormField(
                
                keyboardType: TextInputType.emailAddress,
                onFieldSubmitted: (value) {
                  
                },
              ),
              SizedBox(height: 30,),
              Text("Password",style: theme.textTheme.bodyMedium,),
              SizedBox(height: 5,),
              TextFormField(
                obscureText: true,
                keyboardType: TextInputType.number,
                maxLength: 6,
                decoration: InputDecoration(
                  counterText: ''
                ),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  SizedBox(width: 5,),
                  InkWell
                  (
                    onTap: (){
                      Navigator.pushReplacement(context, 
                      MaterialPageRoute(builder: (context)=> Createacc()));
                    },
                    child: Text("Sign Up",style: TextStyle(color: Colors.deepPurpleAccent),))
                ],
              ),
              SizedBox(height: 30,),
              SizedBox(
                height: 60,
                child: ElevatedButton(onPressed: (){},
                 child: Center(child: Text("Login"))),
              )
            ],
          ),
        ),
      ),
    );
  }
}