import 'package:auth_app/auth/signup_screen.dart';
import 'package:auth_app/utils/constant.dart';
import 'package:auth_app/models/user_model.dart';
import 'package:auth_app/provider/auth_provider.dart';
import 'package:auth_app/widget/button.dart';
import 'package:auth_app/widget/textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home.dart';

class UserInformationScreen extends StatefulWidget {
  const UserInformationScreen({super.key});

  @override
  State<UserInformationScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<UserInformationScreen> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _name.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                Text('Create an account', style: montserratHeader),
                const SizedBox(height: 50),
                CustomTextField(
                  hint: 'Enter your name',
                  label: 'Name',
                  controller: _name,
                ),
                const SizedBox(height: 25),
                CustomTextField(
                  hint: 'abc@example.com',
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
                        onPressed: () => storeData(),
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.deepPurple),
                        child: Text(
                          'Continue',
                          style: montserratBody.copyWith(fontSize: 16),
                        ))),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void storeData() async {
    final ap = Provider.of<MyAuthProvider>(context, listen: false);
    UserModel userModel = UserModel(
        name: _name.text, email: _email.text, phoneNumber: '', uid: '');
    ap.saveUserDataToFirebase(
        context: context,
        userModel: userModel,
        email: _email.text,
        password: _password.text,
        onSuccess: () {
          ap.saveUserDataToSP().then((value) => ap.setSignIn().then((value) =>
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                  (route) => false)));
        });
  }
}
