import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tdd_clean_patterns_solid/main/factories/pages/login/login_presenter_factory.dart';
import 'package:tdd_clean_patterns_solid/main/factories/pages/signIn/signin_presenter_factory.dart';

import '../../../../presentation/presenters/getx_login_presenter.dart';
import '../../../../presentation/presenters/getx_signin_presenter.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final controller =  Get.find<GetxSignInPresenter>();
    return TextFormField(
              onChanged: controller.validateEmail,
              decoration: InputDecoration(
                errorText: "",
                labelText: "Email",
                icon: Icon(
                  Icons.email,
                  color: Theme.of(context).primaryColorLight,
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            );
  }
}
