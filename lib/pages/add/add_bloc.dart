import 'package:bloc/bloc.dart';
import 'package:notas/data/models/note_model.dart';
import 'package:notas/data/repositories/note_repository.dart';
import 'package:notas/util/state_util.dart';
import 'package:rxdart/rxdart.dart';

class AddBloc {
  NoteRepository _repository;
  Stream<int> added;
  PublishSubject<Note> addNote = PublishSubject();

  AddBloc(this._repository){
    added = addNote
        .switchMap((n)=> Observable.fromFuture(_repository.add(n)))
        .map((x) =>1);
  }

  dispose(){
    addNote.close();
  }

}