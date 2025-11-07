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

          // Governorate Dropdown
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
          _buildSectionLabel('whatsapp_number'.tr, false),
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
    return DropdownButtonFormField<String>(
      value: controller.branchSelectedGovernorates[index].value.isEmpty
          ? null
          : controller.branchSelectedGovernorates[index].value,
      decoration: _dropdownDecoration(),
      hint: CustomTextL('select_governorate'.tr,
          color: Colors.grey[600], fontSize: 16.sp),
      items: AddServiceController.governorates.map((gov) {
        return DropdownMenuItem(
          value: gov,
          child: CustomTextL(gov, fontSize: 14.sp),
        );
      }).toList(),
      onChanged: (value) {
        controller.branchSelectedGovernorates[index].value = value!;
        controller.branchSelectedCities[index].value =
            ''; // Reset city when governorate changes
        controller.update();
      },
    );
  }

  Widget _buildCityDropdown(AddServiceController controller, int index) {
    final cities = AddServiceController.citiesByGovernorate[
            controller.branchSelectedGovernorates[index].value] ??
        [];

    return DropdownButtonFormField<String>(
      value: controller.branchSelectedCities[index].value.isEmpty
          ? null
          : controller.branchSelectedCities[index].value,
      decoration: _dropdownDecoration(),
      hint: CustomTextL('select_city'.tr,
          color: Colors.grey[600], fontSize: 16.sp),
      items: cities.map((city) {
        return DropdownMenuItem(
          value: city,
          child: CustomTextL(city, fontSize: 14.sp),
        );
      }).toList(),
      onChanged: (value) {
        controller.branchSelectedCities[index].value = value!;
        controller.update();
      },
    );
  }

  Widget _buildLocationSelector(
      AddServiceController controller, int index, bool hasLocation) {
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
          backgroundColor: hasLocation ? Colors.green : AppColors.main,
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
              hasLocation ? Icons.location_on : Icons.my_location_outlined,
              size: 20.sp,
            ),
            8.ESW(),
            CustomTextL(
              hasLocation ? 'Location_selected' : 'Select_location',
              fontSize: 16.sp,
              color: AppColors.titleWhite,
              fontWeight: FW.medium,
            ),
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

    if (!isClosed && currentHours.contains(' - ')) {
      final times = currentHours.split(' - ');
      if (times.length == 2) {
        fromTime = times[0].trim();
        toTime = times[1].trim();
      }
    } else if (!isClosed && currentHours.isNotEmpty) {
      // Handle case where only one time is set
      fromTime = currentHours;
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
                          workingHours[dayKey] = '';
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
                    flex: 1,
                    child: SizedBox()), // Reduced flex to give more space
                8.ESW(),
                Expanded(
                  flex: 4, // Increased flex for time pickers
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
                                horizontal: 20.w,
                                vertical: 18.h), // Even larger padding
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(color: Colors.grey[300]!),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: CustomTextL(
                                    fromTime.isEmpty ? 'from'.tr : fromTime,
                                    fontSize: 15.sp, // Slightly larger font
                                    color: fromTime.isEmpty
                                        ? Colors.grey[500]
                                        : Colors.grey[800],
                                  ),
                                ),
                                Icon(Icons.access_time,
                                    size: 20.sp,
                                    color: AppColors.main), // Larger icon
                              ],
                            ),
                          ),
                        ),
                      ),
                      12.ESW(), // More spacing
                      CustomTextL('-',
                          fontSize: 16.sp, color: Colors.grey[600]),
                      12.ESW(), // More spacing
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
                                horizontal: 20.w,
                                vertical: 18.h), // Even larger padding
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(color: Colors.grey[300]!),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: CustomTextL(
                                    toTime.isEmpty ? 'to'.tr : toTime,
                                    fontSize: 15.sp, // Slightly larger font
                                    color: toTime.isEmpty
                                        ? Colors.grey[500]
                                        : Colors.grey[800],
                                  ),
                                ),
                                Icon(Icons.access_time,
                                    size: 20.sp,
                                    color: AppColors.main), // Larger icon
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
    // Get current hours for this day
    final currentHours = workingHours[dayKey] ?? '';
    final isClosed = currentHours.toLowerCase() == 'closed'.tr.toLowerCase();

    // If closed, don't show time picker
    if (isClosed) return;

    // Parse current times
    String fromTime = '';
    String toTime = '';

    if (currentHours.contains(' - ')) {
      final times = currentHours.split(' - ');
      fromTime = times[0].trim();
      toTime = times[1].trim();
    }

    // Determine which time to use as initial value
    TimeOfDay initialTime = TimeOfDay(hour: 9, minute: 0);

    if (isFromTime) {
      if (fromTime.isNotEmpty) {
        initialTime = _parseTimeString(fromTime);
      }
    } else {
      if (toTime.isNotEmpty) {
        initialTime = _parseTimeString(toTime);
      } else if (fromTime.isNotEmpty) {
        // If "to" time is empty but "from" time exists, set initial time 1 hour later
        final fromTimeOfDay = _parseTimeString(fromTime);
        initialTime = TimeOfDay(
          hour: (fromTimeOfDay.hour + 1) % 24,
          minute: fromTimeOfDay.minute,
        );
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

      // Get current values again in case they changed
      final updatedCurrentHours = workingHours[dayKey] ?? '';
      String updatedFromTime = '';
      String updatedToTime = '';

      if (updatedCurrentHours.contains(' - ')) {
        final times = updatedCurrentHours.split(' - ');
        updatedFromTime = times[0].trim();
        updatedToTime = times[1].trim();
      } else if (updatedCurrentHours.isNotEmpty &&
          !updatedCurrentHours.toLowerCase().contains('closed')) {
        // If there's only one time value, assume it's the from time
        updatedFromTime = updatedCurrentHours;
      }

      // Update the appropriate time
      if (isFromTime) {
        updatedFromTime = formattedTime;
      } else {
        updatedToTime = formattedTime;
      }

      // Build the final time string
      String finalTimeString = '';
      if (updatedFromTime.isNotEmpty && updatedToTime.isNotEmpty) {
        finalTimeString = '$updatedFromTime - $updatedToTime';
      } else if (updatedFromTime.isNotEmpty) {
        finalTimeString = updatedFromTime;
      } else if (updatedToTime.isNotEmpty) {
        finalTimeString = updatedToTime;
      }

      // Update working hours
      workingHours[dayKey] = finalTimeString;
      controller.update();

      // Debug print to verify saving
      print('Updated working hours for $dayKey: ${workingHours[dayKey]}');
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

        if (timeParts.length < 2) return TimeOfDay(hour: 9, minute: 0);

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
        if (timeParts.length < 2) return TimeOfDay(hour: 9, minute: 0);

        int hour = int.parse(timeParts[0]);
        int minute = int.parse(timeParts[1]);

        return TimeOfDay(hour: hour, minute: minute);
      }
    } catch (e) {
      print('Error parsing time string: $timeString, error: $e');
      return TimeOfDay(hour: 9, minute: 0);
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

  TimeOfDay _getInitialTime(String currentTime) {
    if (currentTime.isEmpty) {
      return TimeOfDay(hour: 9, minute: 0); // Default to 9:00 AM
    }

    try {
      final isPM = currentTime.toLowerCase().contains('pm');
      final timeParts =
          currentTime.replaceAll(RegExp(r'[^0-9:]'), '').split(':');
      int hour = int.parse(timeParts[0]);
      final int minute = int.parse(timeParts[1]);

      if (isPM && hour < 12) hour += 12;
      if (!isPM && hour == 12) hour = 0;

      return TimeOfDay(hour: hour, minute: minute);
    } catch (e) {
      return TimeOfDay(hour: 9, minute: 0);
    }
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
}
