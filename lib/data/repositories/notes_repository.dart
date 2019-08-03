import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notas/data/models/note.dart';
import 'package:notas/data/preferences/user_session.dart';

class NotesRepository{

  UserSession _session;

  NotesRepository(this._session);

  void add(Note note) async{
    final id = await _session.getId();
    final docId = DateTime.now().millisecondsSinceEpoch;
    await Firestore.instance.document('notes/$id/items/$docId')
    .setData(note.toJson());
  }

  void remove(int docId) async{
    final id = await _session.getId();
    await Firestore.instance.document('notes/$id/items/$docId').delete();
  }

  Stream<QuerySnapshot> list() async*{
    final id = await _session.getId();
    yield* Firestore.instance.collection("notes/$id/items").snapshots();

  }

}