import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/material.dart';
import 'package:notas/pages/login/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notas/pages/main/main_page.dart';
import 'package:notas/pages/register/register_page.dart';
import 'package:notas/util/text_util.dart';
import 'package:notas/util/widget_util.dart';

class LoginPage extends StatefulWidget {
  static const ROUTE = '/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _autovalidate = false;

  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  final _emailFocus = FocusNode();
  final _passFocus = FocusNode();

  LoginBloc _bloc;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _emailFocus.dispose();
    _passFocus.dispose();
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if(_bloc == null){
      _bloc = LoginBloc(InjectorWidget.of(context).get());
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Container(
              width: 150,
              height: 150,
              margin: EdgeInsets.only(
                top: 20,
                bottom: 20,
              ),
              child: Image(
                image: AssetImage('assets/images/logo.png'),
              ),
            ),
            Text(
              'Mis notas',
              style: Theme.of(context).textTheme.display1,
            ),
            Form(
              autovalidate: _autovalidate,
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: TextFormField(
                      controller: _emailCtrl,
                      focusNode: _emailFocus,
                      validator: validateEmail,
                      keyboardType: TextInputType.emailAddress,
                      decoration:
                          InputDecoration(filled: true, labelText: 'Correo'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (v) {
                        changeFocus(context, _emailFocus, _passFocus);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: TextFormField(
                      controller: _passCtrl,
                      focusNode: _passFocus,
                      validator: validatePass,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          filled: true, labelText: 'Contraseña'),
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder(
                bloc: _bloc,
                builder: (ctx, state) {
                  if (state == LoginState.Success) {
                    onDidWidgetLoaded(() {
                      Navigator.pushReplacementNamed(context, MainPage.ROUTE);
                    });
                  }

                  return Column(
                    children: <Widget>[
                      if (state == LoginState.Error)
                        Text(
                          "Usuario o Contraseña Erroneos",
                          style: TextStyle(color: Colors.red),
                        ),
                      Spacer(),
                      if (state != LoginState.Loading)
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: FlatButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, RegisterPage.ROUTE);
                                  },
                                  child: Text(
                                    'Registrate',
                                    style: TextStyle(
                                        color: Theme.of(context).accentColor),
                                  )),
                            ),
                            Expanded(
                              child: RaisedButton(
                                color: Theme.of(context).accentColor,
                                textColor: Colors.white,
                                onPressed: _login,
                                child: Text('Entrar'),
                              ),
                            )
                          ],
                        ),
                      if (state == LoginState.Loading)
                        Align(
                          alignment: Alignment.centerRight,
                          child: CircularProgressIndicator(),
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _login() {
    if (_formKey.currentState.validate()) {
      _bloc.dispatch(LoginEvent(_emailCtrl.text, _passCtrl.text));
    } else {
      setState(() {
        _autovalidate = true;
      });
    }
  }
}
