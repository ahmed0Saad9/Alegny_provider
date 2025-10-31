import 'package:Alegny_provider/src/Features/HomeFeature/Bloc/Repo/chapters_repo.dart';
import 'package:Alegny_provider/src/Features/HomeFeature/Bloc/model/chapters_model.dart';
import 'package:Alegny_provider/src/core/services/Base/base_controller.dart';
import 'package:Alegny_provider/src/core/services/Network/network_exceptions.dart';
import 'package:Alegny_provider/src/core/services/services_locator.dart';

class ChaptersController extends BaseController<ChaptersRepository> {
  int subjectID;

  ChaptersController({
    required this.subjectID,
  });
  @override
  // TODO: implement repository
  get repository => sl<ChaptersRepository>();
  @override
  void onInit() async {
    // TODO: implement onInit
    await getChapters();
    super.onInit();
  }

  final List<Chapters> _chapters = [];

  List<Chapters> get chapters => _chapters;

  Future<void> getChapters() async {
    _chapters.clear();
    reInitPagination();
    showLoading();
    update();
    var result = await repository!.getChapters(
      subjectID: subjectID,
    );
    result.when(success: (List<Chapters> c) {
      incrementPageNumber(c.isNotEmpty);
      _chapters.addAll(c);
      doneLoading();
      update();
    }, failure: (NetworkExceptions error) {
      errorLoading();
      status = actionNetworkExceptions(error);
      update();
    });
  }
}
