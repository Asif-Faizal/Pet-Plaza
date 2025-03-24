import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:petplaza/features/register/presentation/createacc.dart';
import 'package:petplaza/features/login/presentation/loginpage.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 30),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Welcome To",style: theme.textTheme.titleLarge,),
              Text("Pet-Plaza",style: theme.textTheme.displayLarge,),
              SizedBox(height: 60,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Lottie.asset("lib/core/asset/animation/initial.json"),
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(onPressed: (){
                  Navigator.push(context,
                   MaterialPageRoute(builder: (context)=> Createacc()));
                }, child: Text("Create Account"))),
                SizedBox(height: 25,),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: OutlinedButton(onPressed: (){
                  Navigator.push(context,
                   MaterialPageRoute(builder: (context)=> Loginpage()));
                }, child: Text("Login"))),
                
              SizedBox(height: 60,),
            ],
          ),
        ),
      )
    );
  }
}