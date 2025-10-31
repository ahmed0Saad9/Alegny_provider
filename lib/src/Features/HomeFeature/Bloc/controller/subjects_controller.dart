import 'dart:async';

import 'package:flutter/material.dart';
import 'package:Alegny_provider/src/Features/HomeFeature/Bloc/Repo/subjects_repo.dart';
import 'package:Alegny_provider/src/Features/HomeFeature/Bloc/model/academic_year_model.dart';
import 'package:Alegny_provider/src/Features/HomeFeature/Bloc/model/subjects_model.dart';
import 'package:Alegny_provider/src/core/services/Base/base_controller.dart';
import 'package:Alegny_provider/src/core/services/Network/network_exceptions.dart';
import 'package:Alegny_provider/src/core/services/services_locator.dart';

class SubjectsController extends BaseController<SubjectsRepository> {
  // Constants
  static const _debounceDuration = Duration(milliseconds: 500);

  // Controllers
  final TextEditingController searchController = TextEditingController();

  // State variables
  final List<Subjects> _subjects = [];
  int tapIdSelected = 1;
  Timer? _debounce;

  // Academic years data
  final List<AcademicYearModel> academicYearCards = const [
    AcademicYearModel(id: 1, label: 'First_Year'),
    AcademicYearModel(id: 2, label: 'Second_Year'),
    AcademicYearModel(id: 3, label: 'Third_Year'),
    AcademicYearModel(id: 4, label: 'Fourth_Year'),
  ];

  @override
  SubjectsRepository get repository => sl<SubjectsRepository>();

  @override
  void onInit() async {
    await getSubjects();
    super.onInit();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    searchController.dispose();
    super.dispose();
  }

  // Public getter
  List<Subjects> get subjects => _subjects;

  List<Subjects> get filteredSubjects {
    final searchText = searchController.text.toLowerCase();
    return searchText.isEmpty
        ? _subjects
        : _subjects
            .where(
                (subject) => subject.title.toLowerCase().contains(searchText))
            .toList();
  }

  // Actions
  Future<void> getSubjects() async {
    _subjects.clear();
    showLoading();
    update();

    final result = await repository.getAllSubjects(
      // the function that gets all subjects
      academicYear: tapIdSelected,
      search: searchController.text,
    );

    result.when(
      success: (List<Subjects> subjects) {
        //if the Api works successfully the functions in here will be executed
        //adds all subjects received to the list _subjects that will be used in UI
        _subjects.addAll(subjects);
        doneLoading();
        update();
      },
      failure: (NetworkExceptions error) {
        //if the Api service fails the functions in here will be executed
        errorLoading();
        status = actionNetworkExceptions(error);
        update();
      },
    );
  }

  void selectTapId(int id) {
    if (tapIdSelected == id) return;
    tapIdSelected = id;
    getSubjects();
    update();
  }

  void debounceSearch() {
    _debounce?.cancel();
    _debounce = Timer(_debounceDuration, getSubjects);
  }
}
