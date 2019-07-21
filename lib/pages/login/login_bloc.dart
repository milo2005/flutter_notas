import 'package:bloc/bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState>{
  @override
  LoginState get initialState => LoginState.Initial;

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async*{

    yield LoginState.Loading;

    await Future.delayed(Duration(seconds: 2));

    if(event.email =='prueba@email.com' && event.password == '123456'){
      yield LoginState.Success;
    }else{
      yield LoginState.Error;
      await Future.delayed(Duration(seconds: 1));
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