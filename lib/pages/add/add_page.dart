import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notas/data/models/user_task.dart';
import 'package:notas/pages/add/add_bloc.dart';
import 'package:notas/util/event_util.dart';
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
    _bloc.dispose();
    _titleCtrl.dispose();
    _desCtrl.dispose();
    _titleFocus.dispose();
    _desFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_bloc == null) {
      _bloc = InjectorWidget.of(context).get();
    }
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(11.0),
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
        Spacer(),
        BlocBuilder(
          bloc: _bloc,
          builder: (ctx, state) {
            if (state is SuccessState) {
              onDidWidgetLoaded(() {
                Navigator.pop(context);
              });
            }

            return Hero(
              tag: 'fab',
              child: Material(
                child: InkWell(
                  onTap: () {
                    _bloc.dispatch(SaveEvent(
                        data: UserTask(
                            title: _titleCtrl.text,
                            description: _desCtrl.text,
                            date: DateTime.now())));
                  },
                  child: Container(
                    height: 60,
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
          },
        ),
      ],
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
