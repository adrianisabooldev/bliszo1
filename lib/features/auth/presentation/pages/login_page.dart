/*

LOGIN PAGE

On this page, an existing user can login with their:

- email
- pw

----------------------------

Once the user successfully logs in, they will be redirected to home page.

If user dosen't have an account yet, they can go to the register page from here to create one.

*/

import 'package:bliszo1/features/auth/presentation/components/my_button.dart';
import 'package:bliszo1/features/auth/presentation/components/my_text_field.dart';
import 'package:bliszo1/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  final void Function()? togglePages;

  const LoginPage({super.key, required this.togglePages,});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  // text controllers
  final emailController = TextEditingController();
  final pwController = TextEditingController();

  // login button pressed
  void login() {
    // prepare email & pw
    final String email = emailController.text;
    final String pw = pwController.text;

    // auth cubit
    final authCubit = context.read<AuthCubit>();

    // ensure that the email & pw fields are not empty
    if (email.isNotEmpty && pw.isNotEmpty) {
      // login!
      authCubit.login(email, pw);
    }

    // display error if some fields are empty
    else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please enter both email and password")));
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    pwController.dispose();
    super.dispose();
  }

  // BUILD UI
  @override
  Widget build(BuildContext context) {

    // SCAFFOLD
    return Scaffold(

    // BODY
    body: SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          
              // logo
            IconTheme(
            data: IconThemeData(
            color: Theme.of(context).colorScheme.primary,
            ),
            child: Icon(
            Icons.lock_open_rounded,
            size: 80,
            ),
            ),
          
            SizedBox(height: 50),
          
            // welcome back msg
            Text("Welcome back, you've been missed!",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16,
              ),
            ),
          
             SizedBox(height: 50),
          
            // email textfield
            MyTextField(
            controller: emailController, 
            hintText: "Email", 
            obscureText: false,
            ),

            SizedBox(height: 10),
          
            // pw textfield
             MyTextField(
            controller: pwController, 
            hintText: "Password", 
            obscureText: true,
            ),

            SizedBox(height: 25),
          
            // login button
            MyButton(
              onTap: login, 
              text: "Login",
              ),

              SizedBox(height: 50),
          
            // not a member? register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Not a member?",
                  style: TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                GestureDetector(
                  onTap: widget.togglePages,
                  child: Text(
                    " Register now",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold,
                      ),
                    ),
                )
              ],
            )
          
          ],
          ),
        ),
      ),
    ),

    );
  }
}