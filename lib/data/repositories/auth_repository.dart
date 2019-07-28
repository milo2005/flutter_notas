import 'package:notas/data/preferences/user_session.dart';

class AuthRepository {
  UserSession _session = UserSession();

  Future<bool> isLogged() async {
    return _session.getLogged();
  }

  Future<bool> login(String email, String pass) async {
    await Future.delayed(Duration(seconds: 2));

    if(email =='prueba@email.com' && pass == '123456'){
      _session.setLogged(true);
      return true;
    }else{
      _session.setLogged(false);
      return false;
    }

  }
}
