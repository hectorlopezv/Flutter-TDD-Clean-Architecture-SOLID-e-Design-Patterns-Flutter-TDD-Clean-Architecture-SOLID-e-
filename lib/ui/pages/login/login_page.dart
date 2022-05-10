import 'package:flutter/material.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/login/components/login_button.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/login/components/password_input.dart';

import '../../../presentation/presenters/getx_login_presenter.dart';
import '../../components/login_header.dart';
import 'components/email_input.dart';

class LoginPage extends StatefulWidget {
  final GetxLoginPresenter presenter;

  const LoginPage({Key? key, required this.presenter}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    //TODO: show modal with error
    // TODO: show spinner while loading
    // TODO: hide spinner
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LoginHeader(),
            Text(
              "Login".toUpperCase(),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(32),
              child: Form(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: EmailInput(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PassWordInput(),
                    ),
                    LoginButton(),
                    FlatButton.icon(
                      icon: Icon(Icons.person),
                      onPressed: null,
                      label: Text("Crian Conta"),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
