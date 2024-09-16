import 'package:auth_app/auth/signup_screen.dart';
import 'package:auth_app/utils/constant.dart';
import 'package:auth_app/pages/register_screen.dart';
import 'package:auth_app/widget/button.dart';
import 'package:auth_app/widget/textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../pages/home.dart';
import '../provider/auth_provider.dart';
import 'auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = AuthService();

  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.deepPurple,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Sign in', style: montserratHeader),
                    const SizedBox(height: 50),
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
                    SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                            onPressed: () => _login(context),
                            style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.deepPurple),
                            child: Text(
                              'Sign in',
                              style: montserratBody.copyWith(fontSize: 16),
                            ))),
                    const SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "or sign in with phone ",
                          style: montserratBody.copyWith(
                              fontSize: 13, color: Colors.red),
                        ),
                        IconButton(
                          onPressed: () => goToSignup(context),
                          icon: const Icon(
                            Icons.phone_iphone_outlined,
                            color: Colors.deepPurple,
                          ),
                        ),
                        const SizedBox(width: 3),
                      ],
                    ),
                  ],
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  "Don't you have an account? ",
                  style: montserratBody.copyWith(fontSize: 13),
                ),
                const SizedBox(width: 5),
                InkWell(
                  onTap: () => goToSignup(context),
                  child: Text("Sign up",
                      style: montserratBody.copyWith(
                          fontSize: 13, color: Colors.red)),
                )
              ]),
            ],
          ),
        ),
      ),
    );
  }

  goToSignup(BuildContext context) => Navigator.push(
      context, MaterialPageRoute(builder: (context) => const RegisterScreen()));

  goToHome(BuildContext context) => Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => const Home()), (route) => false);

  _login(BuildContext context) async {
    final user =
    await _auth.loginUserWithEmailAndPassword(_email.text, _password.text);
    if (user != null) {
      debugPrint('user logged in');
      await Provider.of<MyAuthProvider>(context, listen: false).getDataFromFireStore();
      goToHome(context);
    } else {
      debugPrint('login failed');
    }
  }
}
