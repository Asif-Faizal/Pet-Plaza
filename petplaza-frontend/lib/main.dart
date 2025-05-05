import 'package:flutter/material.dart';
import 'package:petplaza/core/injection/dependency_injection.dart';
import 'package:petplaza/features/register/bloc/register_user/register_user_bloc.dart';
import 'package:petplaza/features/splash/presentation/initial_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/injection/dependency_injection.dart' as di;

import 'core/theme/app_theme.dart';
import 'features/dashboard/bloc/adoption_request/adoption_requests_bloc.dart';
import 'features/dashboard/bloc/pet/pet_bloc.dart';
import 'features/dashboard/bloc/user_adoption_requests/user_adoption_requests_bloc.dart';
import 'features/login/bloc/bloc/login_bloc.dart';
import 'features/login/cubit/login_cubit.dart';
import 'features/register/cubit/register_cubit.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Required for async initialization
  await initDependencies(); // Awaiting DI before starting the app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return di.sl<RegisterUserBloc>();
          },
        ),
        BlocProvider(
          create: (context) {
            return di.sl<LoginCubit>();
          },
        ),
        BlocProvider(
          create: (context) {
            return di.sl<RegisterCubit>();
          },
        ),
        BlocProvider(
          create: (context) {
            return di.sl<LoginBloc>();
          },
        ),
        BlocProvider(
          create: (context) {
            return di.sl<PetBloc>();
          },
        ),
        BlocProvider(
          create: (context) {
            return di.sl<AdoptionRequestsBloc>();
          },
        ),
        BlocProvider(
          create: (context) {
            return di.sl<UserAdoptionRequestsBloc>();
          },
        ),
      ],
      child: MaterialApp(
        home: InitialPage(), // Initial Page
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        themeMode: ThemeMode.system,
      ),
    );
  }
}
