import 'package:flutter/material.dart';
import 'package:petplaza/features/login/presentation/loginpage.dart';
import 'package:petplaza/features/register/presentation/profilepic.dart';

class Createacc extends StatefulWidget {
  const Createacc({super.key});

  @override
  State<Createacc> createState() => _CreateaccState();
}

class _CreateaccState extends State<Createacc> {

  final TextEditingController _emailorphonenumberController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme =Theme.of(context);
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
              Text("Creating Account",style: theme.textTheme.labelLarge,),
              Text("Creating an account is required to continue",
              style: theme.textTheme.bodySmall,textAlign: TextAlign.center,),
              SizedBox(height: 50,),
              Text("Name",style: theme.textTheme.bodyMedium,),
              SizedBox(height: 5,),

              TextFormField(
              ),
              SizedBox(height: 20,),
              Text("Phone number",style: theme.textTheme.bodyMedium,),
              SizedBox(height: 5,),

              TextFormField(
              ),
              SizedBox(height: 20,),
              Text("Email",style: theme.textTheme.bodyMedium,),
              SizedBox(height: 5,),

              TextFormField(
              ),
              SizedBox(height: 20,),
              Text("Location",style: theme.textTheme.bodyMedium,),
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
                  Text("already have an account?"),
                  SizedBox(width: 5,),
                  InkWell
                  (
                    onTap: (){
                      Navigator.pushReplacement(context, 
                      MaterialPageRoute(builder: (context)=> Loginpage()));
                    },
                    child: Text("Login",style: TextStyle(color: Colors.deepPurpleAccent),))
                ],
              ),
              SizedBox(height: 30,),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Profilepic()));
                }, child: Text("Sign up"))),
            ],
          ),
        ),
      ),
    );
  }
}