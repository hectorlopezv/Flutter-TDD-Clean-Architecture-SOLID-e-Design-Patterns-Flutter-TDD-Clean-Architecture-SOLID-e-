import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tdd_clean_patterns_solid/main/factories/pages/signIn/signin_presenter_factory.dart';
import 'package:tdd_clean_patterns_solid/presentation/presenters/getx_signin_presenter.dart';
import 'package:tdd_clean_patterns_solid/ui/components/components.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/signup/components/email_input.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/signup/components/name_input.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/signup/components/password_confirmation_input.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/signup/components/sigin_button.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/signup/components/password_input.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/signup/signup_presenter.dart';
import '../../components/spinner_dialog.dart';
import '../../mixins/keyboard_manager.dart';

class SignUpPage extends StatelessWidget with KeyboardManager {
  final SignUpPresenter presenter;
  const SignUpPage({Key? key, required this.presenter}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //Loading Stream
     final controller = Get.put<GetxSignInPresenter>(makeGetxSignInPresenter());
    
    controller.isLoadingStream.listen((isLoading) {
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
    //Error stream
    controller.mainErrorStream.listen((error) {
      if (error != null) {
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
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });

    //Redirection
    controller.navigateToStream.listen((page) {
       if (page.isNotEmpty == true) {
        Get.offAllNamed(page);
      }
    });
    return Scaffold(
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
                     NameInput(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                          onPressed: controller.goToLogin,
                          label: Text("Login"),
                    ),
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
