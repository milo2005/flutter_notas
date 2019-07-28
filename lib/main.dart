import 'package:flutter/material.dart';
import 'package:notas/app_theme.dart';
import 'package:notas/pages/login/login_page.dart';
import 'package:notas/pages/main/MainPage.dart';
import 'package:notas/pages/splash/SplashPage.dart';

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
      },
    );
  }
}


