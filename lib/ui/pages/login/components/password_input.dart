import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../presentation/presenters/getx_login_presenter.dart';

class PassWordInput extends StatelessWidget {
  const PassWordInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<GetxLoginPresenter>(
      builder: (controller) => TextFormField(
        onChanged: controller.validatePassword,
        decoration: InputDecoration(
          labelText: "passWord",
          errorText: controller.passwordError.value,
          icon: Icon(
            Icons.lock,
            color: Theme.of(context).primaryColorLight,
          ),
        ),
        obscureText: true,
      ),
    );
  }
}
