import 'dart:async';

import 'package:get/get.dart';
import 'package:iabd_com/controller/localite_controller.dart';
import 'package:iabd_com/models/producteur_model.dart';
import 'package:iabd_com/services/get_storage_service.dart';

import '../controller/producteur_controller.dart';
import '../flutter_flow/flutter_flow_drop_down.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/localite_model.dart';
import '../widgets/dialogs.dart';
import '../widgets/error_message.dart';


class AddProducteurWidget extends StatefulWidget {
  const AddProducteurWidget({Key? key}) : super(key: key);

  @override
  _AddProducteurWidgetState createState() => _AddProducteurWidgetState();
}

class _AddProducteurWidgetState extends State<AddProducteurWidget> {

  final ProducteurController controller = Get.put(ProducteurController());
  final GetStorageService getStorageService = GetStorageService();
  final LocaliteController localiteController = Get.put(LocaliteController());

  TextEditingController? noPieceController;

  TextEditingController? nomController;

  TextEditingController? prenomController;

  TextEditingController? numeroController;

  DateTime? datePicked;
  String? pieceSelectValue;
  String? localiteSelectValue;
  Localite? selectedLocalite;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<Localite> localites = [];
  Future<List<Localite>>? localiteList;
  List<String> pieceIdentitelist = ['CNI','Attestation','Extrait','Passeport','Autre'];

  Future<List<Localite>> _getListLocalite() async {
    var response = await localiteController.getLocaliteList(
        GetStorageService.getUserInfo(getStorageService.userAgence));
    return response.items;
  }



  @override
  void initState() {
    super.initState();
    noPieceController = TextEditingController();
    nomController = TextEditingController();
    prenomController = TextEditingController();
    numeroController = TextEditingController();
    localiteList = _getListLocalite();



  }


  void _submitProducteur() async {
    showLoadingDialog(context, message: "Veuillez patienter ...");


//String dateString = '${datePicked!}-${datePicked!.month}-${datePicked!.day}';
    //TODO: Arranger cette mauvaise maniere de recuperer les pieces identit??
    //Cni,Attestation,Extrait,Passeport,Autre



    String dateString = datePicked.toString();
    dateString = dateString.substring(0, 10);
    var response = await controller.createProducteur(
        noTelephone: numeroController!.text.trim(),
        nom: nomController!.text,
        prenoms: prenomController!.text,
        datenaissance: dateString,
        typepiece: pieceIdentitelist.indexOf(pieceSelectValue!),
        noPiece: noPieceController!.text,
        localite: localiteSelectValue!,
        createur: GetStorageService.getUserInfo(getStorageService.userPhone));
    Get.back();

    if (response.hasError) {
      showInfoDialog(context, message: response.message, positiveAction: () {
        //Get.back();
        // Get.back();
      });
      return;
    }
    showInfoDialog(context, message: response.message, positiveAction: () {
      Get.back();
      //Get.back();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryColor,
        iconTheme: IconThemeData(
            color: FlutterFlowTheme.of(context).primaryBackground),
        automaticallyImplyLeading: true,
        title: Text(
          'Ajouter producteur',
          style: FlutterFlowTheme.of(context).bodyText2.override(
                fontFamily: 'Poppins',
                color: FlutterFlowTheme.of(context).primaryBtnText,
              ),
        ),
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
            child: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30,
              buttonSize: 48,
              icon: Icon(
                Icons.close_rounded,
                color: FlutterFlowTheme.of(context).secondaryBackground,
                size: 30,
              ),
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
          ),
        ],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                            child: TextFormField(
                              controller: nomController,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Nom',
                                hintStyle:
                                    FlutterFlowTheme.of(context).bodyText2,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
                                    20, 32, 20, 12),
                              ),
                              style: FlutterFlowTheme.of(context).bodyText1,
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'Champ obligatoire';
                                }

                                if (!RegExp(kTextValidatorUsernameRegex)
                                    .hasMatch(val)) {
                                  return 'Sans espace et ne peut contenir que des lettres';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                            child: TextFormField(
                              controller: prenomController,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Prenom',
                                hintStyle:
                                    FlutterFlowTheme.of(context).bodyText2,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
                                    20, 32, 20, 12),
                              ),
                              style: FlutterFlowTheme.of(context).bodyText1,
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'Champ obligatoire';
                                }

                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                            child: TextFormField(
                              controller: numeroController,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Numero',
                                hintStyle:
                                    FlutterFlowTheme.of(context).bodyText2,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
                                    20, 32, 20, 12),
                              ),
                              style: FlutterFlowTheme.of(context).bodyText1,
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              keyboardType: TextInputType.phone,
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'Champ obligatoire';
                                }

                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 8, 0),
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                          width: 2,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            12, 5, 12, 5),
                                        child: InkWell(
                                          onTap: () async {
                                            await DatePicker.showDatePicker(
                                              context,
                                              showTitleActions: true,

                                              onConfirm: (date) {
                                                setState(
                                                    () => datePicked = date);
                                              },
                                              currentTime: getCurrentTimestamp,
                                              locale:
                                                  LocaleType.values.firstWhere(
                                                (l) =>
                                                    l.name ==
                                                    FFLocalizations.of(context)
                                                        .languageCode,
                                                orElse: () => LocaleType.en,
                                              ),
                                            );
                                          },
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                valueOrDefault<String>(
                                                  dateTimeFormat(
                                                      'dd/MM/yyyy', datePicked),
                                                  'Date de naissance',
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1,
                                              ),
                                              Icon(
                                                Icons.date_range_outlined,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                size: 24,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Card(
                            elevation: 2,
                            margin: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                            child: Container(

                              decoration: BoxDecoration(

                              ),
                              padding:
                              EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                              width: double.infinity,
                              height: 60,
                              child:
                              FutureBuilder(
                                future:localiteList,
                                builder: (BuildContext context, AsyncSnapshot snapshot) {
                                  return snapshot.hasData
                                      ? Container(
                                    child: DropdownButton<String>(
                                      hint: Text(localiteSelectValue ?? 'Localit??',style: FlutterFlowTheme.of(context).bodyText1,),
                                      style: FlutterFlowTheme.of(context).bodyText1,

                                      isExpanded: true,
                                      items: snapshot.data.map<DropdownMenuItem<String>>((item) {
                                        return DropdownMenuItem<String>(

                                          value: item.code,
                                          child: Text(item.code,style: FlutterFlowTheme.of(context).bodyText1,),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          localiteSelectValue = value;
                                          print(value);
                                        });
                                      },
                                    ),
                                  )
                                      : Container(
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                            child: FlutterFlowDropDown(
                              options: pieceIdentitelist,
                              onChanged: (val) =>
                                  setState(() => pieceSelectValue = val),
                              width: double.infinity,
                              height: 60,
                              textStyle: FlutterFlowTheme.of(context).bodyText1,
                              hintText: 'Piece d\'identit??',
                              icon: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                size: 15,
                              ),
                              fillColor: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              elevation: 2,
                              borderColor: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              borderWidth: 2,
                              borderRadius: 8,
                              margin:
                                  EdgeInsetsDirectional.fromSTEB(24, 4, 12, 4),
                              hidesUnderline: true,
                            ),
                          ),


                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                            child: TextFormField(
                              controller: noPieceController,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Numero piece',
                                hintStyle:
                                    FlutterFlowTheme.of(context).bodyText2,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
                                    20, 32, 20, 12),
                              ),
                              style: FlutterFlowTheme.of(context).bodyText1,
                              textAlign: TextAlign.start,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 16),
                        child: FFButtonWidget(
                          onPressed: () async {
                            if (formKey.currentState == null ||
                                !formKey.currentState!.validate()) {
                              return;
                            }else {
                              _submitProducteur();
                            }
                          },
                          text: 'Creer',
                          options: FFButtonOptions(
                            width: 270,
                            height: 50,
                            color: FlutterFlowTheme.of(context).primaryColor,
                            textStyle:
                                FlutterFlowTheme.of(context).subtitle1.override(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                    ),
                            elevation: 3,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
