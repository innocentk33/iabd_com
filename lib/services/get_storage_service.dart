import 'package:get_storage/get_storage.dart';



class GetStorageService {

  static String _userInfoKey = "userInfoKey";
  static String _urlKey = "urlKey";
  static String _customerNoKey = "customerKey";
  static String _depotKey = "depotKey";
  static String _epargneKey = "epargneKey";
  static String _customerNameKey = "customerNameKey";
  /*USER INFOS*/
  static String _userPhone = "userPhone";
  static String _userName = "userName";
  static String _userTopPaiement = "userTopPaiement";
  static String _userType = "userType";
  static String _userAgence = "userAgence";

  static GetStorage _getStorage = GetStorage();

  /*SAVE USER INFOS*/
  static saveUserInfo(String key, String data) async {
    _getStorage.write(key, data);
  }
  /*GET USER INFO*/
  static String getUserInfo(String key){
    var data = _getStorage.read(key);
    return data;
  }

  /*SAVE & GET GLOBAL INFO*/
  static saveLogin(String login) async {
    _getStorage.write(_userInfoKey, login);
  }
  static Future<String?> getLogin() async {
    var data = await _getStorage.read(_userInfoKey);
    return data;
  }
  static String getPhoneNumber(){
    var data = _getStorage.read(_userInfoKey);
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

  static saveUserName(String customerName) async {
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
    await _getStorage.remove(_userAgence);
    await _getStorage.remove(_userType);
    await _getStorage.remove(_userTopPaiement);
    await _getStorage.remove(_userName);
    await _getStorage.remove(_userPhone);
  }

 String  get userPhone => _userPhone;
 String  get userName => _userName;
 String  get userTopPaiement => _userTopPaiement;
 String  get userType => _userType;
 String  get userAgence => _userAgence;
}