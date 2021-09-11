import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';


class details extends StatefulWidget {
  details({Key key, this.name, this.subtitle, this.code, this.lat, this.lan, this.City, this.Timezone}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String name;
  final String subtitle;
  final String code;
  final double lat;
  final double lan;
  final String City;
  final String Timezone;

  @override
  _detailsState createState() => _detailsState();
}

class _detailsState extends State<details> {
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
          title: Text("details"),
          automaticallyImplyLeading: false,

        ),
        body: Center(
            child: Column(
          children: [
            Card(
              elevation: 5,
              child: ListTile(
                leading: Icon(Icons.airplanemode_on),
                title: Text("airport : "+widget.name),
                subtitle: Column(
                  children: [
                    Text("Country : " + widget.subtitle),
                    Text("TimeZone : " + widget.Timezone),
                    Text("City : " + widget.City),
                  ],
                ),
                trailing: Text(widget.code),
              ),
            ),

            Container(
              height: 300,
              child: PlatformMap(
                initialCameraPosition: CameraPosition(
                  target:  LatLng(widget.lat, widget.lan),
                  zoom: 10.0,
                ),
                markers: Set<Marker>.of(
                  [
                    Marker(
                      markerId: MarkerId('marker_1'),
                      position: LatLng(widget.lat, widget.lan),
                      consumeTapEvents: true,
                      infoWindow: InfoWindow(
                        title: 'PlatformMarker',
                        snippet: "Hi I'm a Platform Marker",
                      ),
                      onTap: () {
                        print("Marker tapped");
                      },
                    ),
                  ],
                ),
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                onTap: (location) => print('onTap: $location'),
                onCameraMove: (cameraUpdate) => print('onCameraMove: $cameraUpdate'),
                compassEnabled: true,
                onMapCreated: (controller) {

                },
              ),
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Back"),
            )

          ],
        )));
  }
}

