import 'package:xml/xml.dart';

import '../models/api_response.dart';
import 'soap_client.dart';

//Classe d'implementation des services soap
class UserClient {
  SoapClient soapClient = SoapClient();

  Future<ApiResponse> authentificate({required String login, required String password}) async {
    var body = '''
<Envelope xmlns="http://schemas.xmlsoap.org/soap/envelope/">
    <Body>
        <GetPassword xmlns="urn:microsoft-dynamics-schemas/codeunit/Fonctions">
            <myusername>$login</myusername>
            <motdepasse>$password</motdepasse>
        </GetPassword>
    </Body>
</Envelope>
    ''';

    var response = await soapClient.post(
        url: "codeunit/Fonctions",
        action: 'urn:microsoft-dynamics-schemas/codeunit/Fonctions',
        body: body);

    if (!response.hasError) {
      final document = XmlDocument.parse(response.body);

      String result = document.findAllElements('return_value').first.text;

      if (result == "0") {
        response.hasError = true;
        response.message = "Identifiant et/ou mot de passe incorrect(s)";
      }
      if (result == "2"){
        response.hasError = true;
        response.message= "Utilisateur n'existe pas";
      }
      print('Result $result');
    }
    //print( ' LA REPONSE ************************ message et body et result\n ${response.message} ${response.body}');
    return response;
  }


  Future<ApiResponse> getCustomerName({required String login}) async {
    var body = '''
<Envelope xmlns="http://schemas.xmlsoap.org/soap/envelope/">
    <Body>
        <GetUserinfo xmlns="urn:microsoft-dynamics-schemas/codeunit/Fonctions">
            <myusername>$login</myusername>
        </GetUserinfo>
    </Body>
</Envelope>
    ''';

    var response = await soapClient.post(
        url: "codeunit/Fonctions",
        action: 'urn:microsoft-dynamics-schemas/codeunit/Fonctions',
        body: body);

    if (!response.hasError) {
      final document = XmlDocument.parse(response.body);

      String result = document.findAllElements('return_value').first.text;
        response.body = result;
      print('Result $result');
    }
    //print( ' LA REPONSE ************************ message et body et result\n ${response.message} ${response.body}');
    return response;
  }
}
