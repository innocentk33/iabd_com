import 'package:get_storage/get_storage.dart';



class GetStorageService {

  static String _userInfoKey = "userInfoKey";
  static String _urlKey = "urlKey";
  static String _customerNoKey = "customerKey";
  static String _depotKey = "depotKey";
  static String _epargneKey = "epargneKey";
  static String _customerNameKey = "customerNameKey";

  static GetStorage _getStorage = GetStorage();

  static saveLogin(String login) async {
    _getStorage.write(_userInfoKey, login);
  }
  static Future<String?> getLogin() async {
    var data = await _getStorage.read(_userInfoKey);
    return data;
  }
  //Ajoute
  static saveCustomerNo(String customerNo) async {
    _getStorage.write(_customerNoKey, customerNo);
  }


  static Future<String?> getCustomerNo() async {
    var data = await _getStorage.read(_customerNoKey);
    return data;
  }
  static clearDepotEpargne () async {
    await _getStorage.remove(_depotKey);
    await _getStorage.remove(_epargneKey);
  }

  static saveCustomerName(String customerName) async {
    _getStorage.write(_customerNameKey, customerName);
  }

  static Future<String> getCustmerName() async {
    var data = await _getStorage.read(_customerNameKey);
    return data;
  }
  static saveDepot(String depot) async {
    _getStorage.write(_depotKey, depot);
  }

  static Future<String> getDepot() async {
    var data = await _getStorage.read(_depotKey);
    return data;
  }
  static saveEpargne(String epargne) async {
    _getStorage.write(_epargneKey, epargne);
  }

  static Future<String> getEpargne() async {
    var data = await _getStorage.read(_epargneKey);
    return data;
  }
  static Future clearAll() async {
    _getStorage.erase();
  }

  static void clearUserLogin() async {
    await _getStorage.remove(_userInfoKey);
    await _getStorage.remove(_customerNoKey);
    await _getStorage.remove(_customerNameKey);
  }
}