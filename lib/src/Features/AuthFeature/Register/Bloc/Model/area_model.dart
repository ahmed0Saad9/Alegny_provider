import 'package:Alegny_provider/src/Features/AuthFeature/Register/Bloc/Model/nationality_model.dart';

class AreaModel {
  final int id;
  final String name;
  final CityModel city;

  AreaModel({
    required this.id,
    required this.name,
    required this.city,
  });

  factory AreaModel.fromJson(Map<String, dynamic> json) {
    return AreaModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      city: CityModel.fromJson(json['city']),
    );
  }
}

//
// {
// "data": {
// "id": 1,
// "name": "المرج",
//   "city": {
//     "id": 1,
//     "name": "القاهرة"
//    }
// }
// }
