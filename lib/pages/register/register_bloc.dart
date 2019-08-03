import 'package:bloc/bloc.dart';
import 'package:notas/data/repositories/auth_repository.dart';

class RegBloc extends Bloc<RegEvent, RegState>{

  AuthRepository _repository;

  RegBloc(this._repository);

  @override
  RegState get initialState => RegState.Initial;

  @override
  Stream<RegState> mapEventToState(RegEvent event) async*{
    yield RegState.Loading;
    try{
      await _repository.register(event.email, event.password);
      yield RegState.Success;
    } on Exception catch(e){
      yield RegState.Error;
      await Future.delayed(Duration(seconds: 1));
      yield RegState.Initial;
    }
  }

}

class RegEvent{
  String email;
  String password;
  RegEvent(this.email, this.password);
}

enum RegState{
  Initial,
  Loading,
  Error,
  Success
}