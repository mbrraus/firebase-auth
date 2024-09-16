import 'package:auth_app/utils/constant.dart';
import 'package:auth_app/widget/button.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController phoneController = TextEditingController();

  Country selectedCountry = Country(
    phoneCode: "90",
    countryCode: "TR",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "Turkey",
    example: "Turkey",
    displayName: "Turkey",
    displayNameNoCountryCode: "TR",
    e164Key: "",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                  Container(
                    width: 300,
                    height: 300,
                    padding: const EdgeInsets.all(20.0),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      "assets/images/sign_up.png",
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text('Register',
                      style: montserratBody.copyWith(
                          color: Colors.black, fontSize: 20)),
                  const SizedBox(height: 10),
                  const Text(
                    'Add your phone number. We\'ll send you a verification code.',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  SingleChildScrollView(
                    child: TextFormField(
                      cursorColor: Colors.purple,
                      controller: phoneController,
                      style: montserratBody.copyWith(fontSize: 17),
                      onChanged: (value) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                          hintText: 'Enter your phone number',
                          hintStyle: montserratBody.copyWith(
                              // fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Colors.grey.shade600),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.black12)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.black12)),
                          prefixIcon: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 13.5, horizontal: 13.5),
                            child: InkWell(
                              onTap: () {
                                showCountryPicker(
                                    context: context,
                                    countryListTheme: const CountryListThemeData(
                                        bottomSheetHeight: 370),
                                    onSelect: (value) {
                                      setState(() {
                                        selectedCountry = value;
                                      });
                                    });
                              },
                              child: Text(
                                // textAlign: TextAlign.center,
                                "${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}",
                                style: montserratBody.copyWith(
                                  fontSize: 17,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          suffixIcon: phoneController.text.length == 10
                              ? Container(
                                  height: 30,
                                  width: 30,
                                  margin: const EdgeInsets.all(10.0),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green,
                                  ),
                                  child: const Icon(
                                    Icons.done,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                )
                              : null),
                    ),
                  ),
                  const SizedBox(height: 35),
                  SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                          onPressed: () => sendPhoneNumber(),
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.deepPurple),
                          child: Text(
                            'Sign up with phone',
                            style: montserratBody.copyWith(fontSize: 16),
                          ))),
                ],
              ),
            ),
          )),
    );
  }

  void sendPhoneNumber() {
    final ap = Provider.of<MyAuthProvider>(context, listen: false);
    String phoneNumber = phoneController.text.trim();
    print(phoneNumber);
    ap.signInWithPhone(context, '+${selectedCountry.phoneCode}$phoneNumber');
    print('+${selectedCountry.phoneCode}$phoneNumber');
  }
}
