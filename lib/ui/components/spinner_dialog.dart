import 'package:flutter/material.dart';

class SpinnerDialog extends StatelessWidget {
  const SpinnerDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(),
            Text("Aguarde...", textAlign: TextAlign.center)
          ],
        )
      ],
    );
  }
}
