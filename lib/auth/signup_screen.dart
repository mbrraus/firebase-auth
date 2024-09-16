import 'package:auth_app/auth/auth_service.dart';
import 'package:auth_app/auth/login_screen.dart';
import 'package:flutter/material.dart';

import '../utils/constant.dart';
import '../pages/home.dart';
import '../widget/button.dart';
import '../widget/textfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _auth = AuthService();

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _name.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Sign up', style: montserratHeader),
              const SizedBox(height: 50),
              CustomTextField(
                hint: 'Enter your name',
                label: 'Name',
                controller: _name,
              ),
              const SizedBox(height: 25),
              CustomTextField(
                hint: 'Enter your email',
                label: 'Email',
                controller: _email,
              ),
              const SizedBox(height: 25),
              CustomTextField(
                isPassword: true,
                hint: 'Enter your password',
                label: 'Password',
                controller: _password,
              ),
              const SizedBox(height: 25),
              CustomButton(label: 'Sign up', onPressed: _signup),
              const SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text("Already have an account? ", style: montserratBody.copyWith(fontSize: 13),),
                const SizedBox(width: 5),
                InkWell(
                  onTap: () => goToLogin(context),
                  child: Text("Login",
                      style: montserratBody.copyWith(fontSize: 13, color: Colors.blue)),
                )
              ]),
            ],
          ),
        ),
      ),
    );
  }

  goToLogin(BuildContext context) => Navigator.push(
      context, MaterialPageRoute(builder: (context) => const LoginScreen()));

  goToHome(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );

  _signup() async {
    final user =
        await _auth.createUserWithEmailAndPassword(_email.text, _password.text);
    goToHome(context);
    if (user != null) {
      debugPrint('user created successfully');
    }
  }
}
