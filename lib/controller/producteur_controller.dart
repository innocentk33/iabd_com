import 'package:get/get.dart';
import 'package:iabd_com/models/producteur_model.dart';

import '../api/producteur_client.dart';
import '../models/api_response.dart';

class ProducteurController extends GetxController{
  Future<ApiResponse> createProducteur(
      {required String noTelephone,required String nom,required String prenoms,required String datenaissance,required int typepiece,required String noPiece,required String localite,required String createur}) async {
    ProducteurClient producteurClientClient = ProducteurClient();
    var response =await producteurClientClient.createProducteur(noTelephone:noTelephone,nom: nom,prenoms: prenoms,datenaissance: datenaissance,typepiece: typepiece,noPiece: noPiece,localite: localite,createur: createur);
    if (!response.hasError) {
      print(response.message);
    }
    return response;
  }
}