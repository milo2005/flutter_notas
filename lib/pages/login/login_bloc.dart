import 'package:bloc/bloc.dart';
import 'package:notas/data/repositories/auth_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState>{

  AuthRepository _repository;
  LoginBloc(this._repository);

  @override
  LoginState get initialState => LoginState.Initial;

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async*{
    try {

      yield LoginState.Loading;
      await _repository.login(event.email, event.password);
      yield LoginState.Success;

    } on Exception catch(e){

      yield LoginState.Error;
      await Future.delayed(Duration(milliseconds: 1500));
      yield LoginState.Initial;

    }
  }

}

class LoginEvent{
  String email;
  String password;
  LoginEvent(this.email, this.password);
}

enum LoginState{
  Initial,
  Loading,
  Error,
  Success
}