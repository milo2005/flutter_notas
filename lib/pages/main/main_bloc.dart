import 'package:bloc/bloc.dart';
import 'package:notas/data/repositories/note_repository.dart';
import 'package:notas/util/state_util.dart';

enum MainEvents{
  READY
}

class MainBloc extends Bloc<MainEvents, BaseState>{

  NoteRepository _repository;
  MainBloc(this._repository);

  @override
  BaseState get initialState => InitialState();

  @override
  Stream<BaseState> mapEventToState(MainEvents event) async*{
    try{
      yield LoadingState();
      yield* _repository.all()
      .map((x)=>SuccessState(data: x));
    }catch(e){
      yield ErrorState();
    }
  }

}