import 'package:get/get.dart';
import '../api/user_client.dart';
import '../services/get_storage_service.dart';




class UserController extends GetxController{
  RxString _login = "".obs;
  RxString _customerNo ="".obs;
  RxString _customerName = "".obs;
  UserClient userClient = UserClient();

  getLogin() async {
    _login.value = (await GetStorageService.getLogin())!;
    _customerName.value = await GetStorageService.getCustmerName();
  }
  getCustomerNo () async{
    _customerNo.value = (await GetStorageService.getCustomerNo())!;
  }


  String get login => _login.value;
  String get customerName =>_customerName.value;
  String get customerNo => _customerNo.value;
}