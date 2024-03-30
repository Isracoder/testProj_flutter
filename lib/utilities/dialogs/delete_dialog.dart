import 'package:flutter/widgets.dart';
import 'package:test_proj/utilities/dialogs/generic_dialog.dart';

Future<bool> showDeleteDialog(BuildContext context) {
  return showGenericDialog(
          context: context,
          title: 'Delete',
          content: 'Are you sure you want to delete this item?',
          optionsBuilder: () => {'Cancel': false, 'Yes': true})
      .then((value) => value ?? false);
}
