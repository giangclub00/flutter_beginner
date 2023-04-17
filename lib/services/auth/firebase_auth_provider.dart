import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_beginner/constants/index.dart' as constants;
import 'package:flutter_beginner/firebase_options.dart';
import 'package:flutter_beginner/services/auth/auth_user.dart';
import 'package:flutter_beginner/services/auth/auth_provider.dart';
import 'package:flutter_beginner/services/auth/auth_exceptions.dart';

import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth, FirebaseAuthException;

class FirebaseAuthProvider implements AuthProvider {

  @override
  AuthUser? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return AuthUser.fromFirebase(user);
    } else {
      return null;
    }
  }

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInAuthException();
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case constants.weakPasswordCode:            throw WeakPasswordAuthException();
        case constants.emailAlreadyInUseCode:       throw EmailAlreadyInUseAuthException();
        case constants.invalidEmailCode:            throw InvalidEmailAuthException();
        case constants.networkRequestFailedCode:    throw NetworkRequestFailedException();
        default:                        throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  @override
  Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInAuthException();
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case constants.userNotFoundCode:          throw UserNotFoundAuthException();  
        case constants.wrongPasswordCode:         throw WrongPasswordAuthException();
        case constants.networkRequestFailedCode:  throw NetworkRequestFailedException();
        default: throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  @override
  Future<void> logOut() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseAuth.instance.signOut();
    } else {
      throw UserNotLoggedInAuthException();
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await user.sendEmailVerification();
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case constants.networkRequestFailedCode:
            throw NetworkRequestFailedException();
          default:
            throw GenericAuthException();
        }
      } catch (_) {
        throw GenericAuthException();
      }
    } else {
      throw UserNotLoggedInAuthException();
    }
  }
}