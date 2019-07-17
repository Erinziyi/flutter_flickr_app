import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'image_model.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget>createState(){
    return AppState();
  }
}

class AppState extends State<App> {
List<ImageModel>images =[];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flitter Image'),
        ),
        body: images.length == 0 ? loadingIndicator() :imageList(),
      ),


    );
  }

  Widget loadingIndicator(){
    getImages();
    return Center(child: CircularProgressIndicator(),);
  }

  Widget imageList(){
    return ListView.builder(
      itemCount: images.length,
      itemBuilder: (context,index){
       final imageData = images[index];
       return Card(
         margin: EdgeInsets.all(10.0),
         elevation: 8.0,
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
         child: Column(
           children: <Widget>[
             ClipRRect(borderRadius:BorderRadius.only(
               topLeft: Radius.circular(8.0),
               topRight: Radius.circular(8.0),
             ),
               child: Image.network(imageData.url,height: 180.0,width:440,fit:BoxFit.fill),
             ),
             Container(
               padding: EdgeInsets.only(bottom:10.0),

            ),
             Padding(
               
               child: Text(imageData.title,
                 style: TextStyle(
                   color:Colors.black87,
                   fontSize: 16.0),
                  textAlign: TextAlign.center,
                 overflow: TextOverflow.clip,
               ),
               padding: EdgeInsets.all(20.0),
             )
           ],
         ),

       );
      },

    );
  }

  Future<void>getImages()async{
    var response = await get("https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1");
    if (response.statusCode == 200){
      final map = json.decode(response.body);
      final imagesJson = map ["items"];
      images = [];
      imagesJson.forEach((image){
        final imageM =ImageModel.fromJson(image);
        setState(() {
          images.add(imageM);
          //images.insert(0,imagesM);

        });

      });

    }

  }


}
