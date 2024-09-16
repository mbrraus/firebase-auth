import 'package:auth_app/pages/welcome_screen.dart';
import 'package:auth_app/provider/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/constant.dart';
import '../models/user_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<MyAuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text(
          "Home Screen",
          style: montserratHeader.copyWith(fontSize: 20, color: Colors.white),
          textAlign: TextAlign.left,
        ),
        actions: [
          IconButton(
            onPressed: () {
              ap.userSignOut().then(
                    (value) => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                        const WelcomeScreen(),
                      ),
                    ),
                  );
            },
            icon: const Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Center(
        child: Text(
          ' Hoş Geldin ${ap.userModel.name}!',
          style: montserratHeader,
        ),
      ),
    );
  }
}
