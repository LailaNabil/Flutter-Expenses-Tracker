import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveTextField extends StatelessWidget {
  final bool isAndroid;
  final String title;
  final Function onSubmittedFunction;
  final TextEditingController textController;
  final TextInputType keyboardType;

  const AdaptiveTextField(
      {Key key, this.isAndroid, this.title, this.onSubmittedFunction, this.textController,this.keyboardType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isAndroid
        ? TextField(
      decoration: InputDecoration(labelText: title),
      controller: textController,
      keyboardType: TextInputType.number,
      onSubmitted: (_) => onSubmittedFunction,
    )
        : CupertinoTextField.borderless(
      placeholder: title,
      controller: textController,
      keyboardType: keyboardType,
      onSubmitted: (_) => onSubmittedFunction,
    );
  }
}

