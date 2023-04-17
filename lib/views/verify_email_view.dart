import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beginner/constants/index.dart' as constants;
import 'package:flutter_beginner/services/auth/auth_exceptions.dart';

import '../utilities/index.dart';

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
          Navigator.of(context)
              .pushNamedAndRemoveUntil(constants.homeRoute, (route) => false);
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
              String? message;
              try {
                final user = FirebaseAuth.instance.currentUser;
                await user?.sendEmailVerification();
              } on NetworkRequestFailedException catch (_) {
                message = constants.networkRequestFailedMessageError;
              } on GenericAuthException catch (_) {
                message = constants.genericAuthExceptionMessageError;
              } finally {
                if (message != null) {
                  showErrorDialog(context, message);
                }
              }
            },
            child: const Text('Send email verification'),
          ),
          TextButton(
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
