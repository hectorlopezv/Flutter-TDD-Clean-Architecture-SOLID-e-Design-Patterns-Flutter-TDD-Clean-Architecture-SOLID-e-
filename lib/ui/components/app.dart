import 'package:flutter/material.dart';
import 'package:tdd_clean_patterns_solid/presentation/presenters/getx_login_presenter.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/login/login_page.dart';

class App extends StatelessWidget {
  final GetxLoginPresenter presenter;
  const App({Key? key, required this.presenter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginPage(
        presenter: presenter,
      ),
    );
  }
}
