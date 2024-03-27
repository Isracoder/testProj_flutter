// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../firebase_options.dart';
import 'dart:developer' as devtools show log;

import 'package:test_proj/constants/routes.dart';
import 'package:test_proj/services/auth/auth_exceptions.dart';
import 'package:test_proj/services/auth/auth_service.dart';
import 'package:test_proj/utilities/show_error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

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
              try {
                // final userCredential =
                await AuthService.firebase().createUser(
                  email: email,
                  password: password,
                );
                // final user = AuthService.firebase().currentUser;

                AuthService.firebase().sendEmailVerification();
                Navigator.of(context).pushNamed(verifyEmailRoute);
                // devtools.log(userCredential.toString());
              } on WeakPasswordAuthException {
                await showErrorDialog(context, 'Weak password');
              } on EmailAlreadyInUseAuthException {
                await showErrorDialog(context, 'Email already in use');
              } on InvalidEmailAuthException {
                await showErrorDialog(context, 'Invalid email address');
              } on GenericAuthException {
                await showErrorDialog(context, "Failed to Register");
              }
            },
            child: const Text('Register'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                loginRoute,
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
