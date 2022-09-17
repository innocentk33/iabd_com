import 'package:flutter/material.dart';

class ApiResponse<T> {
   bool hasError;
  String body;
  String? message;
  List<T>? items;

  ApiResponse({this.items, required this.hasError, required this.body, this.message});

  Widget when({Widget error(String message)?, Widget data(List<T> items)?}) {
    if (hasError) {
      return error!(message!);
    }

    if( items!.isEmpty){
      return error!("Aucun élément");
    }
    if (body.isEmpty){
      return error!("Corps vide");
    }

    return data!(items!);
  }
}
