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
      init: Get.find<GetxSignInPresenter>(),builder: (controller) => Column(
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
                  Text("should contain at least one upper case"),
                  Text("should contain at least one lower case"),
                  Text("should contain at least one digit"),
                  Text("should contain at least one Special character"),
                  Text("Must be at least 8 characters in length"),
                ],
              ),
            ),
            visible: false
          ),
        ],
      ),
    );
  }
}
