import 'package:flutter/material.dart';

void changeFocus(BuildContext context, FocusNode current, FocusNode request){
  current.unfocus();
  FocusScope.of(context).requestFocus(request);
}

String validateEmail(String value) {
  Pattern pattern = r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)";
  RegExp regex = RegExp(pattern);

  if (value == '') {
    return 'El email es obligatorio';
  } else if (!regex.hasMatch(value)) {
    return 'El email tiene mal formato';
  }
  return null;
}

String validatePass(String value) {
  if (value == '') {
    return 'La contraseña es obligatoria';
  } else if (value.length < 6) {
    return 'La contraseña debe tener 6 caracteres';
  }
  return null;
}