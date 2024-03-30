import 'package:flutter/widgets.dart';
import 'package:test_proj/utilities/dialogs/generic_dialog.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog(
    context: context,
    title: 'An error occurred',
    content: text,
    optionsBuilder: () => {
      'Ok': null,
    },
  );
}
