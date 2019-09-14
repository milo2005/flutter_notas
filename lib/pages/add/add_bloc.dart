import 'package:bloc/bloc.dart';
import 'package:notas/data/models/note_model.dart';
import 'package:notas/data/repositories/note_repository.dart';
import 'package:notas/util/state_util.dart';

class AddEvent{
  Note note;
  AddEvent(this.note);
}

class AddBloc extends Bloc<AddEvent, BaseState>{

  NoteRepository _repository;

  AddBloc(this._repository);

  @override
  BaseState get initialState => InitialState();

  @override
  Stream<BaseState> mapEventToState(AddEvent event) async*{
    try{
        yield LoadingState();
        await _repository.add(event.note);
        yield SuccessState();
    }catch(e){
        yield ErrorState();
        await Future.delayed(Duration(seconds: 2));
        yield InitialState();
    }
  }

}