import 'package:bloc/bloc.dart';
import 'package:notas/data/repositories/auth_repository.dart';
import 'package:notas/pages/login/login_bloc.dart';
import 'package:notas/util/state_util.dart';

class RegisterBloc extends Bloc<LoginEvent, BaseState>{

  AuthRepository _respository;

  RegisterBloc(this._respository);

  @override
  BaseState get initialState => InitialState();

  @override
  Stream<BaseState> mapEventToState(LoginEvent event) async*{
    yield* _register(event);
  }

  Stream<BaseState> _register(LoginEvent event) async*{
    try {
      yield LoadingState();
      await _respository.register(event.email, event.password);
      yield SuccessState();
    } on Exception catch (e) {
      yield ErrorState();
      await Future.delayed(Duration(microseconds: 1500));
      yield InitialState();
    }
  }
}