import 'package:flutter/material.dart';

showLoadingIndicator(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Container(
            height: 45.0,
            width: 45.0,
            child: CircularProgressIndicator(),
          ),
        );
      });
}