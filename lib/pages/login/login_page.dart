import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static const ROUTE = '/';

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

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _emailFocus.dispose();
    _passFocus.dispose();
    super.dispose();
  }

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
              autovalidate: _autovalidate,
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top:12.0),
                    child: TextFormField(
                      controller: _emailCtrl,
                      focusNode: _emailFocus,
                      validator: _validateEmail,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(filled: true, labelText: 'Correo'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (v){_changeFocus(_emailFocus, _passFocus);},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:12.0),
                    child: TextFormField(
                      controller: _passCtrl,
                      focusNode: _passFocus,
                      validator: _validatePass,
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
                onPressed: _login,
                child: Text('Entrar'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _changeFocus(FocusNode current, FocusNode request){
    current.unfocus();
    FocusScope.of(context).requestFocus(request);
  }

  String _validateEmail(String value){

    Pattern pattern = r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)";
    RegExp regex = RegExp(pattern);

    if(value == ''){
      return 'El email es obligatorio';
    } else if(!regex.hasMatch(value)){
      return 'El email tiene mal formato';
    }
    return null;
  }

  String _validatePass(String value){
    if(value == ''){
      return 'La contraseña es obligatoria';
    }else if(value.length < 6){
      return 'La contraseña debe tener 6 caracteres';
    }
    return null;
  }

  void _login(){
    if(_formKey.currentState.validate()){
      // Se hace el Login
    }else{
      setState((){
        _autovalidate = true;
      });
    }
  }

}
