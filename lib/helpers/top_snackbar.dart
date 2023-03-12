import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class TopSnackbar {
  showSnackbar(BuildContext context, CustomSnackBar customSnackBar) {
    showTopSnackBar(
      Overlay.of(context),
      customSnackBar,
    );
  }
}
