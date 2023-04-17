import 'package:flutter/material.dart';

import 'package:flutter_beginner/constants/index.dart' as constants;
import 'package:flutter_beginner/services/auth/auth_exceptions.dart';
import 'package:flutter_beginner/services/auth/auth_service.dart';
import 'package:flutter_beginner/utilities/show_error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
        title: const Text('Register'),
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
              String? message;
              try {
                await AuthService.firebase().createUser(email: email,password: password,);
                await AuthService.firebase().sendEmailVerification();
                if(!mounted) return;
                Navigator.of(context).pushNamedAndRemoveUntil(constants.homeRoute, (route) => false);
              } on WeakPasswordAuthException catch (_) {
                message = constants.weakPasswordMessageError;
              } on EmailAlreadyInUseAuthException catch (_) {
                message = constants.emailAlreadyInUseMessageError;
              } on InvalidEmailAuthException catch (_) {
                message = constants.invalidEmailMessageError;
              } on GenericAuthException catch (e) {
                message = constants.genericAuthExceptionMessageError;
                print(e);
              }finally {
                if (message != null) {
                  showErrorDialog(context, message);
                }
              }
            },
            child: const Text('Register'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                constants.loginRoute,
                (route) => false,
              );
            },
            child: const Text('Already registered? Login here!'),
          )
        ],
      ),
    );
  }
}