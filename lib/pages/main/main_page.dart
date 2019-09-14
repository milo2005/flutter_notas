import 'package:flutter/material.dart';
import 'package:notas/data/models/note_model.dart';
import 'package:notas/pages/add/add_page.dart';

class MainPage extends StatefulWidget {
  static const ROUTE = '/main';

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  List<Note> _data = [];

  @override
  Widget build(BuildContext context) {
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
      body: ListView.builder(
          itemCount: _data.length,
          itemBuilder: (ctx, idx) => _itemNote(ctx, _data[idx])),
    );
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
