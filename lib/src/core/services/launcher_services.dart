// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class LauncherServices {
//   static launchToMail(String email) async {
//     await launchUrl(Uri.parse('mailto:$email'));
//   }
//
//   static launchToSite(String site) async {
//     try{
//
//     await launchUrl(Uri.parse('$site'));
//     }catch (e){
//       EasyLoading.showError('حدث خطاء',dismissOnTap: true);
//     }
//   }
//
//   static launchToWhatsApp(String phone) async {
//     final url = Uri.parse("whatsapp://send?phone=$phone");
//     if (await canLaunchUrl(url)) {
//       await launchUrl(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//     // await launchUrl(Uri.parse('https://wa.me/$phone'));
//   }
//
//   static launchGoogleMaps(double lat, double long) async {
//     final url = Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$long');
//     // if (await canLaunchUrl(url)) {
//       await launchUrl(url);
//     // } else {
//     //   throw 'Could not launch $url';
//     // }
//   }
//
//   static launchToPhone(String phone) async {
//     await launchUrl(Uri.parse('tel:$phone'));
//   }
//
//   static void launchMapApp({required String lat, required String lng}) async {
//     var googleMapsLocationUrl =
//         'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
//
//     final encodedURl = Uri.encodeFull(googleMapsLocationUrl);
//
//     if (await canLaunch(encodedURl)) {
//       await launch(encodedURl);
//     } else {
//       throw 'Could not launch $encodedURl';
//     }
//   }
// }
