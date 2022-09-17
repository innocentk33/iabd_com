import 'package:get/get.dart';

import '../services/get_storage_service.dart';



class HomeController extends GetxController{



  clearSession() {
    GetStorageService.clearUserLogin();
  }

}