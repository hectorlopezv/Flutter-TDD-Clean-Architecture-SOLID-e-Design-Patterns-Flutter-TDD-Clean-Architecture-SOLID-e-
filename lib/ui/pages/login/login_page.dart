import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

class _LoginPageState extends State<LoginPage> {
  GetxLoginPresenter controller = Get.put(makeGetxLoginPresenter());
  @override
  Widget build(BuildContext context) {
    controller.mainError.listen((error) {
      if (error != "") {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red.shade900,
            content: Text(
              error,
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    });
    controller.isLoading.listen((isLoading) {
      if (isLoading) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return SpinnerDialog();
          },
        );
      } else {
        if (Navigator.canPop(context)) {
          Navigator.of(context).pop();
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
