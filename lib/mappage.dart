import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';



class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {



  final Set<Marker> _markers = {};

  LatLng _lastMapPosition = _center;
  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  static const LatLng _center = const LatLng(45.521563, -122.677433);

  Completer<GoogleMapController> _mapcontroller = Completer();

  void _onMapCreated(GoogleMapController controller) {
    _mapcontroller.complete(controller);
  }

  MapType _currentMapType = MapType.normal;

  double lat = 0.0;
  double long = 0.0;

  late CameraPosition aposition;

  liveCoordinates() async {
    Geolocator.getPositionStream().listen((Position position) {
      setState(() {
        lat = position.latitude;
        long = position.longitude;
        aposition = CameraPosition(
          target: LatLng(lat, long),
        );
      });
    });
  }

  @override
  void initState() {
    super.initState();
    Permission.location.request();
    liveCoordinates();
    aposition = CameraPosition(
      target: LatLng(lat, long),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    Map<String, dynamic> alldetail11 =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title:  Text(
            "${alldetail11['Cname']}",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
          elevation: 0,
         leading: GestureDetector(
             onTap: () {
               setState(() {
                 Navigator.pop(context);
               });
             },
             child: Icon(Icons.arrow_back,color: Colors.white,)),
        ),
        body: Stack(
          children: [
            GoogleMap(
            onMapCreated: _onMapCreated,
              initialCameraPosition: aposition,
              mapType: _currentMapType,
              markers: _markers,
              zoomControlsEnabled: false,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              // onCameraMove: _onCameraMove,
          ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topRight,
                child: FloatingActionButton(
                  onPressed:  _onMapTypeButtonPressed,
                      // print('button pressed'),
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                  backgroundColor: Colors.green,
                  child: const Icon(Icons.map, size: 36.0),
                ),
              ),
            ),
         Column(
           mainAxisAlignment: MainAxisAlignment.end,
           children: [
             Padding(
               padding: const EdgeInsets.only(left: 230,right: 20,bottom: 20),
               child: FloatingActionButton.extended(
                    onPressed: () async {
                      liveCoordinates();
                      setState(() {
                        aposition = CameraPosition(
                          target: LatLng(alldetail11['lat'], alldetail11['log']),
                          zoom: 20,
                        );
                      });
                      final GoogleMapController controller = await _mapcontroller.future;
                      controller.animateCamera(CameraUpdate.newCameraPosition(aposition));
                    },
                    label: const Text('Location'),
                    icon: const Icon(Icons.gps_fixed_outlined),
                  ),
             ),
           ],
         ),
            // FloatingActionButton(
            //   onPressed: _onAddMarkerButtonPressed,
            //   materialTapTargetSize: MaterialTapTargetSize.padded,
            //   backgroundColor: Colors.green,
            //   child: const Icon(Icons.add_location, size: 36.0),
            // ),
          ],
        ),

      ),
    );
  }
  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.hybrid
          : MapType.normal;
    });
  }
  // void _onAddMarkerButtonPressed() {
  //   setState(() {
  //     _markers.add(Marker(
  //       // This marker id can be anything that uniquely identifies each marker.
  //       markerId: MarkerId(_lastMapPosition.toString()),
  //       position: _lastMapPosition,
  //       infoWindow: InfoWindow(
  //         title: 'Really cool place',
  //         snippet: '5 Star Rating',
  //       ),
  //       icon: BitmapDescriptor.defaultMarker,
  //     ));
  //   });
  // }
}
