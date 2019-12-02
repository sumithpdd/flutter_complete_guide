import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final String text;
final Function onPressedHandler;
AdaptiveFlatButton(this.text,this.onPressedHandler);
  @override
  Widget build(BuildContext context) {
    return  
      Platform.isIOS
                        ? CupertinoButton(
                            child: Text(
                             text,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            onPressed: onPressedHandler)
                        : FlatButton(
                            textColor: Theme.of(context).primaryColor,
                            child: Text(
                              text,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            onPressed: onPressedHandler,
                          )
    ;
  }
}