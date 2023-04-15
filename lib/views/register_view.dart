import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController? _email;
  TextEditingController? _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email?.dispose();
    _password?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
        ),
        body: FutureBuilder(
          future: Firebase.initializeApp(
              options: DefaultFirebaseOptions.currentPlatform),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Text('Node...');
              case ConnectionState.waiting:
                return const Text('Waiting...');
              case ConnectionState.active:
                return const Text('Active...');
              case ConnectionState.done:
                return Column(
                  children: [
                    TextField(
                      controller: _email,
                      enableSuggestions: false,
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Enter your email here',
                      ),
                    ),
                    TextField(
                      controller: _password,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                          hintText: 'Enter your password here'),
                    ),
                    TextButton(
                      onPressed: () async {
                        final email = _email?.text ?? "";
                        final password = _password?.text ?? "";

                       try {
                          final userCredential = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: email, password: password);
                          print(userCredential);
                        } on FirebaseAuthException catch (e) {
                          print(e.code);
                          if (e.code == 'network-request-failed') {
                            print('netword request failed');
                          } else if (e.code == 'weak-password') {
                            print('password is weak');
                          } else if (e.code == 'email-already-in-use') {
                            print('Email is already in use');
                          } else if (e.code == 'invalid-email') {
                            print('Email is invalid');
                          } else {
                            print('SOMETHING ELSE HAPPED');
                          }
                        }
                      },
                      child: const Text('Register'),
                    ),
                  ],
                );
              default:
                return const Text('Loading...');
            }
          },
        ));
  }
}