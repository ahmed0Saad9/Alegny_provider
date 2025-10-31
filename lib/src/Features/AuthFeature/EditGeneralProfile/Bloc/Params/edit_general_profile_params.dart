



class EditProfileParam {
  final String name;
  final String address;
  final String email;
  final String mobile;

  final int? cityId;
  final String role;
  final String deviceToken;
  final String description;
  final int companyCategoryId;
  final int merchantCategoryId;
  final List<int> merchantCitiesIds;
  // final MediaType? image;

  EditProfileParam({
    // required this.image,
    required this.cityId,
    required this.name,
    required this.address,
    required this.role,
    required this.email,
    required this.mobile,
    required this.deviceToken,

    required this.companyCategoryId,
    required this.merchantCategoryId,
    required this.merchantCitiesIds,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': "+2$mobile",
      'role': role,
      'description': description,
      if(role=='merchant') 'merchant_category': merchantCategoryId,
      if(role=='merchant') 'merchant_cities': merchantCitiesIds,
      if(address.isNotEmpty) 'address': address,
      if(cityId!=0) 'city_id': cityId,
      // 'device_key': "123",
      if(companyCategoryId!=0)  'company_category_id': companyCategoryId,
    };
  }

  // Future<FormData> toFormData() async {
  //   FormData formMap = FormData.fromMap(toMap());
  //   if(image!=null) {
  //     formMap.files.add(
  //     MapEntry(
  //       'image',
  //       await MultipartFile.fromFile(
  //         image!.media.path,
  //         filename: path.basename(image!.media.path),
  //       ),
  //     ),
  //   );
  //   }
  //   return formMap;
  // }
}

// "nationalityId": 25715549,
// "firstNameEn": "adipisicing",
// "lastNameEn": "minim ullamco",
// "familyNameEn": "nisi do",
// "qId": "ullamco Lorem labore",
// "genderId": 41742021,
// "email": "consectetur ipsum Lorem velit",
// "mobile": "eu",
// "address": "eius",
// "username": "aute id commo",
// "birthDate": "2016-09-26T08:12:26.159Z",
// "passport": "in",
// "userPassword": "aute adipisicing et"
