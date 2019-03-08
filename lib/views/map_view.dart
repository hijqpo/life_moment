import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget{
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
 GoogleMapController mapController;
 MapType _currentMapType = MapType.normal;

 final LatLng _center = const LatLng(22.48, 114.07);

 void _onMapCreated(GoogleMapController controller) {
   mapController = controller;
 }

 void _onMapTypeButtonPressed() {
   if (_currentMapType == MapType.normal) {
     mapController.updateMapOptions(
       GoogleMapOptions(mapType: MapType.satellite),
     );
     _currentMapType = MapType.satellite;
   } else {
     mapController.updateMapOptions(
       GoogleMapOptions(mapType: MapType.normal),
     );
     _currentMapType = MapType.normal;
   }
 }

 void _onAddMarkerButtonPressed() {
   mapController.addMarker(
     MarkerOptions(
       position: LatLng(
         mapController.cameraPosition.target.latitude,
         mapController.cameraPosition.target.longitude,
       ),
       infoWindowText: InfoWindowText('Random Place', '5 Star Rating'),
       icon: BitmapDescriptor.defaultMarker,
     ),
   );
 }

 @override
 Widget build(BuildContext context) {
   return Stack(
         children: <Widget>[
           GoogleMap(
             onMapCreated: _onMapCreated,
             options: GoogleMapOptions(
               trackCameraPosition: true,
               cameraPosition: CameraPosition(
                 target: _center,
                 zoom: 11.5,
               ),
             ),
           ),
           Padding(
             padding: const EdgeInsets.all(16.0),
             child: Align(
               alignment: Alignment.topRight,
               child: Column(
                 children: <Widget>[
                   FloatingActionButton(
                     onPressed: _onMapTypeButtonPressed,
                     materialTapTargetSize: MaterialTapTargetSize.padded,
                     backgroundColor: Colors.green,
                     child: const Icon(Icons.map, size: 36.0),
                   ),
                   const SizedBox(height: 16.0),
                   FloatingActionButton(
                     onPressed: _onAddMarkerButtonPressed,
                     materialTapTargetSize: MaterialTapTargetSize.padded,
                     backgroundColor: Colors.green,
                     child: const Icon(Icons.add_location, size: 36.0),
                   ),
                 ],
               ),
             ),
           ),
         ],
   );
 }
}