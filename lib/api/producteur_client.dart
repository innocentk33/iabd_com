import 'package:xml/xml.dart';

import '../models/api_response.dart';
import '../models/producteur_model.dart';
import 'soap_client.dart';

//Classe d'implementation des services soap
class ProducteurClient {
  SoapClient soapClient = SoapClient();
  SoapClient<Producteur> quoteSoap = SoapClient();
  Future<ApiResponse> createProducteur( { required String noTelephone,required String nom,required String prenoms,required String datenaissance,required int typepiece,required String noPiece,required String localite,required String createur}) async {
    var body = '''
              <Envelope xmlns="http://schemas.xmlsoap.org/soap/envelope/">
    <Body>
        <EnregisterProducteur xmlns="urn:microsoft-dynamics-schemas/codeunit/Fonctions">
            <noTelephone>$noTelephone</noTelephone>
            <nom>$nom</nom>
            <prenoms>$prenoms</prenoms>
            <datenaissance>$datenaissance</datenaissance>
            <typepiece>$typepiece</typepiece>
            <noPiece>$noPiece</noPiece>
            <localite>$localite</localite>
            <createur>$createur</createur>
        </EnregisterProducteur>
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

      if (result == "false") {
        response.hasError = true;
        response.message = "Impossible de creer le devis";
      }
      response.message ="Votre devis a bien été créé";
      print('Result $result');
    }
    print( ' ****** REPOSE  \n ${response.message} ${response.body} **************');
    return response;
  }

}
