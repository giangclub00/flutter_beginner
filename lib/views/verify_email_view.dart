import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beginner/constants/constants.dart' as constants;
import 'dart:developer' as devtools show log;

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();

  Future<void> myAsyncMethod(BuildContext context) async {
    Navigator.of(context).pushNamedAndRemoveUntil(
      '/login/',
      (route) => false,
    );
  }
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  String username = "";
  bool? _isUserEmailVerified = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    username = FirebaseAuth.instance.currentUser?.email ?? '';

    Future(() async {
      _timer = Timer.periodic(const Duration(seconds: 10), (timer) async {
        await FirebaseAuth.instance.currentUser?.reload();
        var user = FirebaseAuth.instance.currentUser;
        var isVerify = user?.emailVerified ?? false;
        if (isVerify) {
          setState(() {
            _isUserEmailVerified = isVerify;
          });
          timer.cancel();
          if (!mounted) return;
            Navigator.of(context).pushNamedAndRemoveUntil(constants.home, (route) => false);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify email'),
      ),
      body: Column(
        children: [
          Text('Verify: $_isUserEmailVerified'),
          Text("username: $username"),
          TextButton(
            onPressed: () async {
              try {
                final user = FirebaseAuth.instance.currentUser;
                await user?.sendEmailVerification();
              } catch (e) {
                devtools.log(e.toString());
              }
            },
            child: const Text('Send email verification'),
          ),
          TextButton(
              // onPressed: () async {
              //   await FirebaseAuth.instance.signOut();
              //   Navigator.of(context).pushNamedAndRemoveUntil(
              //   '/login/',
              //   (route) => false,
              //   );
              // },
              onPressed: () => const VerifyEmailView().myAsyncMethod(context),
              child: const Text('Logout')),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer?.cancel();
    }
  }
}
