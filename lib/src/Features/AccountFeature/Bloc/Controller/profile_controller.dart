import 'package:Alegny_provider/src/Features/AccountFeature/Bloc/Model/account_details_model.dart';
import 'package:Alegny_provider/src/Features/AccountFeature/Bloc/Repo/profile_repo.dart';
import 'package:Alegny_provider/src/core/services/Base/base_controller.dart';
import 'package:Alegny_provider/src/core/services/services_locator.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../core/services/Network/network_exceptions.dart';

class ProfileController extends BaseController<ProfileRepo> {
  @override
  // TODO: implement repository
  get repository => sl<ProfileRepo>();

  @override
  void onInit() async {
    // TODO: implement onInit
    getUniversityIDCard();
    await getUserData();
    super.onInit();
  }

  Profile? _user;

  Profile? get user => _user;

  Future<void> getUserData() async {
    showLoading();
    update();

    var result =
        await repository!.getUserData(universityIDCard: universityIDCard);
    result.when(success: (Response response) {
      _user = Profile.fromJson(response.data);
      doneLoading();
      update();
    }, failure: (NetworkExceptions error) {
      errorLoading();
      status = actionNetworkExceptions(error);
      update();
    });
  }

  late int universityIDCard;

  void getUniversityIDCard() {
    universityIDCard = int.parse(sl<GetStorage>().read(
      "universityIDCard",
    ));
  }
}
