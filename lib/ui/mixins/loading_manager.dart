

import 'package:flutter/material.dart';
import 'package:tdd_clean_patterns_solid/ui/components/spinner_dialog.dart';

mixin LoadingManager{
  void handleLoading(Stream<bool> stream, BuildContext context){
        stream.listen((isLoading) {
      if (isLoading) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return SpinnerDialog();
          },
        );
      } else {
        if (Navigator.canPop(context)) {
          Navigator.of(context).pop();
        }
      }
    });
  }
}