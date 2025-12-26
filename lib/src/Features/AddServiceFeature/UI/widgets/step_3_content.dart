part of '../screens/add_service_screen.dart';

class _Step3Content extends StatelessWidget {
  final AddServiceController controller;

  const _Step3Content({required this.controller});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddServiceController>(
      builder: (controller) {
        return Form(
          key: controller.step3FormKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextL(
                'branches',
                fontSize: 20.sp,
                fontWeight: FW.bold,
                color: Colors.grey[800],
              ),
              24.ESH(),

              // Branches List
              ..._buildBranchesList(controller, context),

              // Add Branch Button
              _buildAddBranchButton(controller),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildBranchesList(
      AddServiceController controller, BuildContext context) {
    return controller.branches.asMap().entries.map((entry) {
      final index = entry.key;
      final branch = entry.value;
      return _buildBranchCard(controller, index, context);
    }).toList();
  }

  Widget _buildBranchCard(
      AddServiceController controller, int index, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Branch Header with Remove Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextL(
                '${'branch'.tr} ${index + 1}',
                fontSize: 18.sp,
                fontWeight: FW.bold,
                color: AppColors.main,
              ),
              if (controller.branches.length > 1)
                IconButton(
                  onPressed: () => controller.removeBranch(index),
                  icon: Icon(Icons.delete, color: Colors.red, size: 20.sp),
                ),
            ],
          ),
          16.ESH(),

          // Governorate Dropdown
          _buildSectionLabel('governorate'.tr, true),
          12.ESH(),
          _buildGovernorateDropdown(controller, index),
          24.ESH(),

          // City Dropdown
          if (controller.branchSelectedGovernorates[index].isNotEmpty) ...[
            _buildSectionLabel('city'.tr, true),
            12.ESH(),
            _buildCityDropdown(controller, index),
            24.ESH(),
          ],

          // Address Field with validation
          _buildSectionLabel('address'.tr, true),
          12.ESH(),
          TextFieldDefault(
            controller: controller.branchAddressControllers[index],
            hint: 'enter_address'.tr,
            maxLines: 3,
            validation: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'address_required'.tr;
              }
              if (value.trim().length < 10) {
                return 'address_too_short'.tr;
              }
              return null;
            },
          ),
          24.ESH(),

          // Location Field with URL validation
          _buildSectionLabel('location'.tr, false),
          12.ESH(),
          TextFieldDefault(
            controller: controller.branchLocationUrlControllers[index],
            keyboardType: TextInputType.text,
            hint: 'Enter_location'.tr,
            validation: (value) {
              // Allow empty field - return null (no error)
              if (value == null || value.trim().isEmpty) {
                return null;
              }

              // Only validate if something is entered
              final trimmedValue = value.trim();

              // Enhanced URL pattern that handles more cases
              final urlPattern = RegExp(
                r'^(https?:\/\/)?' // http:// or https:// (optional)
                r'([\da-z\.-]+)\.' // domain name
                r'([a-z]{2,})' // top level domain
                r'(:[0-9]{1,5})?' // optional port
                r'(\/[^\s]*)?$', // optional path
                caseSensitive: false,
              );

              if (!urlPattern.hasMatch(trimmedValue)) {
                return 'invalid_url'.tr;
              }

              return null;
            },
          ),
          8.ESH(),
          _buildOpenMapsButton(controller, index),
          24.ESH(),

          // Phone Number Field with validation
          _buildSectionLabel('phone_number'.tr, true),
          12.ESH(),
          TextFieldDefault(
            controller: controller.branchPhoneControllers[index],
            keyboardType: TextInputType.phone,
            hint: 'enter_phone_number'.tr,
            onChanged: (value) {
              // Trigger validation on every change
              controller.step3FormKey.currentState?.validate();
            },
            validation: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'phone_required'.tr;
              }

              return null;
            },
          ),
          24.ESH(),

          // WhatsApp Number Field with validation
          _buildSectionLabel('whatsapp_number'.tr, true),
          12.ESH(),
          TextFieldDefault(
            controller: controller.branchWhatsappControllers[index],
            keyboardType: TextInputType.phone,
            hint: 'enter_whatsapp_number'.tr,
            maxLength: 11,
            onChanged: (value) {
              // Trigger validation on every change
              controller.step3FormKey.currentState?.validate();
            },
            validation: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'whatsapp_required'.tr;
              }
              // Remove any spaces or special characters for validation
              final cleanValue = value.replaceAll(RegExp(r'[^\d]'), '');

              if (cleanValue.length != 11) {
                return 'whatsapp_must_be_11_digits'.tr;
              }
              if (!cleanValue.startsWith('01')) {
                return 'whatsapp_must_start_with_01'.tr;
              }
              return null;
            },
          ),
          24.ESH(),

          // Working Hours
          _buildSectionLabel('working_hours'.tr, false),
          12.ESH(),
          _buildWorkingHours(
              controller.branchWorkingHours[index], context, controller, index),
        ],
      ),
    );
  }

  Widget _buildGovernorateDropdown(AddServiceController controller, int index) {
    final uniqueGovernorates = controller.uniqueGovernorates;

    return DropdownButtonFormField<String>(
      value: controller.branchSelectedGovernorates[index].value.isEmpty
          ? null
          : controller.branchSelectedGovernorates[index].value,
      decoration: _dropdownDecoration(),
      hint: CustomTextL('select_governorate'.tr,
          color: Colors.grey[600], fontSize: 16.sp),
      items: uniqueGovernorates.map((gov) {
        return DropdownMenuItem<String>(
          value: gov,
          child: CustomTextL(gov.tr, fontSize: 14.sp),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          controller.branchSelectedGovernorates[index].value = value;
          controller.branchSelectedCities[index].value = '';
          controller.update();
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'please_select_governorate'.tr;
        }
        return null;
      },
    );
  }

  Widget _buildCityDropdown(AddServiceController controller, int index) {
    final selectedGovernorate =
        controller.branchSelectedGovernorates[index].value;
    final cities =
        AddServiceController.citiesByGovernorate[selectedGovernorate] ?? [];
    final uniqueCities = cities.toSet().toList();

    return DropdownButtonFormField<String>(
      value: controller.branchSelectedCities[index].value.isEmpty
          ? null
          : controller.branchSelectedCities[index].value,
      decoration: _dropdownDecoration(),
      hint: CustomTextL('select_city'.tr,
          color: Colors.grey[600], fontSize: 16.sp),
      items: uniqueCities.map((city) {
        return DropdownMenuItem<String>(
          value: city,
          child: CustomTextL(city.tr, fontSize: 14.sp),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          controller.branchSelectedCities[index].value = value;
          controller.update();
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'please_select_city'.tr;
        }
        return null;
      },
    );
  }

  Widget _buildWorkingHours(Map<String, String> workingHours,
      BuildContext context, AddServiceController controller, int branchIndex) {
    final days = {
      'saturday': 'saturday'.tr,
      'sunday': 'sunday'.tr,
      'monday': 'monday'.tr,
      'tuesday': 'tuesday'.tr,
      'wednesday': 'wednesday'.tr,
      'thursday': 'thursday'.tr,
      'friday': 'friday'.tr,
    };

    _initializeDefaultTimes(workingHours);

    return Column(
      children: days.entries.map((day) {
        return _buildWorkingHoursField(
            context, workingHours, day.key, day.value, controller, branchIndex);
      }).toList(),
    );
  }

  void _initializeDefaultTimes(Map<String, String> workingHours) {
    const defaultTime = '9:00 AM - 5:00 PM';
    final days = [
      'saturday',
      'sunday',
      'monday',
      'tuesday',
      'wednesday',
      'thursday',
      'friday'
    ];

    for (final day in days) {
      final currentHours = workingHours[day];

      // Only set default if no value exists
      if (currentHours == null || currentHours.isEmpty) {
        if (day == 'friday') {
          workingHours[day] = 'closed'.tr;
        } else {
          workingHours[day] = defaultTime;
        }
      }
      // If there's already a value, keep it (even for Friday)
    }
  }

  Widget _buildWorkingHoursField(
      BuildContext context,
      Map<String, String> workingHours,
      String dayKey,
      String dayLabel,
      AddServiceController controller,
      int branchIndex) {
    final currentHours = workingHours[dayKey] ?? '9:00 AM - 5:00 PM';
    final isClosed = currentHours.toLowerCase().contains('closed') ||
        currentHours.trim().isEmpty ||
        currentHours.toLowerCase() == 'closed'.tr.toLowerCase();

    String fromTime = '9:00 AM';
    String toTime = '5:00 PM';

    if (!isClosed && currentHours.isNotEmpty && currentHours.contains(' - ')) {
      final times = currentHours.split(' - ');
      if (times.length == 2) {
        fromTime = times[0].trim();
        toTime = times[1].trim();
      }
    }

    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: CustomTextL(dayLabel, fontSize: 14.sp),
              ),
              12.ESW(),
              Row(
                children: [
                  CustomTextL(
                    'closed'.tr,
                    fontSize: 12.sp,
                    color: Colors.grey[600],
                  ),
                  8.ESW(),
                  Transform.scale(
                    scale: 0.8,
                    child: Switch(
                      value: isClosed,
                      activeColor: AppColors.main,
                      onChanged: (value) {
                        if (value) {
                          workingHours[dayKey] = 'closed'.tr;
                        } else {
                          workingHours[dayKey] = '9:00 AM - 5:00 PM';
                        }
                        controller.update();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (!isClosed) ...[
            12.ESH(),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => _showTimePicker(
                              context,
                              true,
                              workingHours,
                              dayKey,
                              fromTime,
                              toTime,
                              controller,
                              branchIndex),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 18.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                  color: fromTime.isEmpty
                                      ? Colors.orange
                                      : Colors.grey[300]!),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: CustomTextL(
                                    fromTime,
                                    fontSize: 15.sp,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                Icon(Icons.access_time,
                                    size: 20.sp, color: AppColors.main),
                              ],
                            ),
                          ),
                        ),
                      ),
                      12.ESW(),
                      CustomTextL('to',
                          fontSize: 16.sp, color: Colors.grey[600]),
                      12.ESW(),
                      Expanded(
                        child: InkWell(
                          onTap: () => _showTimePicker(
                              context,
                              false,
                              workingHours,
                              dayKey,
                              fromTime,
                              toTime,
                              controller,
                              branchIndex),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 18.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                  color: toTime.isEmpty
                                      ? Colors.orange
                                      : Colors.grey[300]!),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: CustomTextL(
                                    toTime,
                                    fontSize: 15.sp,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                Icon(Icons.access_time,
                                    size: 20.sp, color: AppColors.main),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _showTimePicker(
    BuildContext context,
    bool isFromTime,
    Map<String, String> workingHours,
    String dayKey,
    String currentFromTime,
    String currentToTime,
    AddServiceController controller,
    int branchIndex,
  ) async {
    final currentFocus = FocusScope.of(context);
    final unfocused = currentFocus.unfocus();
    await Future.delayed(Duration(milliseconds: 100));

    final currentHours = workingHours[dayKey] ?? '9:00 AM - 5:00 PM';
    final isClosed = currentHours.toLowerCase() == 'closed'.tr.toLowerCase();

    if (isClosed) return;

    String fromTime = '9:00 AM';
    String toTime = '5:00 PM';

    if (currentHours.contains(' - ')) {
      final times = currentHours.split(' - ');
      if (times.length == 2) {
        fromTime = times[0].trim();
        toTime = times[1].trim();
      }
    }

    TimeOfDay initialTime =
        isFromTime ? _parseTimeString(fromTime) : _parseTimeString(toTime);

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
      initialEntryMode: TimePickerEntryMode.dialOnly,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          // This forces 12-hour format
          data: MediaQuery.of(context).copyWith(
            alwaysUse24HourFormat: false,
          ),
          child: Theme(
            data: ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light(
                primary: AppColors.main,
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: Colors.black,
              ),
              dialogBackgroundColor: Colors.white,
              timePickerTheme: TimePickerThemeData(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
            child: child!,
          ),
        );
      },
    );

    if (picked != null) {
      final formattedTime = _formatTimeOfDay(picked);

      if (isFromTime) {
        fromTime = formattedTime;
      } else {
        toTime = formattedTime;
      }

      final finalTimeString = '$fromTime - $toTime';
      workingHours[dayKey] = finalTimeString;
      controller.update();

      print('Updated working hours for $dayKey: ${workingHours[dayKey]}');
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final focusScope = FocusScope.of(context);
      if (!focusScope.hasPrimaryFocus) {
        focusScope.unfocus();
      }
    });
  }

  TimeOfDay _parseTimeString(String timeString) {
    try {
      final cleanedString = timeString.trim().toLowerCase();

      if (cleanedString.contains('am') || cleanedString.contains('pm')) {
        final parts = cleanedString.split(' ');
        final timeParts = parts[0].split(':');

        if (timeParts.length < 2) return const TimeOfDay(hour: 9, minute: 0);

        int hour = int.parse(timeParts[0]);
        int minute = int.parse(timeParts[1]);

        if (cleanedString.contains('pm') && hour < 12) {
          hour += 12;
        } else if (cleanedString.contains('am') && hour == 12) {
          hour = 0;
        }

        return TimeOfDay(hour: hour, minute: minute);
      } else {
        final timeParts = cleanedString.split(':');
        if (timeParts.length < 2) return const TimeOfDay(hour: 9, minute: 0);

        int hour = int.parse(timeParts[0]);
        int minute = int.parse(timeParts[1]);

        return TimeOfDay(hour: hour, minute: minute);
      }
    } catch (e) {
      print('Error parsing time string: $timeString, error: $e');
      return const TimeOfDay(hour: 9, minute: 0);
    }
  }

  String _formatTimeOfDay(TimeOfDay timeOfDay) {
    final hour = timeOfDay.hour;
    final minute = timeOfDay.minute;

    final period = hour < 12 ? 'AM' : 'PM';
    final displayHour = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
    final displayMinute = minute.toString().padLeft(2, '0');

    return '$displayHour:$displayMinute $period';
  }

  Widget _buildAddBranchButton(AddServiceController controller) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: controller.addBranch,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.main,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, size: 20.sp),
            8.ESW(),
            CustomTextL(
              'add_branch'.tr,
              fontSize: 16.sp,
              fontWeight: FW.bold,
              color: AppColors.titleWhite,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String text, bool isRequired) {
    return Row(
      children: [
        CustomTextL(
          text,
          fontSize: 16.sp,
          fontWeight: FW.medium,
          color: Colors.grey[700],
        ),
        if (isRequired) ...[
          4.ESW(),
          CustomTextL('*', fontSize: 16.sp, color: Colors.red),
        ],
      ],
    );
  }

  InputDecoration _dropdownDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(color: AppColors.main, width: 1),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(color: Colors.red, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(color: Colors.red, width: 1),
      ),
    );
  }

  Widget _buildOpenMapsButton(AddServiceController controller, int index) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () {
          _openGoogleMaps();
        },
        style: TextButton.styleFrom(
          foregroundColor: AppColors.main,
          padding: EdgeInsets.symmetric(
            vertical: 12.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.map_outlined,
              size: 20.sp,
              color: AppColors.main,
            ),
            8.ESW(),
            CustomTextL(
              'open_google_maps'.tr,
              fontSize: 16.sp,
              fontWeight: FW.bold,
              color: AppColors.main,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openGoogleMaps() async {
    try {
      const nativeMapsUrl = 'comgooglemaps://';
      final Uri nativeUri = Uri.parse(nativeMapsUrl);

      if (await canLaunchUrl(nativeUri)) {
        await launchUrl(nativeUri, mode: LaunchMode.externalApplication);
      } else {
        const webMapsUrl = 'https://www.google.com/maps';
        final Uri webUri = Uri.parse(webMapsUrl);
        await launchUrl(webUri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'cannot_open_google_maps'.tr,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
