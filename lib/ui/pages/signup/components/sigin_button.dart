import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../presentation/presenters/getx_login_presenter.dart';
import '../../../../presentation/presenters/getx_signin_presenter.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<GetxSignInPresenter>(
      init: Get.find<GetxSignInPresenter>(), builder: (controller) => RaisedButton(
        onPressed: null,
        child: Text(
          "Entrar".toUpperCase(),
        ),
      ),);
  }
}
