import 'package:flutter/material.dart';
import 'package:notas/util/text_util.dart';

class AddPage extends StatelessWidget {
  static const ROUTE = '/add';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Nota'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: AddPageForm(),
      ),
    );
  }
}

class AddPageForm extends StatefulWidget {
  @override
  _AddPageFormState createState() => _AddPageFormState();
}

class _AddPageFormState extends State<AddPageForm> {
  final _key = GlobalKey<FormState>();
  bool _autovalidate = false;

  final _titleCtrl = TextEditingController();
  final _desCtrl = TextEditingController();

  final _titleFocus = FocusNode();
  final _desFocus = FocusNode();

  @override
  void dispose() {
    _titleCtrl.dispose();
    _desCtrl.dispose();
    _titleFocus.dispose();
    _desFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Form(
          key: _key,
          autovalidate: _autovalidate,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                controller: _titleCtrl,
                focusNode: _titleFocus,
                validator: _validateTitle,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Titulo'),
                onFieldSubmitted: (v) {
                  changeFocus(context, _titleFocus, _desFocus);
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 12),
                child: TextFormField(
                  controller: _desCtrl,
                  focusNode: _desFocus,
                  validator: _validateDes,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  decoration:
                  InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Descripción'),
                ),
              ),
            ],
          ),
        ),
        Spacer(),
        _actions(),
      ],
    );
  }

  Widget _actions() {
    return Row(
      children: <Widget>[
        Expanded(
          child: FlatButton(
            onPressed: () {},
            child: Text(
              'Cancelar',
              style: TextStyle(color: Theme
                  .of(context)
                  .accentColor),
            ),
          ),
        ),
        Expanded(
          child: RaisedButton(
            onPressed: () {},
            child: Text('Agregar'),
            color: Theme
                .of(context)
                .accentColor,
            textColor: Colors.white,
          ),
        )
      ],
    );
  }

  Widget _loader() {
    return Align(
      alignment: Alignment.bottomRight,
      child: CircularProgressIndicator(),
    );
  }

  Widget _errorMessage(String msg) {
    return Padding(
      padding: EdgeInsets.all(11),
      child: Text(msg, style: TextStyle(color: Theme
          .of(context)
          .errorColor),),
    );
  }

  String _validateTitle(String value) {
    if (value == '') {
      return 'El titulo es obligatorio';
    }
    return null;
  }

  String _validateDes(String value) {
    if (value == '') {
      return 'La descripción es obligatoria';
    }
    return null;
  }
}
