import 'package:flutter/material.dart';

/// LoadingDialog
///
/// Shows a progress indicator given a context
///
/// context - Buildcontext, context of calling class
class LoadingDialog {

  static showOverlayProgressIndicator(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: Container(
              child: CircularProgressIndicator(),
              height: 50.0,
              width: 50.0,
            ),
          );
        });
  }

  static Widget showProgressIndicator() {
    return Center(
      child: Container(
        child: CircularProgressIndicator(),
        height: 50.0,
        width: 50.0,
      ),
    );
  }
}
