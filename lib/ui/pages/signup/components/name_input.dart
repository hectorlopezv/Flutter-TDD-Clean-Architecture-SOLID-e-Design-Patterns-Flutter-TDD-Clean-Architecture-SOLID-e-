import 'package:flutter/material.dart';

class NameInput extends StatelessWidget {
  const NameInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (controller) => TextFormField(
              onChanged: null,
              decoration: InputDecoration(
                errorText: "",
                labelText: "Name",
                icon: Icon(
                  Icons.email,
                  color: Theme.of(context).primaryColorLight,
                ),
              ),
              keyboardType: TextInputType.name,
            ),);
  }
}
