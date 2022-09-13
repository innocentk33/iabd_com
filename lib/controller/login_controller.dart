import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/user_client.dart';
import '../models/api_response.dart';
import '../services/get_storage_service.dart';



class LoginController extends GetxController {


  Future<ApiResponse> login({required String login, required String password}) async {
    UserClient userClient = UserClient();
    var response =await userClient.authentificate(login: login, password: password);
    var customerNameResponse = await userClient.getCustomerName(login: login, password: password);
    if (!response.hasError) {
      //Savegarde des infos de l'utilisateur
      GetStorageService.saveLogin(login);
      GetStorageService.saveCustomerName(customerNameResponse.body);
      var customerResponse = await userClient.getCustomerNo(login: login, password: password);
      print("CUSTOMER NO : ${customerResponse.body}");

    }
    return response;
  }

}
