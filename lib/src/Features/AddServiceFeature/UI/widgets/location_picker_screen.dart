// // maps_location_picker_screen.dart
// import 'package:Alegny_provider/src/Features/AddServiceFeature/Bloc/controller/add_service_controller.dart';
// import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
// import 'package:Alegny_provider/src/core/constants/color_constants.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// import '../../../../GeneralWidget/Widgets/Appbars/app_bars.dart';
//
// class MapsLocationPickerScreen extends StatefulWidget {
//   final int branchIndex;
//   final double? initialLat;
//   final double? initialLng;
//
//   const MapsLocationPickerScreen({
//     Key? key,
//     required this.branchIndex,
//     this.initialLat,
//     this.initialLng,
//   }) : super(key: key);
//
//   @override
//   State<MapsLocationPickerScreen> createState() =>
//       _MapsLocationPickerScreenState();
// }
//
// class _MapsLocationPickerScreenState extends State<MapsLocationPickerScreen> {
//   late GoogleMapController mapController;
//   LatLng? _selectedLocation;
//   final Set<Marker> _markers = {};
//   bool _isMapReady = false;
//
//   @override
//   void initState() {
//     super.initState();
//     // Set initial location if provided
//     if (widget.initialLat != null && widget.initialLng != null) {
//       _selectedLocation = LatLng(widget.initialLat!, widget.initialLng!);
//       _addMarker(_selectedLocation!);
//     }
//   }
//
//   void _addMarker(LatLng position) {
//     setState(() {
//       _markers.clear();
//       _markers.add(
//         Marker(
//           markerId: const MarkerId('selected_location'),
//           position: position,
//           icon: BitmapDescriptor.defaultMarker,
//           infoWindow: const InfoWindow(title: 'Selected Location'),
//         ),
//       );
//       _selectedLocation = position;
//     });
//   }
//
//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//     setState(() {
//       _isMapReady = true;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBars.appBarBack(
//         title: 'Select_location',
//       ),
//       body: GoogleMap(
//         onMapCreated: _onMapCreated,
//         initialCameraPosition: CameraPosition(
//           target: _selectedLocation ??
//               const LatLng(30.0444, 31.2357), // Cairo coordinates as fallback
//           zoom: 12,
//         ),
//         markers: _markers,
//         onTap: (LatLng position) {
//           _addMarker(position);
//         },
//         myLocationEnabled: true,
//         myLocationButtonEnabled: true,
//         compassEnabled: true,
//         zoomControlsEnabled:
//             false, // Built-in controls can interfere with custom UI
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           if (_selectedLocation != null) {
//             final controller = Get.find<AddServiceController>();
//             controller.setBranchLocation(
//               widget.branchIndex,
//               _selectedLocation!.latitude,
//               _selectedLocation!.longitude,
//             );
//             Get.back();
//           } else {
//             // Show error if no location selected
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(
//                 content: CustomTextL(
//                   'Please_select_a_location_on_the_map',
//                   color: AppColors.titleWhite,
//                 ),
//                 backgroundColor: Colors.red,
//               ),
//             );
//           }
//         },
//         backgroundColor: _selectedLocation != null ? Colors.green : Colors.grey,
//         child: const Icon(Icons.check),
//       ),
//     );
//   }
// }
