import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tdd_clean_patterns_solid/main/factories/pages/login/login_presenter_factory.dart';

import '../../../../presentation/presenters/getx_login_presenter.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (controller) => TextFormField(
              onChanged: null,
              decoration: InputDecoration(
                errorText: "",
                labelText: "Email",
                icon: Icon(
                  Icons.email,
                  color: Theme.of(context).primaryColorLight,
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),);
  }
}
