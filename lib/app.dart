import 'package:bliszo1/features/auth/data/firebase_auth_repo.dart';
import 'package:bliszo1/features/home/presentation/pages/home_page.dart';
import 'package:bliszo1/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:bliszo1/features/auth/presentation/cubits/auth_states.dart';
import 'package:bliszo1/features/auth/presentation/pages/auth_page.dart';
import 'package:bliszo1/features/profile/data/firebase_profile_repo.dart';
import 'package:bliszo1/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:bliszo1/themes/light_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {

  // auth repo
  final authRepo = FirebaseAuthRepo();

  // profile repo
  final profileRepo = FirebaseProfileRepo();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // provide cubit to app
    return MultiBlocProvider(
      providers: [
        // auth cubit
        BlocProvider<AuthCubit>(create: (context) => AuthCubit(authRepo: authRepo)..checkAuth(),
        ),

        // profile cubit
        BlocProvider<ProfileCubit>(create: (context) => ProfileCubit(profileRepo: profileRepo),)
      ],
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      home: BlocConsumer<AuthCubit, AuthState>(
        builder: (context, authState) {
          print(authState);

          // unauthenticated -> auth page (login/register)
          if (authState is Unauthenticated) {
            return AuthPage();
          }

          // authenticated -> home page
          if (authState is Authenticated) {
            return HomePage(); 
          }

          // loading..
          else {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator(),
              ),
            );
          }
        }, 


        // listen for errors..
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
    )
    ),
      );
  }
}