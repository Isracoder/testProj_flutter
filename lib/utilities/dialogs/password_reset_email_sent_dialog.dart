import 'package:flutter/material.dart';
import 'package:test_proj/utilities/dialogs/generic_dialog.dart';

Future<void> showPasswordResetSentDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Password Reset',
    content:
        'We\'ve sent you a password reset link.Please check your email for more information',
    optionsBuilder: () => {
      'Ok': null,
    },
  );
}
