import 'package:xml/xml.dart';

class Producteur {
  String? key;
  String? no;
  String? noTelephone;
  String? nom;
  String? prenoms;
  DateTime? datenaissance;
  int? typepiece;
  String? noPiece;
  String? localite;
  String? createur;
  String? agence;
  Producteur(
      {this.key,
        this.no,
        this.noTelephone,
        this.nom,
        this.prenoms,
        this.datenaissance,
        this.typepiece,
        this.noPiece,
        this.localite,
        this.createur,
        this.agence,


      });
  factory Producteur.fromXml(XmlElement xmlElement) {
    var keyNode = xmlElement.findAllElements('key');
    var keyValue = keyNode.isEmpty ? null : keyNode.first.text;
    var noNode = xmlElement.findAllElements('No');
    var noValue = noNode.isEmpty ? null : noNode.first.text;
    var noTelephoneNode = xmlElement.findAllElements('Telephone');
    var noTelephoneValue = noTelephoneNode.isEmpty ? null : noTelephoneNode.first.text;
    var datenaissanceNode = xmlElement.findAllElements('datenaissance');
    DateTime? datenaissanceValue = datenaissanceNode.isEmpty ? null : DateTime.parse(datenaissanceNode.first.text);
    var nomNode = xmlElement.findAllElements("Nom");
    String? nom = nomNode.isEmpty ?null : nomNode.first.text;
    var prenomsNode = xmlElement.findAllElements("Prenoms");
    String? prenomsValue = prenomsNode.isEmpty ?null : prenomsNode.first.text;


    var typepieceNode = xmlElement.findAllElements('typepiece');
    int typepieceValue = typepieceNode.isEmpty ? 0 : int.parse(typepieceNode.first.text);

    var noPieceNode = xmlElement.findAllElements("noPiece");
    String? noPieceValue = noPieceNode.isEmpty ?null : noPieceNode.first.text;

    var localiteNode = xmlElement.findAllElements("localite");
    String? localite = localiteNode.isEmpty ?null : localiteNode.first.text;

    var createurNode = xmlElement.findAllElements("createur");
    String? createur = localiteNode.isEmpty ?null : createurNode.first.text;

    var agenceNode = xmlElement.findAllElements("Agence_de_ratachement");
    String? agence = agenceNode.isEmpty ?null : agenceNode.first.text;




    return Producteur(
      key: keyValue,
      no: noValue,
      noTelephone: noTelephoneValue,
      nom: nom,
      prenoms: prenomsValue,
      datenaissance: datenaissanceValue,
      typepiece: typepieceValue,
      noPiece: noPieceValue,
      localite: localite,
      createur: createur,
      agence: agence,
    );
  }
}

