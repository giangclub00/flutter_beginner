import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'dart:developer' as devtools show log;
import 'package:flutter_beginner/constants/constants.dart' as constants;

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Column(
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
              hintText: 'Enter your password here',
            ),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                showLoadding(context);
                await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
                if (!mounted) return;
                Navigator.of(context).pushNamedAndRemoveUntil(constants.home, (route) => false);
              } on FirebaseAuthException catch (e) {
                devtools.log(e.toString());
                String errString = '';
                switch (e.code) {
                  case 'user-not-found':
                    errString = 'User not found';
                    break;
                  case 'wrong-password':
                    errString = 'Wrong password';
                    break;
                  case 'invalid-email':
                    errString = 'Invalid email';
                    break;
                  case 'network-request-failed':
                    errString = 'Network request failed';
                    break;
                  default:
                    errString = 'Error firebase auth';
                    break;
                }
                Navigator.of(context).pop();
                showAlertDialog(context, errString);
              }
            },
            child: const Text('Login'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                constants.register,
                (route) => false,
              );
            },
            child: const Text('Not registered yet? Register here!'),
          )
        ],
      ),
    );
  }
}

showAlertDialog(BuildContext context, String errorString) {
  // set up the buttons
  Widget okButton = TextButton(
    child: const Text("Ok"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Error"),
    content: Text(errorString),
    actions: [okButton],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showLoadding(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Row(
      children: [
        const CircularProgressIndicator(),
        Container(margin: const EdgeInsets.only(left: 5), child: const Text("Loading")),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
