import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {

  static final UserPreferences _instance = UserPreferences._ctor();
  factory UserPreferences() {
    return _instance;
  }

  UserPreferences._ctor();

  SharedPreferences _prefs;

  init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  get data {
    return _prefs.getString('Anand') ?? '';
  }

  set data(String value) {
    _prefs.setString('Anand', value);
  }

  Future setJwtToken(String value) {
    return _prefs.setString('jwtToken', value);
  }

  void savedata(String keyname, dynamic valuetype) {

    if (valuetype is int) {
      _prefs.setInt("$keyname", valuetype);
    } else if (valuetype is String) {
      _prefs.setString("$keyname", valuetype);
    } else if (valuetype is bool) {
      _prefs.setBool("$keyname", valuetype);
    } else if (valuetype is double) {
      _prefs.setDouble("$keyname", valuetype);
    }
  }

  dynamic loaddata(String keyname, Object valuetype) {


    Object defaultretentype = "";
    Object retunvalue = "";
    try {
      if (valuetype == 1) {
        return _prefs.getString("$keyname") ?? "";
      } else if (valuetype == 2) {
        return _prefs.getInt("$keyname") ?? 0;
      } else if (valuetype == 3) {
        return _prefs.getBool("$keyname") ?? false;
      } else if (valuetype == 4) {
        return _prefs.getDouble("$keyname") ?? 0.0;
      }
      // return retunvalue;
    } catch (e) {
      print(e);

    }
  }
}
