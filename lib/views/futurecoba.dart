import 'dart:convert';
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatelessWidget {
  

  List <String> dummy=[
    "Fajr",
    "Terbit",
    "Duhur",
    "Ashar",
    "Terbenam",
    "Maghrib",
    "Isya",
  ];


  @override
  Widget build(BuildContext context){
    return Scaffold(
        backgroundColor: Colors.teal,
        body: SafeArea(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(30),
                  width: double.infinity,
                  height: 200,
                  child: Image.asset('assets/logo.png'),
                ),
                Container(
                  height: MediaQuery.of(context).size.height*0.5,
                  child: ListView.builder(
                      itemCount: dummy.length,
                      itemBuilder: (context, position){
                        return Container(
                          padding: EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 120,
                                child: Text(
                                  dummy[position],
                                  style: TextStyle(
                                    color: Colors.white)
                                ),
                              ),
                              Container(
                                width: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  color: Colors.white,
                                ),
                                child: Text(
                                  dummy[position],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.teal,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                  ),
                ),
                FlatButton.icon(
                  onPressed: (){},
                  icon: Icon(Icons.location_on,
                  color: Colors.white,),
                  label: Text("Mencari lokasi...",
                  style: TextStyle(
                    color: Colors.white
                  ),
                  ),
                ),
              ],
            ),
          )
        ),
    );
  }
  
  // Future<List<DataApi>>Kediri() async{
  //   var kota;
  //   final response = await http.get(Uri.parse("https://api.myquran.com/v1/sholat/kota/cari/$kota"));

  //   if(response.statusCode == 200) {
  //     final result = jsonDecode(response.body);
  //     return result.map((e) => DataApi.fromJson(e)).toList();
  //   } else {
  //     throw Exception("Failed to load movies!");
  //   }
  // }

}
