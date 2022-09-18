import 'package:get/get.dart';
import 'package:iabd_com/models/producteur_model.dart';

import '../api/producteur_client.dart';
import '../models/api_response.dart';

class ProducteurController extends GetxController{

  ApiResponse<Producteur>? _response;
  var _isLoading = false.obs;
  ProducteurClient producteurClient = ProducteurClient();
  List<Producteur> producteurList = [];
  ApiResponse<Producteur>? _apiResponse;
  Future<ApiResponse> createProducteur(
      {required String noTelephone,required String nom,required String prenoms,required String datenaissance,required int typepiece,required String noPiece,required String localite,required String createur}) async {
    ProducteurClient producteurClientClient = ProducteurClient();
    var response =await producteurClientClient.createProducteur(noTelephone:noTelephone,nom: nom,prenoms: prenoms,datenaissance: datenaissance,typepiece: typepiece,noPiece: noPiece,localite: localite,createur: createur);
    if (!response.hasError) {
      print(response.message);
    }
    return response;
  }
  
  getProducteurList() async {
    _isLoading.value = true;
    _apiResponse = await producteurClient.getProducteurs();
    _isLoading.value = false;
    return _apiResponse;
  }

  ApiResponse<Producteur>? get response => _response;
  ApiResponse<Producteur>? get apiResponse => _apiResponse;

}