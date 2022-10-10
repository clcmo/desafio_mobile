import 'package:challenge/assets/default.dart';
import 'package:challenge/services/auth_services.dart';
import 'package:challenge/services/locations.dart' as locations;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Map<String, Marker> _markers = {};

  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    setState(() {
      _markers.clear();
      for (final office in googleOffices.offices) {
        final marker = Marker(
          markerId: MarkerId(office.name),
          position: LatLng(office.lat, office.lng),
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
          ),
        );
        _markers[office.name] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Minha Localização',
              style: TextStyle(fontFamily: 'Kollektif')),
          backgroundColor: Default().color,
          actions: [
            IconButton(
              onPressed: () => AuthService().logout(),
              icon: const Icon(Icons.logout),
            )
          ],
        ),
        body: Column(children: [
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 600,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: const CameraPosition(
                  target: LatLng(-300, 90),
                  zoom: 2,
                ),
                markers: _markers.values.toSet(),
              )),
        ]),
      );
}
