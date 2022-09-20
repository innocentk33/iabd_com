import 'package:xml/xml.dart';

class Localite {
  String? key;
  String? localite;
  String? code;
  String? region;
  String? agence;

  Localite(
      {this.key,
        this.localite,
        this.code,
        this.region,
        this.agence,

      });

  factory Localite.fromXml(XmlElement xmlElement) {
    var keyNode = xmlElement.findAllElements('key');

    var keyValue = keyNode.isEmpty ? null : keyNode.first.text;
    var localiteNode = xmlElement.findAllElements('Type');

    var localite = localiteNode.isEmpty ? null : localiteNode.first.text;
    var codeNode = xmlElement.findAllElements('Code');
    var code = codeNode.isEmpty ? null : codeNode.first.text;

    var regionNode = xmlElement.findAllElements("Region");
    String? region = regionNode.isEmpty ?null : regionNode.first.text;

    var agenceNode = xmlElement.findAllElements("Agence");
    String? agence = agenceNode.isEmpty ?null : agenceNode.first.text;


    return Localite(
      key: keyValue,
      localite: localite,
      code: code,
      region: region,
      agence: agence,
    );
  }
}

