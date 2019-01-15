import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/Model/NewsModel.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:newsapp/UI/DetailsPage.dart';

Future<NewsModel> fetchNews(String  cat) async {
  final response =
  await http.get('https://newsapi.org/v2/top-headlines?country=ae&category=${cat}&apiKey=92f2436407be44c6a15bbe1693fd95ee');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return NewsModel.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}
class NewsPage extends StatefulWidget{
  final String title , cat;

  // In the constructor, require a Todo
  NewsPage({Key key, @required this.title, @required this.cat}) : super(key: key);
  @override
  NewsPageState createState() => NewsPageState();
}

class NewsPageState extends State<NewsPage>{
  Future<NewsModel> newsModel;

  @override
  void initState() {
    super.initState();
    newsModel = fetchNews(widget.cat) ;
   }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
     appBar: AppBar( iconTheme: IconThemeData(color: Colors.black),title:Text( widget.title ,style: TextStyle(fontWeight: FontWeight.bold , fontSize: 22 ,color: Colors.black),),backgroundColor: Colors.white ,elevation: 3, centerTitle: true,),
    body: Container(
      child:
        FutureBuilder<NewsModel>(
          future: newsModel,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return
                LiquidPullToRefresh(
                  backgroundColor: Colors.white,
                    showChildOpacityTransition:false,

                     child:
                ListView.builder(
                  itemCount: snapshot.data.newsList.length,
                  itemBuilder: (context, index){

                    return CardNews(
                        snapshot.data.newsList[index].urlToImage,
                        snapshot.data.newsList[index].url,
                        snapshot.data.newsList[index].title,
                        snapshot.data.newsList[index].description,
                        snapshot.data.newsList[index].publishedAt,
                        snapshot.data.newsList[index].source.name,
                     );
             }
              ) ,onRefresh:()=> fetchNews(widget.cat));
            } else if (snapshot.hasError) {
              return Center(child: Text("عفوا تأكد من أتصال الانترنت  ${snapshot.error}  "),);
            }

            // By default, show a loading spinner
            return Center(child:CircularProgressIndicator() ,) ;
          },
        ),





    ),

    );
  }


  ///////////// CARD Custmization ///////////////
 Widget CardNews (String urlimage , String url , String title , String description , String publishtime  , String journalName ){

    return
      InkWell(
        onTap: ()=>
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DetailsPage(urlimage : _urlImage(urlimage) , url : url , title: title, description:_descriptionsub(description) , publishtime:publishtime , journalName:journalName )),
            )
        ,
        child:
      Container(
       child:
           Padding(
             padding: EdgeInsets.only(top: 5 , bottom: 5 , right: 10 , left: 10),
           child:
           Card(
              color: Colors.white,
              elevation: 2,
              child:
                  Column(
                    children: <Widget>[
                      Stack(
                        textDirection: TextDirection.rtl,
                        fit: StackFit.loose,
                        children: <Widget>[
                          FadeInImage( placeholder: new AssetImage(_there_is_image_or_not(_urlImage(urlimage)) ), image: NetworkImage(_urlImage(urlimage )) , height: 150, width: double.infinity, fit: BoxFit.cover, )
                          ,
                          Positioned( bottom: 0
                          ,
                            child:

                                Card(
                                    elevation: 2,
                                    color: Color.fromRGBO(0, 0, 0, 0.6),

                                    child:Padding(padding: EdgeInsets.all(5) ,
                                      child:  Text(journalName ,style: TextStyle(fontWeight: FontWeight.bold , color: Colors.white ,fontSize: 9 ) ),

                                    )

                                ),


                            )

                            ,


                        ],
                      )
                      ,

                     Padding(padding: EdgeInsets.only(left: 8 , right: 8 ,bottom: 10 ,top: 10),
                        child:
                        Text(title , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold , fontSize: 15 , ), textAlign: TextAlign.right,),

                      ),
                      Padding(padding: EdgeInsets.only(left: 8 , right: 8 , bottom: 10 ),
                        child:
                        Text(
                        _descriptionsub(description)
                        , style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.8)  , fontSize: 12 ,textBaseline: TextBaseline.alphabetic ,  ), textDirection: TextDirection.rtl, textAlign: TextAlign.right, ),

                      ),

                    ],
                  ),
            ),
    )
    ) ,

      );


 }

 String _descriptionsub(String description){

     if(description == null){
     return "" ;
   }else{
       if (description.length>100){
         return   description.substring(0,99)+"....";}
         else {
         return description;
       }

   }
    
    
 }



}

String _urlImage(String urlimage ) {
  if(urlimage == null){
    return "" ;

  }else{
    return urlimage;
  }
}

String _there_is_image_or_not(String _urlImage){
  if(_urlImage == ""){
    return "assets/images/noimage.png";

  }else{
    return "assets/images/loadingimg.gif";
  }

}


