import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notas/data/models/note_model.dart';
import 'package:notas/pages/add/add_bloc.dart';
import 'package:notas/util/state_util.dart';
import 'package:notas/util/text_util.dart';
import 'package:notas/util/widget_util.dart';

class AddPage extends StatelessWidget {
  static const ROUTE = '/add';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Nota'),
      ),
      body: AddPageForm(),
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

  AddBloc _bloc;

  @override
  void dispose() {
    _titleCtrl.dispose();
    _desCtrl.dispose();
    _titleFocus.dispose();
    _desFocus.dispose();
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if(_bloc == null){
      _bloc = InjectorWidget.of(context).get();
    }

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
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
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Descripción'),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: StreamBuilder(
            initialData: 0,
            stream: _bloc.added,
            builder: (ctx, state){

              if(state.data == 1){
                onDidWidgetLoaded((){
                  Navigator.pop(context);
                });
              }

              return Column(
                children: <Widget>[
                  if(state.connectionState == ConnectionState.waiting)
                    ...[
                      Spacer(),
                      _loader()
                    ],
                  if(state.error)
                    ...[
                      _errorMessage('Error al Agregar, Intenta de nuevo'),
                      Spacer(),
                      _action()
                    ],
                  if(state.data == 0)
                    ...[
                      Spacer(),
                      _action()
                    ]
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _action() {
    return Material(
      child: Hero(
        tag: 'btnAdd',
        child: InkWell(
          onTap: () {
            _bloc.addNote.add(Note(
              title: _titleCtrl.text,
              description: _desCtrl.text,
              date: DateTime.now(),
            ));
          },
          child: Container(
            height: 65,
            color: Theme.of(context).accentColor,
            child: Center(
              child: Text(
                'AGREGAR',
                style: Theme.of(context)
                    .textTheme
                    .button
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
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
              style: TextStyle(color: Theme.of(context).accentColor),
            ),
          ),
        ),
        Expanded(
          child: RaisedButton(
            onPressed: () {},
            child: Text('Agregar'),
            color: Theme.of(context).accentColor,
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
      child: Text(
        msg,
        style: TextStyle(color: Theme.of(context).errorColor),
      ),
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
