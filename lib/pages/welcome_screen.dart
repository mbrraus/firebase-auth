import 'package:auth_app/auth/login_screen.dart';
import 'package:auth_app/auth/signup_screen.dart';
import 'package:auth_app/pages/home.dart';
import 'package:auth_app/pages/register_screen.dart';
import 'package:auth_app/widget/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:auth_app/utils/constant.dart';

import 'package:provider/provider.dart';
import 'package:auth_app/provider/auth_provider.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<MyAuthProvider>(context, listen: false);

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/get_started.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, bottom: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Let\'s', style: montserratBold),
                Text('get', style: montserratBold),
                Text('started.', style: montserratBold),
                const SizedBox(height: 100),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 640),
            child: Center(
              child: Column(
                children: [
                  CustomButton(
                      label: 'Create an account',
                      onPressed: () {
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterScreen()));
                      }),
                  const SizedBox(
                    height: 32,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    child: Text('Or Sign in',
                        style: montserratHeader.copyWith(
                            color: Colors.white, fontSize: 17)),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
