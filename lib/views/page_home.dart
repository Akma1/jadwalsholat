import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:jadwalku/views/test.dart';

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List <String> dummy=[
    "Subuh",
    "Dzuhur",
    "Ashar",
    "Maghrib",
    "Isya",
  ];

  List<String> time=[
    '',
    '',
    '',
    '',
    '',
  
  ];

  void setTime(Praytime objPray){
    time[0] = objPray.jadwal!.subuh!;
    time[1] = objPray.jadwal!.dzuhur!;
    time[2] = objPray.jadwal!.ashar!;
    time[3] = objPray.jadwal!.maghrib!;
    time[4] = objPray.jadwal!.isya!;
    setState(() {
      
    });
  }
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
                                  time[position],
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
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const TestPage())).then((value){
                      setTime(value);
                    });
                  },
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
}
