import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petplaza/features/login/presentation/loginpage.dart';
import 'package:petplaza/features/register/cubit/register_cubit.dart';
import 'package:petplaza/features/register/presentation/profilepic.dart';

class Createacc extends StatefulWidget {
  const Createacc({super.key, required this.isIndividual});
  final bool isIndividual;

  @override
  State<Createacc> createState() => _CreateaccState();
}

class _CreateaccState extends State<Createacc> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _managerNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _locationController.dispose();
    _managerNameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (context) => RegisterCubit(isIndividual: widget.isIndividual),
      child: BlocBuilder<RegisterCubit, RegisterTextFieldState>(
        builder: (context, state) {
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
                    SizedBox(height: 50),
                    Text("Name", style: theme.textTheme.bodyMedium),
                    SizedBox(height: 5),
                    TextFormField(
                      controller: _nameController,
                      onChanged: (value) =>
                          context.read<RegisterCubit>().updateName(value),
                      decoration: InputDecoration(
                        errorText: state.nameError,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text("Phone number", style: theme.textTheme.bodyMedium),
                    SizedBox(height: 5),
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      onChanged: (value) => context
                          .read<RegisterCubit>()
                          .updatePhoneNumber(value),
                      decoration: InputDecoration(
                        counterText: '',
                        errorText: state.phoneError,
                        prefixIcon: Container(
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
                                      .read<RegisterCubit>()
                                      .updateCountryCode(code);
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text("Email", style: theme.textTheme.bodyMedium),
                    SizedBox(height: 5),
                    TextFormField(
                      controller: _emailController,
                      onChanged: (value) =>
                          context.read<RegisterCubit>().updateEmail(value),
                      decoration: InputDecoration(
                        errorText: state.emailError,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text("Location", style: theme.textTheme.bodyMedium),
                    SizedBox(height: 5),
                    TextFormField(
                      controller: _locationController,
                      onChanged: (value) =>
                          context.read<RegisterCubit>().updateLocation(value),
                      decoration: InputDecoration(
                        errorText: state.locationError,
                      ),
                    ),
                    if (!widget.isIndividual) ...[
                      SizedBox(height: 20),
                      Text("Manager Name", style: theme.textTheme.bodyMedium),
                      SizedBox(height: 5),
                      TextFormField(
                        controller: _managerNameController,
                        onChanged: (value) => context
                            .read<RegisterCubit>()
                            .updateManagerName(value),
                        decoration: InputDecoration(
                          errorText: state.managerNameError,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text("Address", style: theme.textTheme.bodyMedium),
                      SizedBox(height: 5),
                      TextFormField(
                        controller: _addressController,
                        onChanged: (value) =>
                            context.read<RegisterCubit>().updateAddress(value),
                        decoration: InputDecoration(
                          errorText: state.addressError,
                        ),
                      ),
                    ],
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("already have an account?"),
                        SizedBox(width: 5),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Loginpage()),
                            );
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color:
                                    const Color.fromARGB(255, 158, 127, 246)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              color: Colors.transparent,
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: state.isFormValid
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Profilepic(
                                  isIndividual: widget.isIndividual,
                                  name: _nameController.text,
                                  phoneNumber: _phoneController.text,
                                  email: _emailController.text,
                                  location: _locationController.text,
                                  managerName: _managerNameController.text,
                                  address: _addressController.text,
                                )),
                          );
                        }
                      : () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                              content: Text("Please fill all the fields"),
                            ),
                          );
                        },
                  child: Text("Sign up"),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
