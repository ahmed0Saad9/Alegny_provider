// lib/src/Features/ComplaintsFeature/Bloc/Controller/complaint_controller.dart
import 'dart:io';
import 'package:Alegny_provider/src/Features/ComplaintsFeature/Bloc/Model/complaints_model.dart';
import 'package:Alegny_provider/src/Features/ComplaintsFeature/Bloc/Params/complains_param.dart';
import 'package:Alegny_provider/src/Features/ComplaintsFeature/Bloc/Repo/complaints_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Alegny_provider/src/core/services/Base/base_controller.dart';
import 'package:Alegny_provider/src/core/services/Network/network_exceptions.dart';
import 'package:Alegny_provider/src/core/services/services_locator.dart';

class ComplaintController extends BaseController<ComplaintRepository> {
  @override
  get repository => sl<ComplaintRepository>();

  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  File? _complaintImage;
  File? get complaintImage => _complaintImage;

  bool _isSubmitting = false;
  bool get isSubmitting => _isSubmitting;

  ComplaintModel? _submittedComplaint;
  ComplaintModel? get submittedComplaint => _submittedComplaint;

  @override
  void onInit() {
    subjectController = TextEditingController();
    messageController = TextEditingController();
    super.onInit();
  }

  void setComplaintImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 1024,
        maxHeight: 1024,
      );

      if (pickedFile != null) {
        _complaintImage = File(pickedFile.path);
        update();
      }
    } catch (e) {
      print('Image picker error: $e');
      errorEasyLoading('failed_to_pick_image'.tr);
    }
  }

  void removeComplaintImage() {
    _complaintImage = null;
    update();
  }

  void submitComplaint() async {
    if (!formKey.currentState!.validate()) return;

    formKey.currentState!.save();
    _isSubmitting = true;
    update();
    showEasyLoading();

    print('=== SUBMIT COMPLAINT DEBUG ===');
    print('Subject: ${subjectController.text}');
    print('Message: ${messageController.text}');
    print('Image: ${_complaintImage?.path}');

    try {
      var result = await repository!.submitComplaint(
        param: ComplaintParams(
          subject: subjectController.text.trim(),
          message: messageController.text.trim(),
          complaintImage: _complaintImage,
        ),
      );

      closeEasyLoading();
      _isSubmitting = false;

      result.when(success: (Response response) {
        print('=== COMPLAINT SUCCESS RESPONSE ===');
        print('Response data: ${response.data}');

        if (response.data != null) {
          _submittedComplaint = ComplaintModel.fromJson(response.data);

          successEasyLoading(response.data['message'] ??
              'complaint_submitted_successfully'.tr);

          // Clear form after successful submission
          _clearForm();

          update();
        }
      }, failure: (NetworkExceptions error) {
        print('=== COMPLAINT ERROR RESPONSE ===');
        print('Error: $error');
        actionNetworkExceptions(error);
      });
    } catch (e) {
      closeEasyLoading();
      _isSubmitting = false;
      update();
      print('=== COMPLAINT EXCEPTION ===');
      print('Exception: $e');
      errorEasyLoading('an_error_occurred'.tr);
    }
  }

  void _clearForm() {
    subjectController.clear();
    messageController.clear();
    _complaintImage = null;
  }

  String? validateSubject(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'subject_required'.tr;
    }
    if (value.trim().length < 3) {
      return 'subject_too_short'.tr;
    }
    return null;
  }

  String? validateMessage(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'message_required'.tr;
    }
    if (value.trim().length < 10) {
      return 'message_too_short'.tr;
    }
    return null;
  }

  @override
  void onClose() {
    subjectController.dispose();
    messageController.dispose();
    super.onClose();
  }
}
