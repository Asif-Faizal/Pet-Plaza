import 'package:flutter/material.dart';
import 'package:petplaza/features/login/presentation/loginpage.dart';
import 'package:petplaza/features/register/presentation/profilepic.dart';

class Createacc extends StatefulWidget {
  const Createacc({super.key});

  @override
  State<Createacc> createState() => _CreateaccState();
}

class _CreateaccState extends State<Createacc> {
  
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: SizedBox.shrink(),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 50, right: 50),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Creating Account",
                style: theme.textTheme.labelLarge,
              ),
              Text(
                "Creating an account is required to continue",
                style: theme.textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                "Name",
                style: theme.textTheme.bodyMedium,
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: _nameController,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Phone number",
                style: theme.textTheme.bodyMedium,
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: InputDecoration(
                  counterText: '',
                ),
                controller: _phoneController,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Email",
                style: theme.textTheme.bodyMedium,
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: _emailController,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Location",
                style: theme.textTheme.bodyMedium,
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: _locationController,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("already have an account?"),
                  SizedBox(
                    width: 5,
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Loginpage()));
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: const Color.fromARGB(255, 158, 127, 246)),
                      ))
                ],
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Profilepic()));
                      },
                      child: Text("Sign up"))),
            ],
          ),
        ),
      ),
    );
  }
}
