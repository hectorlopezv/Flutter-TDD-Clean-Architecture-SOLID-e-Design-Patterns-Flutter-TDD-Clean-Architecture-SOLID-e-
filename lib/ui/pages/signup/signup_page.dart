
import 'package:flutter/material.dart';
import 'package:tdd_clean_patterns_solid/ui/components/components.dart';
import 'package:tdd_clean_patterns_solid/ui/helpers/i18n/resources.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/signup/components/email_input.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/signup/components/name_input.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/signup/components/password_confirmation_input.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/signup/components/sigin_button.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/signup/components/password_input.dart';



class SignUpPage  extends StatelessWidget {
  const SignUpPage ({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    NameInput(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical:8.0),
                      child: EmailInput(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PassWordInput(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PassWordConfirmationInput(),
                    ),
                    SignInButton(),
                    FlatButton.icon(
                      icon: Icon(Icons.exit_to_app),
                      onPressed: null,
                      label: Text("Login")
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