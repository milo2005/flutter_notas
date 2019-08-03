import 'package:bloc/bloc.dart';
import 'package:notas/data/repositories/auth_repository.dart';
import 'package:notas/util/state_util.dart';

class SplashBloc extends Bloc<int, BaseState>{

  AuthRepository _authRepository = AuthRepository();

  @override
  BaseState get initialState => InitialState();

  @override
  Stream<BaseState> mapEventToState(int event) async*{
    await Future.delayed(Duration(milliseconds: 1500));
    final logged = await _authRepository.isLogged();
    yield SuccessState<bool>(data: logged);

  }

}