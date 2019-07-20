import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static const ROUTE = '/';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Container(
              width: 150,
              height: 150,
              margin: EdgeInsets.only(top: 20, bottom: 20,),
              child: Image(
                image: AssetImage('assets/images/logo.png'),
              ),
            ),
            Text(
              'Mis notas',
              style: Theme.of(context).textTheme.display1,
            ),
            Form(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top:12.0),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(filled: true, labelText: 'Correo'),
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:12.0),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      decoration:
                          InputDecoration(filled: true, labelText: 'Contraseña'),
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: RaisedButton(
                color: Theme.of(context).accentColor,
                textColor: Colors.white,
                onPressed: () {},
                child: Text('Entrar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
