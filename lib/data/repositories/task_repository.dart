import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notas/data/models/user_task.dart';
import 'package:notas/data/preferences/user_session.dart';

class TaskRepository {
  UserSession _session;

  TaskRepository(this._session);

  Future add(UserTask task) async {
    final id = await _session.getId();
    await Firestore.instance
        .collection('tasks/$id/items')
        .document()
        .setData(task.toJson());
  }

  Future remove(String idDocument) async {
    final id = await _session.getId();
    await Firestore.instance.document('tasks/$id/items/$idDocument').delete();
  }

  Stream<List<UserTask>> all() async* {
    final id = await _session.getId();
    yield* Firestore.instance
        .collection('tasks/$id/items')
        .snapshots()
        .map((QuerySnapshot v) =>
        v.documents.map((d) => UserTask.fromJson(d.documentID, d.data)).toList());
  }
}
