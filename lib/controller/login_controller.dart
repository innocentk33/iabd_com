import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/user_client.dart';
import '../models/api_response.dart';
import '../services/get_storage_service.dart';



class LoginController extends GetxController {


  Future<ApiResponse> login({required String login, required String password}) async {
    UserClient userClient = UserClient();
    GetStorageService getStorageService = GetStorageService();
    var response =await userClient.authentificate(login: login, password: password);

    if (!response.hasError) {
      //Sauvegarde des infos de l'utilisateur
      print("Save login");
      GetStorageService.saveLogin(login);
      //GetStorageService.saveUserName(userNameResponse.body);
      print ("login is saved the value is : ${GetStorageService.getPhoneNumber()}");
      var useResponse = await userClient.getUserinfo(login: GetStorageService.getPhoneNumber());
      if (!useResponse.hasError){
        print(useResponse.items);
        GetStorageService.saveUserInfo(getStorageService.userPhone, useResponse.items![0]);
        GetStorageService.saveUserInfo(getStorageService.userName, useResponse.items![1]);
        GetStorageService.saveUserInfo(getStorageService.userTopPaiement, useResponse.items![2]);
        GetStorageService.saveUserInfo(getStorageService.userType, useResponse.items![3]);
        GetStorageService.saveUserInfo(getStorageService.userAgence, useResponse.items![4]);
      }else{
        print(useResponse.message);
      }
    }
    return response;
  }


}
