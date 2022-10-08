import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prayer/location/geo_location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}




class _MapScreenState extends State<MapScreen> {


  @override
  void initState() {
    getMyCurrentLocationService();
    super.initState();
  }

  static Position? position;

 Future<void> getMyCurrentLocationService() async {
    await geoLocation.getPTLocation();


    position = await geoLocation.getPTLocation().whenComplete(() {
      return setState(() {});
    });
  }


  
  final Completer<GoogleMapController> _mapController = Completer();

  static final CameraPosition _myCurrentLocationCameraPosition = CameraPosition(
    bearing: 0.0,
    target: LatLng(position!.latitude, position!.longitude),
    tilt: 0.0,
    zoom: 17,
  );

 



  Widget buildMap() {
    return GoogleMap(
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      initialCameraPosition: _myCurrentLocationCameraPosition,
      onMapCreated: (GoogleMapController controller) {
        _mapController.complete(controller);
      },
    );
  }


    Future<void> _goToMyCurrentLocation() async{
  final GoogleMapController controller = await _mapController.future;
  controller.animateCamera(CameraUpdate.newCameraPosition(_myCurrentLocationCameraPosition));
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          position != null
              ? buildMap()
              : const Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                )
        ],
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 8, 30),
        child: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () => _goToMyCurrentLocation(),
          child: const Icon(
            Icons.place,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

   
}
