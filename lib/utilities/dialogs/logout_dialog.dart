import 'package:flutter/widgets.dart';
import 'package:test_proj/utilities/dialogs/generic_dialog.dart';

Future<bool> showlogOutDialog(BuildContext context) {
  return showGenericDialog(
          context: context,
          title: 'Log out',
          content: 'Are you sure you want to log out?',
          optionsBuilder: () => {'Cancel': false, 'Log out': true})
      .then((value) => value ?? false);
}
