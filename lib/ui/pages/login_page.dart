import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: Image(
                image: AssetImage("lib/assets/logo.png"),
              ),
            ),
            Text("Login".toUpperCase()),
            Form(
                child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Email",
                    icon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Senha",
                    icon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                ),
                ElevatedButton(
                  onPressed: null,
                  child: Text(
                    "Entrar".toUpperCase(),
                  ),
                ),
                TextButton(
                  onPressed: null,
                  child: Text("Crian Conta"),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
