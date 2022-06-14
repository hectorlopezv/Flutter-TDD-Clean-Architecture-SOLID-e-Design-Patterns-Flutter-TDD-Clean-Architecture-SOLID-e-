import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../presentation/presenters/getx_signin_presenter.dart';

class NameInput extends StatelessWidget {
  const NameInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<GetxSignInPresenter>(
      init: Get.find<GetxSignInPresenter>(),
        builder: (controller) => TextFormField(
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
            ),);
  }
}
