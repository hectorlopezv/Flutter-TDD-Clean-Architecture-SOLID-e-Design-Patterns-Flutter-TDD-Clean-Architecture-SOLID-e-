import 'package:flutter/material.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/login_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginPage(),
    );
  }
}
