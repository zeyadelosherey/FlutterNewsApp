import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';


class WebviewPage extends StatelessWidget{
  String url ;
  WebviewPage({Key key, @required  this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return   WebviewScaffold(
      url:url,

      appBar: AppBar(backgroundColor: Colors.white , iconTheme: IconThemeData(color: Colors.black), elevation: 0,),
      withZoom: true,
      withLocalStorage: true,
      withJavascript: true,

      hidden: true,
      initialChild: Container(
        color: Colors.white,
        child: const Center(
          child: Text('جاري التحميل ...' ,style: TextStyle(color: Colors.black ,fontSize: 20), textDirection: TextDirection.rtl,),
        ),
      ),



    );
  }}