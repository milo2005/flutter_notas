import 'package:bloc/bloc.dart';
import 'package:notas/data/repositories/task_repository.dart';
import 'package:notas/util/event_util.dart';
import 'package:notas/util/state_util.dart';

class AddBloc extends Bloc<SaveEvent, BaseState>{

  TaskRepository _repository;

  AddBloc(this._repository);


  @override
  BaseState get initialState => InitialState();

  @override
  Stream<BaseState> mapEventToState(SaveEvent event) async*{
    try{

      yield LoadingState();
      await _repository.add(event.data);
      yield SuccessState();

    }catch(e){
        yield  ErrorState(msg: 'Error al agregar Nota');
        await Future.delayed(Duration(seconds: 2));
        yield InitialState();
    }

  }

}