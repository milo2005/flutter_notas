import 'package:flutter/material.dart';
import 'package:notas/app_theme.dart';
import 'package:notas/pages/login/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:'Mis Notas',
      theme: AppTheme.build(),
      initialRoute: LoginPage.ROUTE,
      routes: {
        LoginPage.ROUTE : (ctx) => LoginPage()
      },
    );
  }
}


