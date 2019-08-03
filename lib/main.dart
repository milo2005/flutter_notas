import 'package:flutter/material.dart';
import 'package:notas/app_theme.dart';
import 'package:notas/pages/add/add_page.dart';
import 'package:notas/pages/login/login_page.dart';
import 'package:notas/pages/main/main_page.dart';
import 'package:notas/pages/register/register_page.dart';
import 'package:notas/pages/splash/splash_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:'Mis Notas',
      theme: AppTheme.build(),
      initialRoute: SplashPage.ROUTE,
      routes: {
        SplashPage.ROUTE: (ctx) => SplashPage(),
        LoginPage.ROUTE : (ctx) => LoginPage(),
        MainPage.ROUTE: (ctx) => MainPage(),
        AddPage.ROUTE: (ctx) => AddPage(),
        RegisterPage.ROUTE: (ctx) => RegisterPage(),
      },
    );
  }
}


