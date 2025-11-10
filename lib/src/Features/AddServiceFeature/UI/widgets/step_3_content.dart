part of '../screens/add_service_screen.dart';

class _Step3Content extends StatelessWidget {
  final AddServiceController controller;

  const _Step3Content({required this.controller});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddServiceController>(
      builder: (controller) {
        return Column(
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
    final hasLocation = controller.branchLatitudes[index].value != null &&
        controller.branchLongitudes[index].value != null;
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

          // Governorate Dropdown - FIXED
          _buildSectionLabel('governorate'.tr, true),
          12.ESH(),
          _buildGovernorateDropdown(controller, index),
          24.ESH(),

          // City Dropdown (only show if governorate is selected)
          if (controller.branchSelectedGovernorates[index].isNotEmpty) ...[
            _buildSectionLabel('city'.tr, true),
            12.ESH(),
            _buildCityDropdown(controller, index),
            24.ESH(),
          ],

          // Address Field
          _buildSectionLabel('address'.tr, true),
          12.ESH(),
          TextFieldDefault(
            controller: controller.branchAddressControllers[index],
            hint: 'enter_address'.tr,
            maxLines: 3,
          ),
          24.ESH(),

          // Location Selection Button
          _buildSectionLabel('location'.tr, true),
          12.ESH(),
          _buildLocationSelector(controller, index, hasLocation),
          24.ESH(),

          // Phone Number Field
          _buildSectionLabel('phone_number'.tr, true),
          12.ESH(),
          TextFieldDefault(
            controller: controller.branchPhoneControllers[index],
            keyboardType: TextInputType.phone,
            hint: 'enter_phone_number'.tr,
          ),
          24.ESH(),

          // WhatsApp Number Field (REPLACED Branch Phone)
          _buildSectionLabel('whatsapp_number'.tr, true),
          12.ESH(),
          TextFieldDefault(
            controller: controller.branchWhatsappControllers[index],
            keyboardType: TextInputType.phone,
            hint: 'enter_whatsapp_number'.tr,
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
    // Get unique governorates to avoid duplicates
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
          child: CustomTextL(gov, fontSize: 14.sp),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          controller.branchSelectedGovernorates[index].value = value;
          controller.branchSelectedCities[index].value =
              ''; // Reset city when governorate changes
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

    // Get unique cities to avoid duplicates
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
          child: CustomTextL(city, fontSize: 14.sp),
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

  Widget _buildLocationSelector(
      AddServiceController controller, int index, bool hasLocation) {
    final hasExistingLocation =
        controller.branchLatitudes[index].value != null &&
            controller.branchLongitudes[index].value != null;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Get.to(() => MapsLocationPickerScreen(
                branchIndex: index,
                initialLat: controller.branchLatitudes[index].value,
                initialLng: controller.branchLongitudes[index].value,
              ));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: hasExistingLocation ? Colors.green : AppColors.main,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              hasExistingLocation
                  ? Icons.location_on
                  : Icons.my_location_outlined,
              size: 20.sp,
            ),
            8.ESW(),
            CustomTextL(
              hasExistingLocation ? 'Location_selected' : 'Select_location',
              fontSize: 16.sp,
              color: AppColors.titleWhite,
              fontWeight: FW.medium,
            ),
            if (hasExistingLocation) ...[
              8.ESW(),
              CustomTextL(
                '(${controller.branchLatitudes[index].value!.toStringAsFixed(4)}, '
                '${controller.branchLongitudes[index].value!.toStringAsFixed(4)})',
                fontSize: 12.sp,
                color: Colors.white,
              ),
            ],
          ],
        ),
      ),
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

    return Column(
      children: days.entries.map((day) {
        return _buildWorkingHoursField(
            context, workingHours, day.key, day.value, controller, branchIndex);
      }).toList(),
    );
  }

  Widget _buildWorkingHoursField(
      BuildContext context,
      Map<String, String> workingHours,
      String dayKey,
      String dayLabel,
      AddServiceController controller,
      int branchIndex) {
    final currentHours = workingHours[dayKey] ?? '';
    final isClosed = currentHours.toLowerCase() == 'closed'.tr.toLowerCase();

    String fromTime = '';
    String toTime = '';

    if (!isClosed && currentHours.isNotEmpty) {
      if (currentHours.contains(' - ')) {
        final times = currentHours.split(' - ');
        if (times.length == 2) {
          fromTime = times[0].trim();
          toTime = times[1].trim();
        }
      } else {
        // Handle case where only one time is set
        fromTime = currentHours.trim();
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
                flex: 2,
                child: CustomTextL(dayLabel, fontSize: 14.sp),
              ),
              12.ESW(),
              // Closed Switch
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
                          // When opening a day, set default times
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
                Expanded(flex: 1, child: SizedBox()),
                8.ESW(),
                Expanded(
                  flex: 4,
                  child: Row(
                    children: [
                      // From Time Picker
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
                                    fromTime.isEmpty ? 'from'.tr : fromTime,
                                    fontSize: 15.sp,
                                    color: fromTime.isEmpty
                                        ? Colors.orange
                                        : Colors.grey[800],
                                  ),
                                ),
                                Icon(Icons.access_time,
                                    size: 20.sp,
                                    color: fromTime.isEmpty
                                        ? Colors.orange
                                        : AppColors.main),
                              ],
                            ),
                          ),
                        ),
                      ),
                      12.ESW(),
                      CustomTextL('-',
                          fontSize: 16.sp, color: Colors.grey[600]),
                      12.ESW(),
                      // To Time Picker
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
                                    toTime.isEmpty ? 'to'.tr : toTime,
                                    fontSize: 15.sp,
                                    color: toTime.isEmpty
                                        ? Colors.orange
                                        : Colors.grey[800],
                                  ),
                                ),
                                Icon(Icons.access_time,
                                    size: 20.sp,
                                    color: toTime.isEmpty
                                        ? Colors.orange
                                        : AppColors.main),
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
    final currentHours = workingHours[dayKey] ?? '';
    final isClosed = currentHours.toLowerCase() == 'closed'.tr.toLowerCase();

    if (isClosed) return;

    // Parse current times
    String fromTime = currentFromTime;
    String toTime = currentToTime;

    // Determine initial time for the picker
    TimeOfDay initialTime = TimeOfDay(hour: 9, minute: 0);

    if (isFromTime) {
      if (fromTime.isNotEmpty) {
        initialTime = _parseTimeString(fromTime);
      }
    } else {
      if (toTime.isNotEmpty) {
        initialTime = _parseTimeString(toTime);
      } else {
        // Default to 5:00 PM for "to" time if not set
        initialTime = TimeOfDay(hour: 17, minute: 0);
      }
    }

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.main,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final formattedTime = _formatTimeOfDay(picked);

      // Update the appropriate time immediately
      if (isFromTime) {
        fromTime = formattedTime;
      } else {
        toTime = formattedTime;
      }

      // Build the final time string - handle cases where only one time is set
      String finalTimeString = '';

      if (fromTime.isNotEmpty && toTime.isNotEmpty) {
        finalTimeString = '$fromTime - $toTime';
      } else if (fromTime.isNotEmpty) {
        finalTimeString = fromTime; // Only from time is set
      } else if (toTime.isNotEmpty) {
        finalTimeString = toTime; // Only to time is set
      }

      // Update working hours immediately
      if (finalTimeString.isNotEmpty) {
        workingHours[dayKey] = finalTimeString;
        controller.update();

        // Debug print
        print('Updated working hours for $dayKey: ${workingHours[dayKey]}');
        print('From: $fromTime, To: $toTime');
      }
    }
  }

// Improved time parsing method
  TimeOfDay _parseTimeString(String timeString) {
    try {
      // Remove any extra spaces and convert to lowercase
      final cleanedString = timeString.trim().toLowerCase();

      // Check if it's in 12-hour format with AM/PM
      if (cleanedString.contains('am') || cleanedString.contains('pm')) {
        final parts = cleanedString.split(' ');
        final timeParts = parts[0].split(':');

        if (timeParts.length < 2) return const TimeOfDay(hour: 9, minute: 0);

        int hour = int.parse(timeParts[0]);
        int minute = int.parse(timeParts[1]);

        // Handle AM/PM conversion
        if (cleanedString.contains('pm') && hour < 12) {
          hour += 12;
        } else if (cleanedString.contains('am') && hour == 12) {
          hour = 0;
        }

        return TimeOfDay(hour: hour, minute: minute);
      } else {
        // Assume 24-hour format
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

// Improved time formatting method
  String _formatTimeOfDay(TimeOfDay timeOfDay) {
    final hour = timeOfDay.hour;
    final minute = timeOfDay.minute;

    // Use 12-hour format with AM/PM
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
}
