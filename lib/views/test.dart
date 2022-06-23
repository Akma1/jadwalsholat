import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import './page_home.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
  
}

class _TestPageState extends State<TestPage> {
  List<dynamic> _listAddress = [];
  Praytime praytime = Praytime();
  bool isLoading = false;
  @override
  void initState() {
    getAddress();
    // TODO: implement initState
    super.initState();
  }

  getAddress() async {
    setState(() {
      isLoading = true;
    });
    try {
      var res = await Dio().get('https://api.myquran.com/v1/sholat/kota/semua');
      _listAddress = res.data as List<dynamic>;

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      throw e;
    }
  }

  getSchedule(id) async {
    setState(() {
      isLoading = true;
    });
    String yearNow = DateTime.now().year.toString();
    String monthNow = DateTime.now().month.toString();
    String dateNow = DateTime.now().day.toString();
    try {
      var res = await Dio().get(
          'https://api.myquran.com/v1/sholat/jadwal/$id/$yearNow/$monthNow/$dateNow');
      var body = res.data;
      praytime = Praytime.fromJson(body['data']);
      print(praytime.jadwal!.tanggal);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      throw e;
    }
  }

  SetTime(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Lokasi'),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.grey.shade200,
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 50,
            child: TextField(
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Cari lokasi'),
            ),
          ),
          Expanded(
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView(
                      children: _listAddress
                          .map((e) => ListTile(
                                onTap: () async {
                                  await getSchedule(e['id']);
                                  Navigator.of(context).pop(praytime);},
                                trailing: Icon(Icons.keyboard_arrow_right),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(e['id']),
                                    Text(e['lokasi']),
                                  ],
                                ),
                              ))
                          .toList(),
                    ))
        ],
      ),
    );
  }
}

class Praytime {
  Praytime({
    this.jadwal,
  });

  Jadwal? jadwal;

  factory Praytime.fromJson(Map<String, dynamic> json) => Praytime(
        jadwal: json["jadwal"] == null ? null : Jadwal.fromJson(json["jadwal"]),
      );
}

class Jadwal {
  Jadwal({
    this.tanggal,
    this.imsak,
    this.subuh,
    this.terbit,
    this.dhuha,
    this.dzuhur,
    this.ashar,
    this.maghrib,
    this.isya,
    this.date,
  });

  String? tanggal;
  String? imsak;
  String? subuh;
  String? terbit;
  String? dhuha;
  String? dzuhur;
  String? ashar;
  String? maghrib;
  String? isya;
  DateTime? date;

  factory Jadwal.fromJson(Map<String, dynamic> json) => Jadwal(
        tanggal: json["tanggal"] == null ? null : json["tanggal"],
        imsak: json["imsak"] == null ? null : json["imsak"],
        subuh: json["subuh"] == null ? null : json["subuh"],
        terbit: json["terbit"] == null ? null : json["terbit"],
        dhuha: json["dhuha"] == null ? null : json["dhuha"],
        dzuhur: json["dzuhur"] == null ? null : json["dzuhur"],
        ashar: json["ashar"] == null ? null : json["ashar"],
        maghrib: json["maghrib"] == null ? null : json["maghrib"],
        isya: json["isya"] == null ? null : json["isya"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
      );
}
