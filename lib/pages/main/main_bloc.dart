import 'package:bloc/bloc.dart';
import 'package:notas/data/models/note.dart';
import 'package:notas/data/repositories/notes_repository.dart';


class MainState {}

class InitialMain extends MainState {}

class ErrorMain extends MainState {}

class SuccessMain extends MainState {
  List<Note> data;

  SuccessMain(this.data);

}

class DataEvent{
  List<Note> data;

  DataEvent(this.data);
}

class MainBloc extends Bloc<DataEvent, MainState> {

  NotesRepository _repository;

  MainBloc(this._repository) {
    _repository.list().listen((x) {

      final notes = x.documents.map((json)=> Note.fromJson(json.data));
      dispatch(DataEvent(notes));

    });
  }


  @override
  MainState get initialState => InitialMain();

  @override
  Stream<MainState> mapEventToState(DataEvent event) async*{
    yield SuccessMain(event.data);
  }

}