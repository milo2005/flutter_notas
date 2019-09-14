import 'package:dependencies/dependencies.dart';
import 'package:notas/data/preferences/user_session.dart';
import 'package:notas/data/repositories/auth_repository.dart';
import 'package:notas/data/repositories/note_repository.dart';
import 'package:notas/pages/add/add_bloc.dart';
import 'package:notas/pages/login/login_bloc.dart';
import 'package:notas/pages/main/main_bloc.dart';
import 'package:notas/pages/register/register_bloc.dart';
import 'package:notas/pages/splash/splash_bloc.dart';

class AppModule implements Module {
  @override
  void configure(Binder binder) {
    binder
      ..bindSingleton(UserSession())
      // Repositories
      ..bindLazySingleton((inj, params)=> AuthRepository(inj.get()))
      ..bindLazySingleton((inj, params)=> NoteRepository(inj.get()))
      // Bloc
      ..bindFactory((inj, params)=> SplashBloc(inj.get()))
      ..bindFactory((inj, params)=> LoginBloc(inj.get()))
      ..bindFactory((inj, params)=> RegisterBloc(inj.get()))
      ..bindFactory((inj, params)=> AddBloc(inj.get()))
      ..bindFactory((inj, params)=> MainBloc(inj.get()));

  }
}
