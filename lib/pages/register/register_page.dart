import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notas/pages/main/main_page.dart';
import 'package:notas/pages/register/register_bloc.dart';
import 'package:notas/util/text_util.dart';
import 'package:notas/util/widget_util.dart';

class RegisterPage extends StatelessWidget {
  static const ROUTE = '/register';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Text(
              'Crear Cuenta',
              style: Theme.of(context).textTheme.display2,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: RegisterForm(),
            ),
          )
        ],
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  bool _autovalidate = false;

  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  final _emailFocus = FocusNode();
  final _passFocus = FocusNode();

  RegBloc _bloc;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _emailFocus.dispose();
    _passFocus.dispose();
    _bloc.dispose();
    _bloc = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_bloc == null) {
      _bloc = RegBloc(InjectorWidget.of(context).get());
    }

    return Column(
      children: <Widget>[
        Form(
          key: _formKey,
          autovalidate: _autovalidate,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
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
                padding: const EdgeInsets.only(top: 16.0),
                child: TextFormField(
                  controller: _passCtrl,
                  focusNode: _passFocus,
                  validator: validatePass,
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
        Expanded(
          child: BlocBuilder(
            bloc: _bloc,
            builder: (ctx, state) {
              if (state == RegState.Success) {
                onDidWidgetLoaded(() {
                  Navigator.pushReplacementNamed(context, MainPage.ROUTE);
                });
              }

              return Column(
                children: <Widget>[
                  if (state == RegState.Error)
                    Text(
                      "Error al crear una cuenta, intenta de nuevo",
                      style: TextStyle(color: Colors.red),
                    ),
                  Spacer(),
                  if (state == RegState.Loading)
                    Align(
                      alignment: Alignment.centerRight,
                      child: CircularProgressIndicator(),
                    ),
                  if (state != RegState.Loading)
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: FlatButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              'Cancelar',
                              style:
                                  TextStyle(color: Theme.of(context).accentColor),
                            )),
                      ),
                      Expanded(
                        child: RaisedButton(
                          onPressed: _register,
                          child: Text('Crear'),
                          color: Theme.of(context).accentColor,
                          textColor: Colors.white,
                        ),
                      )
                    ],
                  )
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  void _register() {
    if (_formKey.currentState.validate()) {
      _bloc.dispatch(RegEvent(_emailCtrl.text, _passCtrl.text));
    } else {
      setState(() {
        _autovalidate = true;
      });
    }
  }
}
