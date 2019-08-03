import 'package:dependencies/dependencies.dart';
import 'package:notas/data/preferences/user_session.dart';
import 'package:notas/data/repositories/auth_repository.dart';

class AppModule implements Module {
  @override
  void configure(Binder binder) {
    binder
      ..bindSingleton(UserSession())
      ..bindLazySingleton((inj, params) => AuthRepository(inj.get()));
  }
}
