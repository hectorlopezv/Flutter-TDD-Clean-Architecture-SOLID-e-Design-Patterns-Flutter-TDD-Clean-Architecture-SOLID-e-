import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../presentation/presenters/getx_login_presenter.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<GetxLoginPresenter>(
      init: Get.find<GetxLoginPresenter>(),
      builder: (controller) => RaisedButton(
        onPressed: controller.isFormValid.value ? controller.auth : null,
        child: Text(
          "Entrar".toUpperCase(),
        ),
      ),
    );
  }
}
