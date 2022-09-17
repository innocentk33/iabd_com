import 'package:get/get_state_manager/get_state_manager.dart';

import '../services/get_storage_service.dart';


class SplashScreenController extends GetxController{

  Future<String?> getUserLogin() => GetStorageService.getLogin();
}