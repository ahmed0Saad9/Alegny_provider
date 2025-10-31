// import 'package:Alegny_provider/src/core/constants/app_assets.dart';
// import 'package:Alegny_provider/src/core/constants/color_constants.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class MapWidget extends StatefulWidget {
//   final double lat;
//   final double lng;
//   final double height;
//   final VoidCallback onTap;
//   const MapWidget({Key? key, required this.lat, required this.lng,  this.height=64, required this.onTap}) : super(key: key);
//
//   @override
//   State<MapWidget> createState() => _MapWidgetState();
// }
//
// class _MapWidgetState extends State<MapWidget> {
//   late GoogleMapController mapController;
//   late CameraPosition initialCameraPosition;
//    Set<Marker> markers={};
//   bool _loadingMap = true;
//
//   @override
//   void initState() {
//     printDM(widget.lat.toString());
//     printDM(widget.lng.toString());
//     initialCameraPosition = CameraPosition(
//       target: LatLng(widget.lat, widget.lng),
//       zoom: 18,
//     );
//     Future.delayed(Duration(seconds: 0), () async {
//       final _image = await BitmapDescriptor.fromAssetImage(
//           ImageConfiguration(size: Size(24, 24)), 'assets/icons/circle-marker.png');
//       markers = {
//         Marker(
//           markerId: MarkerId('id'),
//           position: LatLng(widget.lat, widget.lng),
//           icon: _image,
//         ),
//       };
//     });
//     setState(() {
//       _loadingMap = false;
//       print('3333333333333');
//     });
//
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     mapController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: widget.height.h,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16.r),
//         color: _loadingMap ? AppColors.lineGray.withOpacity(.5) : null,
//       ),
//       child: _loadingMap
//           ? null
//           : ClipRRect(
//               borderRadius: BorderRadius.only(topRight: Radius.circular( 16.r),topLeft: Radius.circular( 16.r)),
//               child: GoogleMap(
//                 onTap: (argument) {
//                   widget.onTap();
//                   // MapsLauncher.launchCoordinates(widget.lat, widget.lng);
//                 },
//                 zoomControlsEnabled: false,
//                 mapToolbarEnabled: false,
//                 zoomGesturesEnabled: false,
//                 myLocationButtonEnabled: false,
//                 initialCameraPosition: initialCameraPosition,
//                 onMapCreated: (GoogleMapController controller) {
//                   mapController = controller;
//                   setState(() {});
//                   //print('55555555555555555555555');
//                 },
//                 markers:markers,
//               ),
//             ),
//     );
//   }
//
//   // _onViewLocationTap() async {
//   //   String destination = widget.lat.toString() +
//   //       ',' +
//   //       widget.lng.toString();
//   //   if ( Platform.isAndroid) {
//   //     final AndroidIntent intent = new AndroidIntent(
//   //         action: 'action_view',
//   //         data: Uri.encodeFull("https://www.google.com/maps/dir/?api=1" +
//   //             "&destination=" +
//   //             destination +
//   //             "&travelmode=driving&dir_action=navigate"),
//   //         package: 'com.google.android.apps.maps');
//   //     intent.launch();
//   //   } else {
//   //     String url = "https://www.google.com/maps/dir/?api=1&" +
//   //         "&destination=" +
//   //         destination +
//   //         "&travelmode=driving&dir_action=navigate";
//   //     if (await canLaunch(url)) {
//   //       await launch(url);
//   //     } else {
//   //       throw 'Could not launch $url';
//   //     }
//   //   }
//   // }
// }
