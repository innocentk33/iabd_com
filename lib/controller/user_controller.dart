import 'package:get/get.dart';
import '../api/user_client.dart';
import '../services/get_storage_service.dart';




class UserController extends GetxController{
  RxString _login = "".obs;
  RxString _customerNo ="".obs;
  UserClient userClient = UserClient();

  getLogin() async {
    _login.value = (await GetStorageService.getLogin())!;
  }
  getCustomerNo () async{
    _customerNo.value = (await GetStorageService.getCustomerNo())!;
  }

  String get login => _login.value;

}