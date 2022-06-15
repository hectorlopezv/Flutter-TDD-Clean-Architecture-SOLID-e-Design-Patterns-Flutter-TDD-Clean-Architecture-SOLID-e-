import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../main/factories/pages/signIn/signin_presenter_factory.dart';
import '../../../../presentation/presenters/getx_signin_presenter.dart';

class NameInput extends StatelessWidget {
  const NameInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
 final controller =  Get.find<GetxSignInPresenter>();
   return TextFormField(
        onChanged: controller.validateName,
        decoration: InputDecoration(
          errorText: "",
          labelText: "Name",
          icon: Icon(
            Icons.email,
            color: Theme.of(context).primaryColorLight,
          ),
        ),
        keyboardType: TextInputType.name,
      
    );
  }
}
