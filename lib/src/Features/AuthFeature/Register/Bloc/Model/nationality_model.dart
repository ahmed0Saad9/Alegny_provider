import 'package:equatable/equatable.dart';

class CountryModel extends Equatable {
  final int id;
  final String title;
  final String flag;
  final String iso2;

  const CountryModel({
    required this.id,
    required this.title,
    required this.flag,
    required this.iso2,
  });

  factory CountryModel.fromMap(Map<String, dynamic> json) {
    return CountryModel(
      id: json['id'] ?? -1,
      title: json['name'] ?? "",
      flag: json['flag'] ?? "",
      iso2: json['iso2'] ?? "",
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, title, flag, iso2];

  @override
  String toString() {
    return 'CountryModel{id: $id, title: $title, flag: $flag, iso2: $iso2}';
  }
}

class CityModel extends Equatable {
  final int id;
  final String title;

  const CityModel({
    required this.id,
    required this.title,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'] ?? -1,
      title: json['name'] ?? "",
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, title];

  @override
  String toString() {
    return 'CityModel{id: $id, title: $title}';
  }
}
