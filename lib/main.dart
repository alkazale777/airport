import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_direct/deatils.dart';

import 'airportModel.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Airports'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<AirportModel>> futureExamples;


  @override
  void initState() {

    futureExamples = fetchExample();

  }
  Future<List<AirportModel>> fetchExample() async {
    final response =
    await http.get('https://api.qantas.com/flight/refData/airport');
    print(response.bodyBytes.toString());
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return airportModelFromJson(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }



  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body:   FutureBuilder<List<AirportModel>>(
        future: futureExamples,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Widget> list = [];


            snapshot.data.forEach((f) {

              list.add(
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => details(name: f.airportName, subtitle: f.country.countryName, code: f.airportCode , lat: f.location.latitude
                        ,lan: f.location.longitude,City: f.city.cityName, Timezone: f.city.timeZoneName,)),
                    );
                  },

                  child: Card(
                  elevation: 5,
                  child: ListTile(
                    leading: Icon(Icons.airplanemode_on),
                    title: Text(f.airportName),
                    subtitle: Text(f.country.countryName),
                    trailing: Icon(Icons.arrow_forward_ios_sharp),
                  ),
              ),
                ),);

            });

            return Padding(
              padding: const EdgeInsets.only(top: 8),
              child: SingleChildScrollView(
                child: Column(
                  children: list,
                ),
              ),
            );


          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          // By default, show a loading spinner.
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  child: CircularProgressIndicator(),
                  width: 60,
                  height: 60,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('جاري التحميل ..'),
                )
              ],
            ),
          );},
      ),

    );
  }
}
