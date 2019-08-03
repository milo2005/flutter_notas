import 'package:flutter/material.dart';
import 'package:notas/pages/add/add_page.dart';

class MainPage extends StatelessWidget {
  static const ROUTE = '/main';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddPage.ROUTE);
        },
        child: Icon(Icons.add, color: Colors.white,),
      ),
      appBar: AppBar(
        title: Text("Mis Notas"),
      ),
      body: ListView.builder(itemCount: 10, itemBuilder: (ctx, idx) => _itemNote(ctx)),
    );
  }

  Widget _itemNote(BuildContext context) {
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
                Text('Titulo',style: Theme.of(context).textTheme.title,),
                Text('Fecha',style: Theme.of(context).textTheme.caption,),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text('Descripcion ...', style: Theme.of(context).textTheme.body1,),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
