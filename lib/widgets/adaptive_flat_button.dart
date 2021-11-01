import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final bool isAndroid;
  final Function onPressedFunction;
  final double buttonHeight;
  final String title;

  const AdaptiveFlatButton({this.isAndroid , this.onPressedFunction , this.buttonHeight,this.title});

  @override
  Widget build(BuildContext context) {
    return  isAndroid ? TextButton(
        onPressed: onPressedFunction,
        child: Container(
          height: buttonHeight,
          child: FittedBox(
            child: Text(
              title,
              // style: TextStyle(fontSize: 16),
            ),
          ),
        )) : CupertinoButton(
        onPressed: onPressedFunction,
        child: Container(
          height: buttonHeight,
          child: FittedBox(
            child: Text(
              title,
              // style: TextStyle(fontSize: 16),
            ),
          ),
        ));
  }
}
