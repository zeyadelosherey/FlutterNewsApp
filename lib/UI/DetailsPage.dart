import 'package:flutter/material.dart';
import 'package:newsapp/UI/WebviewPage.dart';
import 'package:share/share.dart';

class DetailsPage extends StatelessWidget{
  String urlimage ,   url ,   title ,   description ,   publishtime  ,  journalName;
  DetailsPage({Key key, @required this.urlimage, @required this.url , @required this.title , @required this.description , @required this.publishtime , @required this.journalName}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(onPressed: ()=>
            Share.share("${title} \n ${url} \n \n  يمكنك تحميل تطبيق FL NEWS ومتابعه كل الاخبار ")
          , child:Icon(Icons.share , color: Colors.white,) ,),
        body: Container(
            child: new SingleChildScrollView(
            child: new ConstrainedBox(
            constraints: new BoxConstraints(),
      child:
      Column(children: <Widget>[
          Container(
            width: double.infinity,
            child: Stack(
              children: <Widget>[
                Image.network(urlimage ,height: 300, fit: BoxFit.cover, width: double.infinity,) ,
                Container(
                  width: double.infinity,
                   height: 300,
                   color: Color.fromRGBO(0, 0, 0, 0.6),
                ),
                Column(
                  children: <Widget>[
                    SizedBox(height: 25,),
                    Container(
                         child:
                        IconButton(icon: Icon(Icons.arrow_back ,color: Colors.white,), onPressed:()=> Navigator.pop(context)),

                      alignment: Alignment(-1, 0),
                    ),
                    Container(
                      alignment: Alignment(0, 0),
                      child:

                      Padding(padding: EdgeInsets.all(10),

                        child: Center(
                          child:   Text(title , style: TextStyle(color: Colors.white , fontSize: 20 , ),textAlign: TextAlign.center, textDirection: TextDirection.rtl,),

                        )

                      ) ,
                    ),
                    SizedBox(height: 25,),

                    Container(
                      alignment: Alignment(0, 0),
                      child:

                      Padding(padding: EdgeInsets.all(5),

                          child: Center(
                            child:   Text("${journalName} || ${publishtime}" , style: TextStyle(color: Colors.white ,fontWeight: FontWeight.bold, fontSize: 12 , ),textAlign: TextAlign.center, textDirection: TextDirection.rtl,),

                          )

                      ) ,

                    ),
                    SizedBox(height: 20,)

                  ],
                )



              ],
            ),
          ),

          Container(child:
          Padding(padding: EdgeInsets.all(10) ,
          child:
            Card(
              elevation: 2,
              color: Colors.white,
              child:
                  Padding(padding: EdgeInsets.all(10) ,
                    child:
                        Column(
                          children: <Widget>[
                            Text(description , style:  TextStyle(fontSize: 17 , color: Colors.black, ),textDirection: TextDirection.rtl, textAlign: TextAlign.right,)
                            ,
                            SizedBox(height: 10,),

                            Text("أقرأ المزيد : " , style:  TextStyle(fontSize: 17 , color: Colors.black, ),textDirection: TextDirection.rtl, textAlign: TextAlign.right,)
                          ,
                            InkWell(
                              child: Text("${url}" , style:  TextStyle(fontSize: 15 , color: Colors.blue, ),textDirection: TextDirection.rtl, textAlign: TextAlign.center,)
                              , onTap: (){ Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => WebviewPage(url : url )),
                            );
                              debugPrint(url);
                              }
                          )

                          ],
                        )


                    ,)
              ,
            )
            ,),)


        ]
        ),
    ))
    ));
  }
}