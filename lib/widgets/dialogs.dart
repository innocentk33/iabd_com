
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'spacers.dart';


Future showInfoDialog(BuildContext context,
    {String? message,
    String positiveLabel = "OK",
    Function? positiveAction,
    String? negativeLabel,
    Function? negativeAction}) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      content: Text(message ?? ""),
      actions: [
        if (negativeLabel != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Get.back();
                if (negativeAction != null) negativeAction();
              },
              child: Text(
                negativeLabel,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        if (positiveLabel.isEmpty != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Get.back();
                if (positiveAction != null) positiveAction();
              },
              child: Text(
                positiveLabel,
                style: TextStyle(fontSize: 18),
              ),
            ),
          )
      ],
    ),
  );
}

Future showLoadingDialog(BuildContext context, {String? message}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(

      content: Container(
        height: MediaQuery.of(context).size.height/3,

        child: Row(
          children: [
        CircularProgressIndicator(),
            HSpacer.normal,
            Expanded(
              child: Text(message!),
            )
          ],
        ),
      ),
    ),
  );
}
