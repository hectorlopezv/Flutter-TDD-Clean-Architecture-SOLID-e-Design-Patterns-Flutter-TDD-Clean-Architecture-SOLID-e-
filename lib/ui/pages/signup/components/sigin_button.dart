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
    final controller =  Get.find<GetxSignInPresenter>();
    return  RaisedButton(
        onPressed: controller.signUp,
        child: Text(
          "Login".toUpperCase(),
      ),
      );
  }
}
