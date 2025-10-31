import 'package:get/get.dart';

class onboardingModel {
  String image;
  String title;
  String discription;
  double height;
  double width;

  onboardingModel({
    required this.image,
    required this.title,
    required this.discription,
    this.height = 388,
    this.width = double.infinity,
  });
}

List<onboardingModel> contents = [
  onboardingModel(
    image: 'assets/images/OnBoarding1.png',
    title: 'onBoarding_title_1',
    discription: 'onBoarding_subtitle_1',
  ),
  onboardingModel(
    image: 'assets/images/OnBoarding2.png',
    title: 'onBoarding_title_2',
    discription: 'onBoarding_subtitle_2',
  ),
  onboardingModel(
    image: 'assets/images/OnBoarding3.png',
    title: 'onBoarding_title_3',
    discription: 'onBoarding_subtitle_3',
  ),
];
