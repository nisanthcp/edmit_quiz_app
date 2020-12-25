import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyCategoryPage  extends StatefulWidget {

  MyCategoryPage({Key key , this.title}):super(key:key);
  final String title;

  @override
  State<StatefulWidget > createState()   => _MyCategoryPageState();
}

class _MyCategoryPageState extends  State<MyCategoryPage>{

  @override

  Widget build(BuildContext context) {
    return Scaffold(appBar:  AppBar(
      title: Text(widget.title),
    ),
    body: Center(child: Text('Category Page'),),  
    );
  }
}