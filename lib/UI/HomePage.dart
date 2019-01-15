import 'package:flutter/material.dart';
import 'package:newsapp/Model/Category.dart';
import 'package:newsapp/UI/NewsPage.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:share/share.dart';

class HomePage extends StatefulWidget{


  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage>{
  var drawersize = 17.0;
 static var imageList =["assets/images/business.jpeg" , "assets/images/sports.jpeg", "assets/images/entertainment.jpeg" , "assets/images/scince.jpeg" , "assets/images/tech.jpeg"];
  static var title =["business" , "sports", "entertainment" , "science" , "technology"];
  static var catname =["business" , "sports", "entertainment" , "science" , "technology"];

  final listCat = List<Category>.generate(imageList.length, (i) => Category(imageList[i], title[i], catname[i]));



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 300) / 2;
    final double itemWidth = size.width / 2;
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title:Text("F NEWS" , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 22 ,color: Colors.black),), iconTheme: IconThemeData(color: Colors.black),backgroundColor: Colors.white ,elevation: 3, centerTitle: true,),
      body: Container(
        child:
        GridView.count(
          crossAxisCount: 2,
          childAspectRatio: (itemWidth / itemHeight),
          controller: new ScrollController(keepScrollOffset: false),
          shrinkWrap: true,
          padding: EdgeInsets.all(10),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          scrollDirection: Axis.vertical,
          children: List.generate(listCat.length, (index) {
            return Center(
              child:
                    _CardView(listCat[index].image , listCat[index].titles , listCat[index].cat),


            );

          } ))
        ,
      ),



      drawer:Drawer(
        elevation: 3,
        child: new ListView(
          children: <Widget>[
            DrawerHeader(

              child: Container(
                child: Center(
                  child: Text("FLUTTER NEWS APP"  ,style: TextStyle(fontSize: 30 , fontWeight: FontWeight.bold , color: Colors.black),),
                ),
                color: Colors.white,
               ),
              padding: EdgeInsets.all(0),

            ),

            ListTile(
              title: Container(
                child: Text("الرئيسية" , style: TextStyle(color: Colors.black45, fontSize: drawersize , fontWeight: FontWeight.bold),textAlign: TextAlign.right,),

              ),
              onTap: ()=> Navigator.pop(context),
            ),


            ListTile(
              title: Container(
                child: Text("مشاركة التطبيق" , style: TextStyle(color: Colors.black45, fontSize: drawersize , fontWeight: FontWeight.bold),textAlign: TextAlign.right,),

              ),
              onTap: (){
                Share.share('Download this app Fl News');
                Navigator.pop(context);

              }
              ,
            ),
            ListTile(

                title: Container(
                  child: Text("أرسل لنا ملاحظاتك" , style: TextStyle(color: Colors.black45, fontSize: drawersize , fontWeight: FontWeight.bold),textAlign: TextAlign.right,),

                ),
                onTap: ()  {
                  send("أرسل ملاحظاتك");
                  Navigator.pop(context);
                }
            ),

            ListTile(
                title: Container(
                  child: Text("عن التطبيق" , style: TextStyle(color: Colors.black45, fontSize: drawersize , fontWeight: FontWeight.
                  bold),textAlign: TextAlign.right,),

                ),
                onTap: (){

                  Navigator.pop(context);
                  showDialog(context: context, child:
                  new AlertDialog(
                    title: new Text("قم بقراءة كل الاخبار في العديد من التصنيفات كالرياضة و الاعمال و الفن و التكنولوجيا " ,
                      textAlign: TextAlign.right,style: TextStyle(fontSize: 13 , color: Colors.black , fontWeight: FontWeight.bold),),

                  )
                  );
                }
            ),

          ],
        ),
      ),
    );




  }
  Widget _CardView(String image , String title , String cat){
    return Container(
      height: 300,
       color: Colors.white,
      
      child:
       InkWell(
         
         child:
              Card(
                color: Colors.white,
                elevation: 5,
                child: Stack(
                  children: <Widget>[
                    Image.asset(image , width: double.infinity,  fit: BoxFit.cover, height: 300, ) ,
                    Container(height: 300, width: double.infinity, color: Color.fromRGBO(0, 0, 0, 0.5),),
                    Center(child: Text(title ,style: TextStyle(color: Colors.white ,fontSize: 20 , fontWeight: FontWeight.bold ,),), )
                  ],
                ),
              )  ,
         onTap:()=>
         Navigator.push(
           context,
           MaterialPageRoute(builder: (context) => NewsPage(title : title , cat : cat )),
         )
         ,
       ),
    );
  }

 final GlobalKey<ScaffoldState> _scafoldKey = new GlobalKey<ScaffoldState>();
 // Platform messages are asynchronous, so we initialize in an async method.
 Future<void> send(msg) async {
   // Platform messages may fail, so we use a try/catch PlatformException.
   final MailOptions mailOptions = MailOptions(
     subject: msg,
     recipients: ['zeyadelosherey@gmail.com'],

     // bccRecipients: ['other@example.com'],


   );

   String platformResponse;

   try {
     await FlutterMailer.send(mailOptions);
     platformResponse = 'success';
   } catch (error) {
     platformResponse = error.toString();
   }

   // If the widget was removed from the tree while the asynchronous platform
   // message was in flight, we want to discard the reply rather than calling
   // setState to update our non-existent appearance.

 }

}