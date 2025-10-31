import 'package:equatable/equatable.dart';

class GenderTypeModel extends Equatable {
  final int id;
  final String title;

  const GenderTypeModel({
    required this.id,
    required this.title,
  });



  factory GenderTypeModel.fromMap(Map<String, dynamic> json) {
    return GenderTypeModel(
      id: json['key'] ??0,
      title: json['value'] ??"",
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id,title];

}
