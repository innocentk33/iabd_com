import 'package:iabd_com/models/localite_model.dart';
import 'package:xml/xml.dart';

import '../constant/const.dart';
import '../models/api_response.dart';
import '../models/producteur_model.dart';
import 'soap_client.dart';

//Classe d'implementation des services soap
class LocaliteClient {
  SoapClient soapClient = SoapClient();
  SoapClient<Localite> soapLocalite = SoapClient();


  Future<ApiResponse<Localite>> getLocalite({required String agence}) async {
    List<Localite> items = [];

    var body = '''
<Envelope xmlns="http://schemas.xmlsoap.org/soap/envelope/">
    <Body>
        <ReadMultiple xmlns="urn:microsoft-dynamics-schemas/page/localiteslist">
            <filter>
                <Field>Agence</Field>
                <Criteria>$agence</Criteria>
            </filter>
            <filter>
              <Field>Type</Field>
                <Criteria>0</Criteria>
            </filter>
        </ReadMultiple>
    </Body>
</Envelope>
    ''';

    var response = await soapLocalite.post(
        url: "Page/localiteslist",
        action: 'urn:microsoft-dynamics-schemas/page/localiteslist',
        body: body);

    if (!response.hasError) {
      final document = XmlDocument.parse(response.body);

      var elements = document.findAllElements('LocalitesList');
      elements.forEach((element) {
        items.add(Localite.fromXml(element));
      });

      response.items = items;
      print('**ITEMS*** ${response.items}');
      print("LA RESPONSE ${response.body}");
    }else{
      print('Erreur :\n $response.body');
      response.body =errorServerNotFound;
    }

    return response;
  }





}
