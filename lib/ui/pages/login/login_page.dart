import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tdd_clean_patterns_solid/ui/helpers/errors/ui_error.dart';
import 'package:tdd_clean_patterns_solid/ui/helpers/i18n/resources.dart';
import 'package:tdd_clean_patterns_solid/ui/mixins/keyboard_manager.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/login/components/login_button.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/login/components/password_input.dart';


import '../../../main/factories/pages/login/login_presenter_factory.dart';
import '../../../presentation/presenters/getx_login_presenter.dart';
import '../../components/login_header.dart';
import '../../components/spinner_dialog.dart';
import 'components/email_input.dart';
import 'login_presenter.dart';

class LoginPage extends StatefulWidget {
  final LoginPresenter presenter;

  const LoginPage({Key? key, required this.presenter}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with KeyboardManager {
  GetxLoginPresenter controller = Get.put(makeGetxLoginPresenter());
  @override
  Widget build(BuildContext context) {
    controller.mainError.listen((  error) {
      if (error != "") {

        final snackBar = SnackBar(
          content: Text(
              error.toString(),
              textAlign: TextAlign.center,
            ),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );

          // Find the ScaffoldMessenger in the widget tree
          // and use it to show a SnackBar.
          if(context != null) {
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }

          
      }
    });

    controller.navigateTo.listen((page) {
      print("page ${page}");

      if (page.isNotEmpty == true) {
        Get.offAllNamed(page);
      }
    });
    return Scaffold(
      resizeToAvoidBottomInset: true,
        body: SafeArea(
      child: GestureDetector(
        onTap: () {
          hideKeyboard(context);
        },
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
                        onPressed: controller.goToSignUp,
                        label: Text(R.strings.addAccount)
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
