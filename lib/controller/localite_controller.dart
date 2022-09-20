import 'package:get/get.dart';
import 'package:iabd_com/models/localite_model.dart';
import 'package:iabd_com/models/producteur_model.dart';

import '../api/localite_client.dart';
import '../models/api_response.dart';

class LocaliteController extends GetxController{

  var _isLoading = false.obs;
  LocaliteClient localiteClient = LocaliteClient();
  List<Producteur> producteurList = [];
  ApiResponse<Localite>? _apiResponse;

  getLocaliteList(String agence) async {
    _isLoading.value = true;
    _apiResponse = await localiteClient.getLocalite(agence: agence);
    _isLoading.value = false;
    return _apiResponse;
  }

  ApiResponse<Localite>? get apiResponse => _apiResponse;

}