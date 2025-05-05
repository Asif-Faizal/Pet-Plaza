import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petplaza/features/dashboard/presentation/homescreen.dart';
import 'package:petplaza/features/login/cubit/login_cubit.dart';
import 'package:petplaza/features/splash/presentation/individual_or_centre_screen.dart';

import '../bloc/bloc/login_bloc.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final TextEditingController _emailOrPhoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailOrPhoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocBuilder<LoginCubit, LoginTextFieldState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: SizedBox.shrink(),
            ),
            body: BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginSuccess) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Homescreen(profilePic: state.loginEntity.imageUrl, name: state.loginEntity.name, token: state.loginEntity.token),
                    ),
                    (route) => false,
                  );
                } else if (state is LoginFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                      content: Text(state.message),
                    ),
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 50, top: 70, right: 50),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Login", style: theme.textTheme.labelLarge),
                      Text(
                        "To proceed with your account, you must login",
                        style: theme.textTheme.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 100),
                      Text(
                        state.isEmail ? "Email" : "Phone number",
                        style: theme.textTheme.bodyMedium,
                      ),
                      SizedBox(height: 5),
                      TextFormField(
                        controller: _emailOrPhoneController,
                        keyboardType: state.isEmail
                            ? TextInputType.emailAddress
                            : TextInputType.phone,
                        onChanged: (value) {
                          context.read<LoginCubit>().updateEmailOrPhone(value);
                        },
                        maxLength: state.isEmail ? 30 : 10,
                        decoration: InputDecoration(
                          counterText: '',
                          errorText: state.errorMessage,
                          prefixIcon: !state.isEmail
                              ? Container(
                                  width: 80,
                                  padding: EdgeInsets.only(left: 15),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: state.selectedCountryCode,
                                      isDense: true,
                                      items: [
                                        DropdownMenuItem(
                                          value: '+1',
                                          child: Text('+1'),
                                        ),
                                        DropdownMenuItem(
                                          value: '+44',
                                          child: Text('+44'),
                                        ),
                                        DropdownMenuItem(
                                          value: '+91',
                                          child: Text('+91'),
                                        ),
                                      ],
                                      onChanged: (String? code) {
                                        if (code != null) {
                                          context
                                              .read<LoginCubit>()
                                              .updateCountryCode(code);
                                        }
                                      },
                                    ),
                                  ),
                                )
                              : null,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              context.read<LoginCubit>().toggleInputType();
                            },
                            child: Text(
                              state.isEmail ? "Use Phone" : "Use Email",
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(color: Colors.deepPurpleAccent),
                            ),
                          ),
                        ],
                      ),
                      Text("Password", style: theme.textTheme.bodyMedium),
                      SizedBox(height: 5),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        onChanged: (value) {
                          context.read<LoginCubit>().updatePassword(value);
                        },
                        decoration: InputDecoration(
                          counterText: '',
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?"),
                          SizedBox(width: 5),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => IndividualOrCentreScreen()),
                              );
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(color: Colors.deepPurpleAccent),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 30),
                      SizedBox(
                        height: 60,
                        child: ElevatedButton(
                          onPressed: state.isValid && state.password.length == 6
                              ? () {
                                  context.read<LoginBloc>().add(
                                      LoginButtonPressed(
                                          identifier:
                                              _emailOrPhoneController.text,
                                          passcode: _passwordController.text));
                                }
                              : () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.red,
                                      behavior: SnackBarBehavior.floating,
                                      content: Text(
                                          "Please enter a valid email or phone number and password"),
                                    ),
                                  );
                                },
                          child: Center(
                              child: BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                              if (state is LoginLoading) {
                                return SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator());
                              }
                              return Text("Login");
                            },
                          )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
