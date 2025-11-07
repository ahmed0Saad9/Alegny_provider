// maps_location_picker_screen.dart
import 'package:Alegny_provider/src/Features/AddServiceFeature/Bloc/controller/add_service_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../GeneralWidget/Widgets/Appbars/app_bars.dart';

class MapsLocationPickerScreen extends StatefulWidget {
  final int branchIndex;
  final double? initialLat;
  final double? initialLng;

  const MapsLocationPickerScreen({
    Key? key,
    required this.branchIndex,
    this.initialLat,
    this.initialLng,
  }) : super(key: key);

  @override
  State<MapsLocationPickerScreen> createState() =>
      _MapsLocationPickerScreenState();
}

class _MapsLocationPickerScreenState extends State<MapsLocationPickerScreen> {
  late GoogleMapController mapController;
  LatLng? _selectedLocation;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    // Set initial location if provided
    if (widget.initialLat != null && widget.initialLng != null) {
      _selectedLocation = LatLng(widget.initialLat!, widget.initialLng!);
      _addMarker(_selectedLocation!);
    }
  }

  void _addMarker(LatLng position) {
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
          markerId: const MarkerId('selected_location'),
          position: position,
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: const InfoWindow(title: 'Selected Location'),
        ),
      );
      _selectedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.appBarBack(
        title: 'Select_location',
      ),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
        initialCameraPosition: CameraPosition(
          target: _selectedLocation ??
              const LatLng(30.0444, 31.2357), // Cairo coordinates as default
          zoom: 12,
        ),
        markers: _markers,
        onTap: (LatLng position) {
          _addMarker(position);
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_selectedLocation != null) {
            final controller = Get.find<AddServiceController>();
            controller.setBranchLocation(
              widget.branchIndex,
              _selectedLocation!.latitude,
              _selectedLocation!.longitude,
            );
            Get.back();
          }
        },
        backgroundColor: _selectedLocation != null ? Colors.green : Colors.grey,
        child: const Icon(Icons.check),
      ),
    );
  }
}
