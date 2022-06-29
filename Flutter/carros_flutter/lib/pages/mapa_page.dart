import 'dart:async';

import 'package:carrosflutter/models/carro.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaPage extends StatelessWidget {
  final Carro carro;
  MapaPage(this.carro);

  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(carro.nome),
        ),
        body: _body());
  }

  _body() {
    return Container(
      child: GoogleMap(
        mapType: MapType.normal,
        zoomGesturesEnabled: true,
        initialCameraPosition: CameraPosition(
          target: carro.laLng(),
          zoom: 17,
        ),
        markers: Set.of(_getMarkers()),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }

  List<Marker> _getMarkers() {
    return [
      Marker(
        markerId: MarkerId("1"),
        position: carro.laLng(),
        infoWindow: InfoWindow(
          title: carro.nome,
          snippet: "Fábrica da ${carro.nome}",
          onTap: () {
            print("Clicou na janela");
          },
        ),
        onTap: () {
          print("Clicou no marcador");
        },
      )
    ];
  }
}
