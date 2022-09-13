
import 'package:flutter/material.dart';
import 'package:iabd_com/widgets/button.dart';
import 'spacers.dart';


class ErrorMessage extends StatelessWidget {
  final String message;
  final Function retry;

  const ErrorMessage({Key? key, required this.message, required this.retry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          message,
          textAlign: TextAlign.center,
        ),
        VSpacer.normal,
        CustomButon(
          "Réessayer",
          onPressed: () {
            retry();
          },
        )
      ],
    );
    ;
  }
}
