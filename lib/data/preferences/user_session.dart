import 'package:shared_preferences/shared_preferences.dart';

class UserSession{

  SharedPreferences _preferences;

  Future<SharedPreferences> getPreferences() async{
    if(_preferences != null) return _preferences;

    _preferences = await SharedPreferences.getInstance();
    return _preferences;
  }

  Future<String> getId() async{
    final pref = await getPreferences();
    return pref.getString("id");
  }

  void setId(String value) async{
    final pref = await getPreferences();
    await pref.setString("id", value);
  }

  Future<String> getEmail() async{
    final pref = await getPreferences();
    return pref.getString("email");
  }

  void setEmail(String value) async{
    final pref = await getPreferences();
    await pref.setString("email", value);
  }

  Future<bool> getLogged() async{
    final pref = await getPreferences();
    return pref.getBool('logged') ?? false;
  }

  void setLogged(bool value) async{
    final pref = await getPreferences();
    await pref.setBool('logged', value);
  }

}