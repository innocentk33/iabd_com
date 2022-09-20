import 'package:xml/xml.dart';

import '../models/api_response.dart';
import '../models/producteur_model.dart';
import 'soap_client.dart';

//Classe d'implementation des services soap
class ProducteurClient {
  SoapClient soapClient = SoapClient();
  SoapClient<Producteur> soapProducteur = SoapClient();

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

      if (result == "NONVALIDE") {
        response.hasError = true;
        response.message = "Element non valide";
      }else{
        response.message ="Votre producteur a bien été créé";
        print('Result $result');
      }

    }
    print( ' ****** REPONSE : ${response.message} \nbody : ${response.body} **************');
    return response;
  }

  Future<ApiResponse<Producteur>> getProducteurs({required login}) async {
    List<Producteur> items = [];

    var body = '''
<Envelope xmlns="http://schemas.xmlsoap.org/soap/envelope/">
    <Body>
        <ReadMultiple xmlns="urn:microsoft-dynamics-schemas/page/producteurlist">
            <filter>
                <Field>Username_creation</Field>
                <Criteria>$login</Criteria>
            </filter>
            <setSize>20</setSize>
        </ReadMultiple>
    </Body>
</Envelope>
    ''';

    var response = await soapProducteur.post(
        url: "Page/producteurlist",
        action: 'urn:microsoft-dynamics-schemas/page/producteurlist',
        body: body);

    if (!response.hasError) {
      final document = XmlDocument.parse(response.body);

      var elements = document.findAllElements('ProducteurList');
      elements.forEach((element) {
        items.add(Producteur.fromXml(element));
      });

      response.items = items;
    }

    return response;
  }





}
