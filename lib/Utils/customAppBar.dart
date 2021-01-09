import 'package:flutter/material.dart';
import 'package:super_store/Utils/util.dart';

Widget customAppBar(){
  return AppBar(
    centerTitle: true,
    elevation: 0,
    backgroundColor: backgroundColor,
    iconTheme: IconThemeData(color: textColor1),
    title: Text(" Super Store", style: TextStyle(color: textColor1,),),
    actions: [
      IconButton(icon: Icon(Icons.search), onPressed: (){})
    ],
  );
}