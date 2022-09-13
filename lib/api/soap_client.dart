import 'dart:io';
import 'package:http/http.dart' as http;

import '../config/config.dart';
import '../models/api_response.dart';


class SoapClient<T> {

  Future<ApiResponse<T>> post({String? url, required String action, required String body}) async {
    //var baseUrl = await GetStorageService.getUrl();
    //print('POOOSTED REQUEST \n');
    var baseUrl = apiUrl;
    String completeUrl = "$baseUrl/$url";
    var uri = Uri.parse(completeUrl);
    print("url => $completeUrl");
    print("body => $body");

    try {
      var response = await http.post(
        uri,
        headers: {
          'Content-Type': 'text/xml',
          'SOAPAction': action,
          'Authorization': 'Basic $apiToken'
        },
        body: body,
      );
      //print("response => ${response.body}");
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return ApiResponse<T>(hasError: false, body: response.body);
      } else {
        return ApiResponse<T>(hasError: true, message: response.reasonPhrase,body: body);
      }
    } on SocketException {
      return ApiResponse<T>(
          hasError: true,
          body: body,
          message: "Impossible de se connecter!\nVeuillez réessayer");
    }
  }
}