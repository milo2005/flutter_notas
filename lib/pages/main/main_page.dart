import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notas/data/models/note_model.dart';
import 'package:notas/pages/add/add_page.dart';
import 'package:notas/pages/main/main_bloc.dart';
import 'package:notas/util/state_util.dart';
import 'package:notas/util/widget_util.dart';

class MainPage extends StatefulWidget {
  static const ROUTE = '/main';

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  List<Note> _data = [];

  MainBloc _bloc;

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if(_bloc == null){
      _bloc = InjectorWidget.of(context).get();
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'btnAdd',
        onPressed: () {
          Navigator.pushNamed(context, AddPage.ROUTE);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        title: Text("Mis Notas"),
      ),
      body: BlocBuilder(
        bloc: _bloc,
        builder: (ctx, state){
          if(state is LoadingState){
            return _loader();
          }else if(state is ErrorState){
            return _errorMsg('Error al recuperar las notas');
          }else if(state is SuccessState){
            _data = state.data;
          }else if(state is InitialState){
            onDidWidgetLoaded((){
              _bloc.dispatch(MainEvents.READY);
            });
          }
          return _list();
        },
      ),
    );
  }

  ListView _list() {
    return ListView.builder(
        itemCount: _data.length,
        itemBuilder: (ctx, idx) => _itemNote(ctx, _data[idx]));
  }

  Widget _itemNote(BuildContext context, Note note) {
    return Card(
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  note.title,
                  style: Theme.of(context).textTheme.title,
                ),
                Text(
                  note.date.toString(),
                  style: Theme.of(context).textTheme.caption,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    note.description,
                    style: Theme.of(context).textTheme.body1,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _loader() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _errorMsg(String msg) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        msg,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Theme.of(context).errorColor,
        ),
      ),
    );
  }
}
