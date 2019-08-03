import 'package:dependencies/dependencies.dart';
import 'package:notas/data/preferences/user_session.dart';
import 'package:notas/data/repositories/auth_repository.dart';
import 'package:notas/pages/login/login_bloc.dart';
import 'package:notas/pages/splash/splash_bloc.dart';

class AppModule implements Module {
  @override
  void configure(Binder binder) {
    binder
      ..bindSingleton(UserSession())
      ..bindLazySingleton((inj, params)=> AuthRepository(inj.get()))
      ..bindFactory((inj, params)=> SplashBloc(inj.get()))
      ..bindFactory((inj, params)=> LoginBloc(inj.get()));
  }
}
