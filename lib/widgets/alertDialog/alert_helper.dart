
import 'package:flutter/material.dart';

import 'alert_dialog.dart';

class DialogHelper {
  static exit(context) => showDialog(
      context: context, builder: (context) => ExitConfirmationDialog());
}
