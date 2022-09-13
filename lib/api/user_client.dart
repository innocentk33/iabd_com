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


  Future<ApiResponse> getCustomerName({required String login, required String password}) async {
    var body = '''
<Envelope xmlns="http://schemas.xmlsoap.org/soap/envelope/">
    <Body>
        <getCustomerName xmlns="urn:microsoft-dynamics-schemas/codeunit/AppAPI">
            <login>$login</login>
            <customerPassWord>$password</customerPassWord>
        </getCustomerName>
    </Body>
</Envelope>
    ''';

    var response = await soapClient.post(
        url: "codeunit/AppAPI",
        action: 'urn:microsoft-dynamics-schemas/codeunit/AppAPI',
        body: body);

    if (!response.hasError) {
      final document = XmlDocument.parse(response.body);

      String result = document.findAllElements('return_value').first.text;

      if (result == "0") {
        response.hasError = true;
        response.message = "Identifiant et/ou mot de passe incorrect(s)";
      }else {
        response.body = result;
      }
      print('Result $result');
    }
    //print( ' LA REPONSE ************************ message et body et result\n ${response.message} ${response.body}');
    return response;
  }

  //recuperer le numero du client
  Future<ApiResponse> getCustomerNo({required String login, required String password}) async {
    var body = '''
<Envelope xmlns="http://schemas.xmlsoap.org/soap/envelope/">
    <Body>
        <getCustomerNo xmlns="urn:microsoft-dynamics-schemas/codeunit/AppAPI">
            <login>$login</login>
            <customerPassWord>$password</customerPassWord>
        </getCustomerNo>
    </Body>
</Envelope>
    ''';

    var response = await soapClient.post(
        url: "codeunit/AppAPI",
        action: 'urn:microsoft-dynamics-schemas/codeunit/AppAPI',
        body: body);

    if (!response.hasError) {
      final document = XmlDocument.parse(response.body);

      String result = document.findAllElements('return_value').first.text;

      if (result == "0") {
        response.hasError = true;
        response.message = "Identifiant et/ou mot de passe incorrect(s)";
      }else{
        //Remplace le body de la response par le numero du client pas une bonne methode plutot creer un modele user qui prendra les bon element
        response.body = result;
      }
      print('Result $result');
    }
    return response;
  }

  Future<ApiResponse> getCustomerDepot({required String customerNo}) async {
    var body = '''
<Envelope xmlns="http://schemas.xmlsoap.org/soap/envelope/">
    <Body>
        <getCustomerDepot xmlns="urn:microsoft-dynamics-schemas/codeunit/AppAPI">
            <customerNo>$customerNo</customerNo>
        </getCustomerDepot>
    </Body>
</Envelope>
    ''';

    var response = await soapClient.post(
        url: "codeunit/AppAPI",
        action: 'urn:microsoft-dynamics-schemas/codeunit/AppAPI',
        body: body);

   /* if (!response.hasError) {
      final document = XmlDocument.parse(response.body);

      String result = document.findAllElements('return_value').first.text;

      if (result == "0") {
        response.hasError = true;
        response.message = "Identifiant et/ou mot de passe incorrect(s)";
      }else{

      }
      //Remplace le body de la response par le numero du client pas une bonne methode plutot creer un modele user qui prendra les bon element
      response.body = result;
      print('Result de depot $result');
    }*/
    final document = XmlDocument.parse(response.body);
    String result = document.findAllElements('return_value').first.text;
    response.body = result;
    print('Result de depot $result');
    return response;
  }

  Future<ApiResponse> getCustomerEpargne({required String customerNo}) async {
    var body = '''
<Envelope xmlns="http://schemas.xmlsoap.org/soap/envelope/">
    <Body>
        <getCustomerDEpargne xmlns="urn:microsoft-dynamics-schemas/codeunit/AppAPI">
            <customerNo>$customerNo</customerNo>
        </getCustomerDEpargne>
    </Body>
</Envelope>
    ''';

    var response = await soapClient.post(
        url: "codeunit/AppAPI",
        action: 'urn:microsoft-dynamics-schemas/codeunit/AppAPI',
        body: body);

/*    if (!response.hasError) {
      final document = XmlDocument.parse(response.body);

      String result = document.findAllElements('return_value').first.text;

      if (result == "0") {
        response.hasError = true;
        response.message = "Impossible d'obtenir des informations";
      }else{
        //Remplace le body de la response par le numero du client pas une bonne methode plutot creer un modele user qui prendra les bon element
        response.body = result;
      }
      print('Result $result');
    } */

    final document = XmlDocument.parse(response.body);
    String result = document.findAllElements('return_value').first.text;
    response.body = result;
    print('Result de depot $result');
    return response;
  }

  Future<ApiResponse> getNombreElement(String customerNo, int documentNo) async {
    var body = '''
<Envelope xmlns="http://schemas.xmlsoap.org/soap/envelope/">
    <Body>
        <NbreElement xmlns="urn:microsoft-dynamics-schemas/codeunit/AppAPI">
            <client>$customerNo</client>
            <document>$documentNo</document>
            <online>true</online>
        </NbreElement>
    </Body>
</Envelope>
    ''';

    var response = await soapClient.post(
        url: "codeunit/AppAPI",
        action: 'urn:microsoft-dynamics-schemas/codeunit/AppAPI',
        body: body);

    if (!response.hasError) {
      final document = XmlDocument.parse(response.body);

      String result = document.findAllElements('return_value').first.text;
      response.body = result;
      print('Result $result');
    }
   // print( ' LA REPONSE ************************ message et body et result\n ${response.message} ${response.body}');
    return response;
  }
}
