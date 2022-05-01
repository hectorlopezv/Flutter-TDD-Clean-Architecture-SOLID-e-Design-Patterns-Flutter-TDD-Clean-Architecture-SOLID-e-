import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../login_presenter.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);
    return StreamBuilder<bool>(
        stream: presenter.isFormValidErrorStream,
        builder: (context, snapshot) {
          return RaisedButton(
            onPressed: snapshot.data != null ? presenter.auth : null,
            child: Text(
              "Entrar".toUpperCase(),
            ),
          );
        });
  }
}
