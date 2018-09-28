import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

// bool fetched = false ;

bool shelp;
var _help = new TextEditingController();
class Post extends StatefulWidget{
  String id;
  String from;
  DateTime dateTime;
String _content;
String _email;
String _animal;
var _location;
var _image;
String url;
String to;
var stream;
var day,month,year,hour,minute;
  Post(this.from,this.to,this._animal,this._content,this.dateTime,this._location,this._email,this.url);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new PostState(from,to,_animal,_content,dateTime,_location,_email,url);
  }

}
String did;
class PostState extends State<Post>{
  DateTime dateTime;
String from;
String _content;
String _email;
String _animal;
var _location;
var _image;
String url;
String to;
var stream;
var day,month,year,hour,minute;
  String _id;
  String _from;
  PostState(this.from,this.to,this._animal,this._content,this.dateTime,this._location,this._email,this.url);
  DocumentReference document = Firestore.instance.collection("post").document(did);
  Future _helper() async{
    DocumentReference ref = Firestore.instance.collection("request").document();
    Map<String,dynamic> data = <String,dynamic>{
                                  "to" : to,
                                  "postid" : _id,
                                  "from" :  _from,
                                  "request" : _help.text.toString(),
                                  "date" : DateTime.now(),
                                  "email" : _email,
                                  "animal" : _animal,
                                  "posttime" : "${dateTime.day}-${dateTime.month}-${dateTime.year},${dateTime.hour}:${dateTime.minute}",
                                   };
                                   ref.setData(data).whenComplete((){
                                     print("request sent");
                                     Navigator.of(context).pop();
                                   });
  }
  // void poster() {
  //   //   document.get().then((snapshot)async {
  //   //   print(snapshot.data['date']);
  //   //   print(snapshot.data['description']);
  //   //   setState(() {
  //   //   dateTime=snapshot.data['date'];
  //   //   day=dateTime.day;
  //   //   month=dateTime.month;
  //   //   year=dateTime.year;
  //   //   hour=dateTime.hour;
  //   //   minute=dateTime.minute;
  //   //   _content=snapshot.data['description'];
  //   //   _animal=snapshot.data['animal'];
  //   //   _location=snapshot.data['location'];
  //   //   to=snapshot.data['id'];
  //   //   _email=snapshot.data['email'];
  //   //   _image=snapshot.data['imagename'];
  //   //   url=snapshot.data['url'];      
  //   //         });
  //   //   print(url);
  //   //   print(to);
  //   //   fetched = true;
  //   //   print(_from);
  //   // });

  // document.get().then((snapshot){
  //   if(snapshot.exists){
  //     print("ref cor. ${snapshot['animal']}");
  //     setState(() {
  //     dateTime=snapshot['date'];
  //     day=dateTime.day;
  //     month=dateTime.month;
  //     year=dateTime.year;
  //     hour=dateTime.hour;
  //     minute=dateTime.minute;
  //     _content=snapshot['description'];
  //     _animal=snapshot['animal'];
  //     _location=snapshot['location'];
  //     to=snapshot['id'];
  //     _email=snapshot['email'];
  //     _image=snapshot['imagename'];
  //     url=snapshot['url'];      
  //           });
  //   }
  // }).whenComplete((){
  //   setState(() {});
  //   print("fetching complete");
  //   print(_animal);
  // });

  // }
  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      did=_id;
      print(_id);
      if(to.toString()==from.toString()){
        shelp=false;
      }else {
        shelp=true;
      }
      //  poster();
    }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Future.delayed(Duration(seconds: 4),(){    setState(() {});   });
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Details",style: new TextStyle(color: Colors.white)),
        elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0:0.0 ,
      ),
      body: new ListView(
        padding: const EdgeInsets.all(20.0),
        children: <Widget>[
          _animal==null ? new Container() :new Text("$_animal",style: new TextStyle(fontWeight: FontWeight.bold,fontSize: 30.0,color: Colors.grey),),
          new Padding(padding: const EdgeInsets.only(top: 20.0),),
          dateTime==null? new Container() : new Text("Added on:${dateTime.day}-${dateTime.month}-${dateTime.year},${dateTime.hour}:${dateTime.minute}"),
          new Padding(padding: const EdgeInsets.only(top: 20.0),),
          url==null ? new Container() : new Image.network(url),
          new Padding(padding: const EdgeInsets.only(top: 20.0),),
          _content==null? new Container() : new Text("$_content"),
          new Padding(padding: const EdgeInsets.only(top: 20.0),),
          _location!=null ? 
          // new Image.network(
          //   "https://maps.googleapis.com/maps/api/staticmap?center=${_location["latitude"]},${_location["longitude"]}&zoom=18&size=640x400&key=AIzaSyARjFlTh4-8KVvpsCyP63i7BMTKNseo57Y") 
           new Text("latitude: ${_location["latitude"]} \n longitude: ${_location["longitude"]}") : new Center( child: new CircularProgressIndicator( backgroundColor: Colors.orange,), ),
          new Padding(padding: const EdgeInsets.only(top: 20.0),),
          shelp ? new Text("Want to help ? Enter your message for the publisher .") : new Text(""),
          shelp ? new TextField(
             decoration: new InputDecoration(
               hintText: "Enter here..\n(Make sure to provide your phone number)"
             ),
             maxLines: 6,
             controller: _help,
          ): new Container(),
          new Padding(padding: const EdgeInsets.only(top: 20.0),),
          shelp ?
          Container(
           child: new MaterialButton(
              child: new Text("save life"),
              color: Colors.orange,
              textColor: Colors.white,
              onPressed: (){
                if(_help.text.toString()!=""){
                  showDialog(context: context,builder: (BuildContext context){
                  return new AlertDialog(
                    title: new Text("Contact Publisher?"),
                    content: new Text("We are sending your details to publisher"),
                    actions: <Widget>[
                      new MaterialButton(
                        child: new Text("Cancel"),
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                      ),
                      new MaterialButton(
                        child: new Text("Yes"),
                        onPressed: (){
                          Navigator.of(context).pop();
                          _helper();
                        },
                      ),
                    ],
                  );
                });
                }
                
              },
            ),
          ):new Container(),  
        ],
      ),
    );
  }

}

