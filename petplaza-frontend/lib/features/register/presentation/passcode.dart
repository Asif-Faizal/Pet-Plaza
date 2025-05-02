import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petplaza/features/register/bloc/register_user/register_user_bloc.dart';
import 'package:petplaza/features/register/data/register_user_model.dart';
import 'package:petplaza/features/dashboard/presentation/homescreen.dart';

class PasscodePage extends StatefulWidget {
  const PasscodePage({super.key, required this.profilePic});
  final File profilePic;

  @override
  State<PasscodePage> createState() => _PasscodePageState();
}

class _PasscodePageState extends State<PasscodePage> {
  // List of controllers and focus nodes
  final List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  String passcode = '';

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onSubmit() {
    setState(() {
      passcode = _controllers.map((controller) => controller.text).join();
    });
    if (passcode.length == 6) {
      final user = RegisterRequestModel(
          name: "asif",
          phoneNumber: "+917559913631",
          email: "asif@email.com",
          location: "palakkad",
          passcode: "222222",
          profilePic: widget.profilePic);
      context.read<RegisterUserBloc>().add(RegisterUserEvent(user));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          content: Text('Please enter 6 digits')));
    }
  }

  // Handling input changes and focus
  void _handleInput(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  @override
  void initState() {
    super.initState();
    final bloc = context.read<RegisterUserBloc>();
    print('Bloc found: $bloc');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),
            Text(
              "Enter Passcode",
              style: theme.textTheme.bodyLarge,
            ),

            SizedBox(
              height: 20,
            ),
            // Passcode TextFields
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (index) {
                return SizedBox(
                  width: 50,
                  height: 70,
                  child: TextField(
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                    decoration: const InputDecoration(
                      counterText: '',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    onChanged: (value) => _handleInput(value, index),
                    onSubmitted: (_) => _onSubmit(),
                  ),
                );
              }),
            ),
            Spacer(),

            // Submit Button
            SizedBox(
              height: 60,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _onSubmit,
                child: const Text('Submit Passcode'),
              ),
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
