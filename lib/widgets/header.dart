import 'package:flutter/material.dart';

AppBar header(context,
    {bool isAppTitle = false, String titleText, removeBackButton = false}) {
  return AppBar(
    automaticallyImplyLeading: removeBackButton ? false : true,
    title: Text(
      isAppTitle ? 'ReteteBlanao' : titleText,
      style: TextStyle(
          fontSize: isAppTitle ? 50.0 : 22.0,
          fontFamily: isAppTitle ? 'Signatra' : '',
          color: Colors.white),
    ),
    centerTitle: true,
    backgroundColor: Theme.of(context).accentColor,
  );
}
