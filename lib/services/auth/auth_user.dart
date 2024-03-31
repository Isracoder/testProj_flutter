import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/foundation.dart';

@immutable
class AuthUser {
  final bool isEmailVerified;
  final String email;
  final String id;
  const AuthUser({
    required this.id,
    required this.email,
    required this.isEmailVerified,
  });

  factory AuthUser.fromFirebase(User user) => AuthUser(
        email: user.email!,
        // unwrapped because only email auth is available currently ,
        // therefore i'm sure every user has an email
        id: user.uid,
        isEmailVerified: user.emailVerified,
      );
}
