import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beginner/firebase_options.dart';
import 'package:flutter_beginner/views/home_view.dart';
import 'package:flutter_beginner/views/index.dart';

import 'constants/index.dart' as constants;
import 'dart:developer' as devtools show log;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(),
      routes: {
        constants.homeRoute: (context) => const MainPage(),
        constants.loginRoute: (context) => const LoginView(),
        constants.registerRoute: (context) => const RegisterView(),
        constants.verifyEmailRoute: (context) => const VerifyEmailView(),
      },
    ),
  );
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              devtools.log(user.toString());
              if (user.emailVerified) {
                devtools.log('Email is verified');
                return const HomeView();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }
          default:
            return const CircularProgressIndicator(backgroundColor: Colors.red);
        }
      },
    );
  }
}

