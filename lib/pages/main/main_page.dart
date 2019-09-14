import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notas/data/models/user_task.dart';
import 'package:notas/pages/add/add_page.dart';
import 'package:notas/pages/main/main_bloc.dart';
import 'package:notas/util/event_util.dart';
import 'package:notas/util/state_util.dart';

class MainPage extends StatefulWidget {
  static const ROUTE = '/main';

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  MainBloc _bloc;
  List<UserTask> data = [];

  @override
  Widget build(BuildContext context) {
    if (_bloc == null) {
      _bloc = InjectorWidget.of(context).get();
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          heroTag: 'fab',
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
        builder: (ctx, state) {

          if(state is InitialState){
            _bloc.dispatch(ReadyEvent());
          }

          if (state is ErrorState) {
            return Center(
              child: Text('Error'),
            );
          }else if(state is LoadingState){
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is SuccessState) {
            data = state.data;
          }

          return ListView.builder(
              itemCount: data.length,
              itemBuilder: (ctx, idx) => _itemNote(ctx, data[idx]));
        },
      ),
    );
  }

  Widget _itemNote(BuildContext context, UserTask task) {
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
                  task.title,
                  style: Theme.of(context).textTheme.title,
                ),
                Text(
                  task.date.toString(),
                  style: Theme.of(context).textTheme.caption,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    task.toString(),
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
}
