import 'dart:async';

import 'package:findhouse/helpers/properties_api.dart';
import 'package:findhouse/notifiers/home_searcher/propertiesNotifier.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    PropertyNotifier propertyNotifier = Provider.of<PropertyNotifier>(context);
    Future<void> _refreshList() async {
      getProperties(propertyNotifier);
    }

    Set<Marker> markers = {
      Marker(
        markerId: MarkerId(propertyNotifier.currentProperty.name!),
        position: LatLng(propertyNotifier.currentProperty.map!.latitude,
            propertyNotifier.currentProperty.map!.longitude),
        infoWindow: InfoWindow(
          title: propertyNotifier.currentProperty.name,
          snippet: propertyNotifier.currentProperty.location
        ),
      ),
    };
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Text("${propertyNotifier.currentProperty.name}"),
          Align(
          alignment: Alignment.topRight,
          child: Container(
            margin: const EdgeInsets.only(right: 24, top: 45),
            child: IconButton(
              icon: const Icon(
                Icons.close,
                color: Colors.grey,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width *
                    .97, // or use fixed size like 200
                height: MediaQuery.of(context).size.height * 1,
                child: GoogleMap(
                  padding: const EdgeInsets.all(25),
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                      target: LatLng(
                          propertyNotifier.currentProperty.map!.latitude,
                          propertyNotifier.currentProperty.map!.longitude),
                      zoom: 14),
                  myLocationEnabled: true,
                  markers: markers,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
  

  
