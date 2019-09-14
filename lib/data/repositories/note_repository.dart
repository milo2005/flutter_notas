import 'package:notas/data/models/note_model.dart';
import 'package:notas/data/preferences/user_session.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NoteRepository {
  UserSession _session;

  NoteRepository(this._session);

  Future add(Note note) async {
    final id = await _session.getId();

    await Firestore.instance.collection("notes/$id/items")
        .document()
        .setData(note.toJson());
  }

  Future remove(String idNote) async {
    final id = await _session.getId();
    await Firestore.instance.document("notes/$id/items/$idNote").delete();
  }

  Future<Note> byId(String idNote) async {
    final id = await _session.getId();

    final doc =
        await Firestore.instance.document("notes/$id/items/$idNote").get();

    return Note.fromJson(doc.documentID, doc.data);
  }

  Stream<List<Note>> all() async* {
    final id = await _session.getId();

    yield* Firestore.instance.collection('notes/$id/items')
        .snapshots()
        .map((v) => _processList(v.documents));
  }

  Stream<List<Note>> allByTag(String tag) async*{
    final id = await _session.getId();

    yield* Firestore.instance.collection('notes/$id/items')
        .where("tag", isEqualTo: tag  )
        .snapshots()
        .map((v) => _processList(v.documents));
  }

  List<Note> _processList(List<DocumentSnapshot> docs) => docs
      .map((d) => Note.fromJson(d.documentID, d.data))
      .toList();

}
