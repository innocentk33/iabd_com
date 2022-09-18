import 'dart:async';

import 'package:get/get.dart';
import 'package:iabd_com/controller/producteur_controller.dart';
import 'package:iabd_com/models/producteur_model.dart';

import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/error_message.dart';

class AjoutrecentWidget extends StatefulWidget {
  const AjoutrecentWidget({Key? key}) : super(key: key);

  @override
  _AjoutrecentWidgetState createState() => _AjoutrecentWidgetState();
}

class _AjoutrecentWidgetState extends State<AjoutrecentWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ProducteurController producteurController = Get.put(ProducteurController());
  Future<List<Producteur>>? producteurs;
  Future<List<Producteur>> _getListProducteur() async {
    var response = await producteurController.getProducteurList();
    return response.items;
  }
  @override
  void initState() {
    producteurs = _getListProducteur();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          borderWidth: 1,
          buttonSize: 60,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () async {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Ajout récent',
          style: FlutterFlowTheme.of(context).bodyText2.override(
                fontFamily: 'Poppins',
                color: FlutterFlowTheme.of(context).primaryBtnText,
              ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 2,
      ),
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child:  FutureBuilder<List<Producteur>>(
            future: producteurs,
            builder: (context, snapshot) {
              print('THE SANPSHOT $snapshot');
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator());
              }
              else {
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.92,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).primaryBackground,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${snapshot.data?[index].no}',
                                              style: FlutterFlowTheme.of(context).subtitle1,
                                            ),
                                            Padding(
                                              padding:
                                              EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                              child: Text('${snapshot.data?[index].nom} ${snapshot.data?[index].prenoms}',
                                                style: FlutterFlowTheme.of(context).bodyText1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            '${snapshot.data?[index].noTelephone}',
                                            textAlign: TextAlign.end,
                                            style: FlutterFlowTheme.of(context)
                                                .subtitle2
                                                .override(
                                              fontFamily: 'Poppins',
                                              color: FlutterFlowTheme.of(context)
                                                  .tertiaryColor,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                            child: Text(
                                              '${snapshot.data?[index].agence}',
                                              textAlign: TextAlign.end,
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyText1
                                                  .override(
                                                fontFamily: 'Poppins',
                                                fontSize: 12,
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
                            Divider(thickness: 2,color: FlutterFlowTheme.of(context).gray600.withOpacity(0.15),)
                          ],
                        );
                    },
                  );
                } else if (snapshot.hasError) {
                  print("${snapshot.error}");
                  return Center(child: CircularProgressIndicator() );
                } else {
                  print("pomme");
                  Timer(Duration(seconds: 3), () {
                    ErrorMessage(message: "${producteurController.apiResponse?.message}", retry: ()=> _getListProducteur());
                  });

                  return Center(child:  ErrorMessage(message: "Aucun producteur trouvé", retry: ()=> _getListProducteur()));
                }
              }
            },
          )





        ),
      ),
    );
  }
}
