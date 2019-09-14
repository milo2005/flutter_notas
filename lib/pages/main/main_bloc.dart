import 'package:bloc/bloc.dart';
import 'package:notas/data/repositories/task_repository.dart';
import 'package:notas/util/event_util.dart';
import 'package:notas/util/state_util.dart';

class MainBloc extends Bloc<ReadyEvent, BaseState>{

  TaskRepository _repository;

  MainBloc(this._repository);

  @override
  BaseState get initialState => InitialState();

  @override
  Stream<BaseState> mapEventToState(ReadyEvent event) async*{
    yield LoadingState();
    yield* _repository.all()
        .map((x)=> SuccessState(data:x));
  }

}