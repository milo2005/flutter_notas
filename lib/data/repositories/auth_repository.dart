import 'package:notas/data/preferences/user_session.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  UserSession _session;

  AuthRepository(this._session);

  Future<bool> isLogged() async {
    return _session.getLogged();
  }

  Future<bool> login(String email, String pass) async {
     final result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: pass);
     _session.setEmail(email);
     _session.setLogged(true);
     _session.setId(result.user.uid);
     return true;
  }

  Future<bool> register(String email, String pass) async{
    final result =  await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: pass);
    _session.setEmail(email);
    _session.setLogged(true);
    _session.setId(result.user.uid);
    return true;
  }
}
