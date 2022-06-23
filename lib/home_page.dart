import 'package:flutter/material.dart';
import 'package:jadwalku/location_page.dart';
import 'package:jadwalku/notification_helper.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> dummy = [
    "Subuh",
    "Dzuhur",
    "Ashar",
    "Maghrib",
    "Isya",
  ];

  List<String> time = [
    '--:--',
    '--:--',
    '--:--',
    '--:--',
    '--:--',
  ];

  String location = '-';
  bool isCheck = false;

  void setTime(Praytime objPray) {
    time[0] = objPray.jadwal!.subuh!;
    time[1] = objPray.jadwal!.dzuhur!;
    time[2] = objPray.jadwal!.ashar!;
    time[3] = objPray.jadwal!.maghrib!;
    time[4] = objPray.jadwal!.isya!;
    location = objPray.lokasi!;
    NotificationHelper().cancelAll();
    isCheck = false;

    setState(() {});
  }

  Future<void>? setNotif() {
    for (var i = 0; i < time.length; i++) {
      DateFormat dateFormat = DateFormat("yyyy-MM-dd");
      DateFormat dateFormatNow = DateFormat('yyyy-MM-dd HH:mm:ss');
      var _date = dateFormat.format(DateTime.now());
      var _dateNow = dateFormatNow.format(DateTime.now());
      DateTime dateTime = DateTime.parse('$_date ${time[i]}:00');
      DateTime dateTimeNow = DateTime.parse(_dateNow);

      if (dateTimeNow.isBefore(dateTime)) {
        print(dummy[i]);
        var sec = dateTime.difference(dateTimeNow).inSeconds;
        print(sec);

        NotificationHelper().scheduledNotification(
            timeSec: sec, id: i, sound: 'exsubuh', title: dummy[i]);
      }
    }
    isCheck = true;
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Set notif sukses"), duration: Duration(seconds: 1)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.teal.shade300, Colors.teal.shade600])),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              height: 200,
              child: Image.asset(
                'assets/logo.png',
                color: Colors.white,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('dd MMM yyyy').format(DateTime.now()),
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Text(
                      'Lokasi : $location',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 250,
              child: ListView.builder(
                  itemCount: dummy.length,
                  itemBuilder: (context, position) {
                    return Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 120,
                            child: Text(dummy[position],
                                style: TextStyle(color: Colors.white)),
                          ),

                          Container(
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              color: Colors.white,
                            ),
                            child: Text(
                              time[position],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.teal,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          // Text('time[position]')
                        ],
                      ),
                    );
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.cyan, shape: StadiumBorder()),
                    onPressed: () {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LocationPage()))
                          .then((value) {
                        if (value == null) return;
                        Praytime temp = value as Praytime;

                        setTime(temp);
                      });
                    },
                    child: Text('Cari Lokasi')),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.lightGreen, shape: StadiumBorder()),
                    onPressed: isCheck
                        ? null
                        : () {
                            if (time[0] == '--:--') {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                    "Silahkan pilih lokasi terlebih dahulu"),
                                duration: Duration(seconds: 1),
                              ));
                            } else {
                              setNotif();
                            }
                          },
                    child: Text('Set Notif')),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
