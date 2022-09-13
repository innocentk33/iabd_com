import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/lat_lng.dart';

class FFAppState {
  static final FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal() {
    initializePersistedState();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _numero = prefs.getString('ff_numero') ?? _numero;
    _password = prefs.getString('ff_password') ?? _password;
    _authtoken = prefs.getString('ff_authtoken') ?? _authtoken;
    _baseurl = prefs.getString('ff_baseurl') ?? _baseurl;
  }

  late SharedPreferences prefs;

  String _numero = '';
  String get numero => _numero;
  set numero(String _value) {
    _numero = _value;
    prefs.setString('ff_numero', _value);
  }

  String _password = '';
  String get password => _password;
  set password(String _value) {
    _password = _value;
    prefs.setString('ff_password', _value);
  }

  String _authtoken = 'Basic c2VydmljZXM6JSVJYWJkMTMy';
  String get authtoken => _authtoken;
  set authtoken(String _value) {
    _authtoken = _value;
    prefs.setString('ff_authtoken', _value);
  }

  String _baseurl = 'http://51.83.47.175:7047/BC180/WS/IABD';
  String get baseurl => _baseurl;
  set baseurl(String _value) {
    _baseurl = _value;
    prefs.setString('ff_baseurl', _value);
  }

  String dateNaissance = 'Date de naissance';
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}
