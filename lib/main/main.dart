import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'factories/pages/login/login_page_factory.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  final primaryColor = Color.fromRGBO(136, 14, 79, 1);
  final primaryColorDark = Color.fromRGBO(96, 0, 39, 1);
  final primaryColorLight = Color.fromRGBO(188, 71, 123, 1);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "4Dev",
      theme: ThemeData(
        primaryColor: primaryColor,
        primaryColorDark: primaryColorDark,
        primaryColorLight: primaryColorLight,
        backgroundColor: Colors.white,
        accentColor: primaryColor,
        textTheme: TextTheme(
          headline1: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: primaryColorDark),
        ),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: primaryColorLight),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: primaryColorDark),
          ),
          alignLabelWithHint: true,
        ),
        buttonTheme: ButtonThemeData(
          colorScheme: ColorScheme.light(primary: primaryColorLight),
          buttonColor: primaryColorLight,
          splashColor: primaryColorLight,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      initialRoute: "/login",
      getPages: [GetPage(name: "/login", page: makeLoginPage)],
    );
  }
}
