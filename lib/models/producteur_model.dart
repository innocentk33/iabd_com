import 'package:xml/xml.dart';

class Producteur {
  String? key;
  String? noTelephone;
  String? nom;
  String? prenoms;
  DateTime? datenaissance;
  int? typepiece;
  String? noPiece;
  String? localite;
  String? createur;
  Producteur(
      {this.key,
        this.noTelephone,
        this.nom,
        this.prenoms,
        this.datenaissance,
        this.typepiece,
        this.noPiece,
        this.localite,
        this.createur,


      });
  factory Producteur.fromXml(XmlElement xmlElement) {
    var keyNode = xmlElement.findAllElements('key');
    var keyValue = keyNode.isEmpty ? null : keyNode.first.text;
    var noTelephoneNode = xmlElement.findAllElements('noTelephone');
    var noTelephoneValue = noTelephoneNode.isEmpty ? null : noTelephoneNode.first.text;
    var datenaissanceNode = xmlElement.findAllElements('datenaissance');
    DateTime? datenaissanceValue = datenaissanceNode.isEmpty ? null : DateTime.parse(datenaissanceNode.first.text);
    var nomNode = xmlElement.findAllElements("nom");
    String? nom = nomNode.isEmpty ?null : nomNode.first.text;
    var prenomsNode = xmlElement.findAllElements("prenoms");
    String? prenomsValue = prenomsNode.isEmpty ?null : prenomsNode.first.text;


    var typepieceNode = xmlElement.findAllElements('typepiece');
    int typepieceValue = typepieceNode.isEmpty ? 0 : int.parse(typepieceNode.first.text);

    var noPieceNode = xmlElement.findAllElements("noPiece");
    String? noPieceValue = noPieceNode.isEmpty ?null : noPieceNode.first.text;

    var localiteNode = xmlElement.findAllElements("localite");
    String? localite = localiteNode.isEmpty ?null : localiteNode.first.text;

    var createurNode = xmlElement.findAllElements("createur");
    String? createur = localiteNode.isEmpty ?null : createurNode.first.text;




    return Producteur(
      key: keyValue,
      noTelephone: noTelephoneValue,
      nom: nom,
      prenoms: prenomsValue,
      datenaissance: datenaissanceValue,
      typepiece: typepieceValue,
      noPiece: noPieceValue,
      localite: localite,
      createur: createur,
    );
  }
}

