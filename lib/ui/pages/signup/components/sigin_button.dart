import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../presentation/presenters/getx_login_presenter.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder( builder: (controller) => RaisedButton(
        onPressed: null,
        child: Text(
          "Entrar".toUpperCase(),
        ),
      ),);
  }
}
