import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../presentation/presenters/getx_login_presenter.dart';
import '../../../../presentation/presenters/getx_signin_presenter.dart';

class PassWordConfirmationInput extends StatelessWidget {
  const PassWordConfirmationInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return GetX<GetxSignInPresenter>(
      builder: (controller) => Column(
        children: [
          TextFormField(
            onChanged: controller.validatePasswordConfirmation,
            decoration: InputDecoration(
              labelText: "password confirmation",
              errorText: "",
              icon: Icon(
                Icons.lock,
                color: Theme.of(context).primaryColorLight,
              ),
            ),
            obscureText: true,
          ),
          Visibility(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("invalid values"),
                ],
              ),
            ),
            visible: controller.isFormValid.value ? false : true,
          ),
        ],
    ),);
  }
}
