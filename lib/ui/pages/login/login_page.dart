import 'package:flutter/material.dart';
import 'package:tdd_clean_patterns_solid/ui/pages/login/login_presenter.dart';

import '../../components/login_header.dart';

class LoginPage extends StatefulWidget {
  final LoginPresenter presenter;

  const LoginPage({Key? key, required this.presenter}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.presenter.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      widget.presenter.mainErrorStream?.listen((error) {
        if (error != null) {
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
      widget.presenter.isLoadingErrorStream?.listen((isLoading) {
        if (isLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return SimpleDialog(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(),
                      Text("Aguarde...", textAlign: TextAlign.center)
                    ],
                  )
                ],
              );
            },
          );
        } else {
          if (Navigator.canPop(context)) {
            Navigator.of(context).pop();
          }
        }
      });
      return SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LoginHeader(),
              Text(
                "Login".toUpperCase(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline1,
              ),
              Padding(
                padding: const EdgeInsets.all(32),
                child: Form(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: StreamBuilder<String>(
                            stream: widget.presenter.emailErrorStream,
                            builder: (context, snapshot) {
                              return TextFormField(
                                onChanged: widget.presenter.validateEmail,
                                decoration: InputDecoration(
                                  errorText: snapshot.data,
                                  labelText: "Email",
                                  icon: Icon(
                                    Icons.email,
                                    color: Theme.of(context).primaryColorLight,
                                  ),
                                ),
                                keyboardType: TextInputType.emailAddress,
                              );
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 32),
                        child: StreamBuilder<String>(
                            stream: widget.presenter.passwordErrorStream,
                            builder: (context, snapshot) {
                              return TextFormField(
                                onChanged: widget.presenter.validatePassword,
                                decoration: InputDecoration(
                                  labelText: "passWord",
                                  errorText: snapshot.data,
                                  icon: Icon(
                                    Icons.lock,
                                    color: Theme.of(context).primaryColorLight,
                                  ),
                                ),
                                obscureText: true,
                              );
                            }),
                      ),
                      StreamBuilder<bool>(
                          stream: widget.presenter.isFormValidErrorStream,
                          builder: (context, snapshot) {
                            return RaisedButton(
                              onPressed: snapshot.data != null
                                  ? widget.presenter.auth
                                  : null,
                              child: Text(
                                "Entrar".toUpperCase(),
                              ),
                            );
                          }),
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
      );
    });
  }
}
