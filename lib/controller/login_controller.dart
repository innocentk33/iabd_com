import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/user_client.dart';
import '../models/api_response.dart';
import '../services/get_storage_service.dart';



class LoginController extends GetxController {


  Future<ApiResponse> login({required String login, required String password}) async {
    UserClient userClient = UserClient();
    var response =await userClient.authentificate(login: login, password: password);
    var userNameResponse = await userClient.getCustomerName(login: login);
    if (!response.hasError) {
      //Sauvegarde des infos de l'utilisateur
      GetStorageService.saveLogin(login);
      GetStorageService.saveUserName(userNameResponse.body);

    }
    return response;
  }

}
