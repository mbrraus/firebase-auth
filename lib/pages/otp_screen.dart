import 'package:auth_app/pages/home.dart';
import 'package:auth_app/pages/user_info_screen.dart';
import 'package:auth_app/provider/auth_provider.dart';
import 'package:auth_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../utils/constant.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;

  const OtpScreen({super.key, required this.verificationId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? otpCode;

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
                  "assets/images/image1.png",
                ),
              ),
              const SizedBox(height: 10),
              Text('Verification',
                  style: montserratBody.copyWith(
                      color: Colors.black, fontSize: 20)),
              const SizedBox(height: 10),
              const Text(
                'Enter the OTP send to your phone number',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Pinput(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                length: 6,
                showCursor: true,
                defaultPinTheme: PinTheme(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color:
                        Colors.purple.shade200)),
                    textStyle: montserratBody.copyWith(
                        color: Colors.deepPurple.shade300,
                        fontSize: 23)),
                onCompleted: (value) {
                  setState(() {
                    otpCode = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ElevatedButton(
                    onPressed: () {
                      if (otpCode != null) {
                        verifyOtp(context, otpCode!);
                      } else {
                        showSnackBar(context, 'Enter 6-digit code');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.deepPurple),
                    child: Text(
                      'Verify',
                      style: montserratBody.copyWith(fontSize: 16),
                    )),
              ),
            ],
          ),
        ),
      )),
    );
  }

  void verifyOtp(BuildContext context, String userOtp) {
    final ap = Provider.of<MyAuthProvider>(context, listen: false);
    ap.verifyOtp(
        context: context,
        verificationId: widget.verificationId,
        userOtp: userOtp,
        onSuccess: () {
          //success olursa userin exist olup olmadigini kontrol et
          ap.checkExistingUser().then((value) async {
            if (value == true) {
              await ap.getDataFromFireStore().then((value) => ap
                  .saveUserDataToSP()
                  .then((value) => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const Home()),
                        (route) => false,
                      )));
            } else {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserInformationScreen()),
                  (route) => false);
            }
          });
        });
  }
}
