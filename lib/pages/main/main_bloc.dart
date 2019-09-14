import 'package:bloc/bloc.dart';
import 'package:notas/data/models/note_model.dart';
import 'package:notas/data/repositories/note_repository.dart';
import 'package:notas/util/state_util.dart';

class MainBloc {

  NoteRepository _repository;
  Stream<List<Note>> data;

  MainBloc(this._repository){
    data = _repository.all();
  }

}