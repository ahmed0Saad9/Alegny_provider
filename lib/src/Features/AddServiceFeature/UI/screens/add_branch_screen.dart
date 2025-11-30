import 'package:Alegny_provider/src/GeneralWidget/Widgets/Other/base_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:Alegny_provider/src/Features/HomeFeature/Bloc/model/service_model.dart';
import 'package:Alegny_provider/src/Features/AddServiceFeature/Bloc/controller/add_service_controller.dart';
import 'package:Alegny_provider/src/Features/AddServiceFeature/Bloc/Model/add_service_model.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Appbars/app_bars.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/TextFields/text_field_default.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/buttons/button_default.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';
import 'package:url_launcher/url_launcher.dart';

class AddBranchScreen extends StatefulWidget {
  final ServiceModel service;

  const AddBranchScreen({super.key, required this.service});

  @override
  State<AddBranchScreen> createState() => _AddBranchScreenState();
}

class _AddBranchScreenState extends State<AddBranchScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _whatsappController = TextEditingController();
  final TextEditingController _locationUrlController = TextEditingController();

  // Observables
  String _selectedGovernorate = '';
  String _selectedCity = '';
  final Map<String, String> _workingHours = {};

  bool _isLoading = false;

  static const List<String> governorates = [
    'cairo',
    'giza',
    'alexandria',
    'dakahlia',
    'red_sea',
    'beheira',
    'faiyum',
    'gharbia',
    'ismailia',
    'monufia',
    'minya',
    'qalyubia',
    'new_valley',
    'suez',
    'aswan',
    'asyut',
    'beni_suef',
    'port_said',
    'damietta',
    'sharqia',
    'south_sinai',
    'kafr_el_sheikh',
    'matrouh',
    'luxor',
    'qena',
    'north_sinai',
    'sohag',
  ];

  static const Map<String, List<String>> citiesByGovernorate = {
    'cairo': [
      'maadi',
      'mokattam',
      'nasr_city',
      'heliopolis',
      'zamalek',
      'dokki',
      'mohandessin',
      'downtown',
      'ramses',
      'bab_el_shaaria',
      'moski',
      'el_nozha',
      'roxy',
      'mataria',
      'el_marg',
      'zeitoun',
      'ezbet_el_nakhl',
      'hadayek_el_qobbah',
      'old_cairo',
    ],
    'giza': [
      'dokki',
      'mohandessin',
      'agouza',
      'harram',
      'faisal',
      'october_city',
      'omrania',
      'warraq',
      'sheikh_zayed_city',
      'mansheyat_al_qanater',
      'osim',
      'kerdasa',
      'abu_el_nomros',
      'hawamdeya',
      'badrashin',
      'ayyat',
      'saf',
      'atfih',
    ],
    'alexandria': [
      'montaza',
      'smouha',
      'siouf',
      'asafra',
      'labban',
      'raml',
      'shatby',
      'azarita',
      'camp_caesar',
      'ibrahimia',
      'kom_el_deka',
      'maharam_bek',
      'east_alexandria',
      'lauren',
      'zizinia',
      'bolkly',
      'fleming',
      'shots',
      'san_stefano',
      'kafr_abdo',
    ],
    'dakahlia': [
      'mansoura',
      'talkha',
      'mit_ghamr',
      'belqas',
      'aga',
      'menia_el_nasr',
      'sinbillawin',
      'el_manzala',
      'sherbin',
      'mit_salsil',
      'bani_ebeid',
      'gamasa',
      'nabaroh',
      'el_kurdi',
      'mahalet_demna',
      'gamalia',
    ],
    'red_sea': ['marsa_alam', 'ras_ghareb'],
    'hurghada': [
      'safaga',
    ],
    'beheira': [
      'damanhur',
      'kafr_el_dawar',
      'edko',
      'abu_el_matamir',
      'abu_hummus',
      'hosh_essa',
      'delengat',
      'rashid',
      'itay_el_barud',
      'wadi_el_natrun',
    ],
    'faiyum': ['faiyum_city', 'tamiya', 'sinnuris'],
    'gharbia': [
      'tanta',
      'el_mahalla_el_kubra',
      'zefta',
      'samannoud',
      'kafr_el_zayat',
      'basion',
      'qutour',
      'santah',
    ],
    'ismailia': [
      'ismailia_city',
      'fayed',
      'qantara',
      'el_tal_el_kebir',
      'qantara_east',
      'qantara_west',
    ],
    'monufia': [
      'shebin_el_kom',
      'menouf',
      'ashmoun',
      'bagour',
      'sadat_city',
      'quesna',
      'tala',
      'el_shohada',
      'berket_el_sabaa',
    ],
    'minya': [
      'minya_city',
      'malawi',
      'deir_mawas',
      'el_edwa',
      'maghagha',
      'beni_mazar',
      'matai',
      'samalout',
      'abu_qurqas',
      'malawi',
    ],
    'qalyubia': [
      'banha',
      'qalyub',
      'shubra_el_kheima',
      'el_khanka',
      'kafr_shukr',
      'tukh',
      'shibin_el_qanater',
      'khanka',
      'qaha',
      'obour_city',
      'khosous',
    ],
    'new_valley': ['kharga', 'dakhla', 'paris'],
    'suez': [
      'suez_city',
      'arbaeen',
      'suez_district',
      'arbaeen_district',
      'attaka_district',
      'el_ganayen_district',
      'ain_sokhna',
      'green_island',
      'shatt',
      'houd_el_dars',
      'port_tawfik',
      'craftsmen_city',
      'el_sabah',
      'el_amal',
      'mubarak',
      'cooperations',
      'salam',
      'nour',
      'ferdous',
      'tawfiqia',
      'arab_el_maamal_area',
    ],
    'aswan': [
      'aswan_city',
      'kom_ombo',
      'daraw',
      'new_aswan_city',
      'aswan_center',
      'abu_simbel_center',
      'daraw_center',
      'kom_ombo_center',
      'nasr_el_nuba_center',
      'edfu_center',
    ],
    'asyut': ['asyut_city', 'abnub', 'dayrout', 'manfalut'],
    'beni_suef': ['beni_suef_city', 'el_wasta', 'naser'],
    'port_said': ['port_said_city', 'east_district', 'west_district'],
    'damietta': ['damietta_city', 'faraskour', 'zarqa'],
    'sharqia': [
      'zagazig',
      'abu_hamad',
      'belbeis',
      'hehya',
      'abu_kabir',
      'ibrahimia_sharqia',
      'awlad_saqr',
      'husseiniya',
      'deirb_negm',
      'el_qurin',
      'kafr_saqr',
      'menia_el_qamh',
      'mashtool_el_souk',
      'faques',
      'new_salheya',
      'tenth_of_ramadan_city',
    ],
    'south_sinai': ['sharm_el_sheikh', 'dahab', 'nuweiba'],
    'kafr_el_sheikh': ['kafr_el_sheikh_city', 'desouk', 'fuwa'],
    'matrouh': [
      'marsa_matrouh',
      'hamam',
      'nagila',
      'el_alamein',
      'dabaa',
      'marsa_matrouh',
      'nagila',
      'sidi_barrani',
      'salloum',
      'siwa',
    ],
    'luxor': ['luxor_city', 'qurna', 'esna'],
    'qena': ['qena_city', 'qift', 'naqada'],
    'north_sinai': ['el_arish', 'sheikh_zuweid', 'rafah'],
    'sohag': ['sohag_city', 'girga', 'akhmim'],
  };

  @override
  void initState() {
    super.initState();
    _initializeDefaultTimes();
  }

  void _initializeDefaultTimes() {
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
      _workingHours[day] = day == 'friday' ? 'closed'.tr : defaultTime;
    }
  }

  @override
  void dispose() {
    _addressController.dispose();
    _phoneController.dispose();
    _whatsappController.dispose();
    _locationUrlController.dispose();
    super.dispose();
  }

  Future<void> _submitBranch() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedGovernorate.isEmpty) {
      _showError('please_select_governorate'.tr);
      return;
    }

    if (_selectedCity.isEmpty) {
      _showError('please_select_city'.tr);
      return;
    }

    if (!_validateWorkingHours()) {
      _showError('please_set_proper_working_hours'.tr);
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Create the new branch data directly
      final newBranchData = Branch(
        address: _addressController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
        whatsAppNumber: _whatsappController.text.trim(),
        locationUrl: _locationUrlController.text.trim(),
        selectedGovernorate: _selectedGovernorate,
        selectedCity: _selectedCity,
        workingHours: _workingHours,
      );

      // Prepare service data with all existing info + new branch
      final serviceData = ServiceData(
        serviceName: widget.service.serviceName,
        serviceDescription: widget.service.description,
        serviceType: widget.service.serviceType,
        specialization: widget.service.specialization,
        serviceImage: null, // No image change
        facebook: widget.service.facebookUrl,
        instagram: widget.service.instagramUrl,
        tiktok: widget.service.tikTokUrl,
        youtube: widget.service.youTubeUrl,
        // Add the new branch to existing branches
        branches: [
          ...widget.service.branches.map((b) => Branch(
                address: b.address,
                phoneNumber: b.phoneNumber,
                whatsAppNumber: b.whatsapp,
                locationUrl: b.locationUrl,
                selectedGovernorate: b.governorate,
                selectedCity: b.city,
                workingHours: Map<String, String>.from(b.workingHours),
              ).toJson()),
          newBranchData.toJson(),
        ],
      );

      // Set service-specific discount fields from existing service
      _setServiceSpecificFields(serviceData, widget.service);

      // Create a fresh controller for the update
      final addServiceController = AddServiceController(
        serviceToEdit: widget.service,
      );

      // Call update service with the new branch included
      final success = await addServiceController.updateService(
        serviceId: widget.service.id,
        serviceData: serviceData,
        imageFile: null,
      );

      if (success) {
        Get.back(result: true);
        Get.snackbar(
          'success'.tr,
          'branch_added_successfully'.tr,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      _showError('failed_to_add_branch'.tr);
      print('Error adding branch: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _setServiceSpecificFields(
      ServiceData serviceData, ServiceModel service) {
    final discounts = service.discounts;

    // Helper to get string value from dynamic
    String? _getValue(dynamic value) {
      if (value == null) return null;
      return value.toString();
    }

    // Helper to get bool value
    bool _getBoolValue(dynamic value) {
      if (value == null) return false;
      if (value is bool) return value;
      return value.toString().toLowerCase() == 'true';
    }

    switch (service.serviceType) {
      case 'human_doctor':
        serviceData.consultationPriceBefore =
            _getValue(discounts['consultation_price_before']);
        serviceData.consultationPriceAfter =
            _getValue(discounts['consultation_price_after']);
        serviceData.isHomeVisit = _getBoolValue(discounts['is_home_visit']);
        serviceData.homeDiscount = _getBoolValue(discounts['home_discount']);
        serviceData.surgeriesOtherServicesDiscount =
            _getValue(discounts['surgeries_other_services_discount']);
        break;

      case 'veterinarian':
        serviceData.consultationPriceBefore =
            _getValue(discounts['consultation_price_before']);
        serviceData.consultationPriceAfter =
            _getValue(discounts['consultation_price_after']);
        serviceData.isHomeVisit = _getBoolValue(discounts['is_home_visit']);
        serviceData.homeDiscount = _getBoolValue(discounts['home_discount']);
        serviceData.surgeriesOtherServicesDiscount =
            _getValue(discounts['surgeries_other_services_discount']);
        break;

      case 'human_hospital':
        serviceData.examinationsDiscount =
            _getValue(discounts['examinations_discount']);
        serviceData.medicalTestsDiscount =
            _getValue(discounts['medical_tests_discount']);
        serviceData.hospitalXrayDiscount =
            _getValue(discounts['hospital_xray_discount']);
        serviceData.medicinesDiscount =
            _getValue(discounts['medicines_discount']);
        serviceData.surgeriesOtherServicesDiscount =
            _getValue(discounts['surgeries_other_services_discount']);
        break;

      case 'veterinary_hospital':
        serviceData.examinationsDiscount =
            _getValue(discounts['examinations_discount']);
        serviceData.medicalTestsDiscount =
            _getValue(discounts['medical_tests_discount']);
        serviceData.hospitalXrayDiscount =
            _getValue(discounts['hospital_xray_discount']);
        serviceData.medicinesDiscount =
            _getValue(discounts['medicines_discount']);
        serviceData.surgeriesOtherServicesDiscount =
            _getValue(discounts['surgeries_other_services_discount']);
        break;

      case 'human_pharmacy':
        serviceData.localMedicinesDiscount =
            _getValue(discounts['local_medicines_discount']);
        serviceData.importedMedicinesDiscount =
            _getValue(discounts['imported_medicines_discount']);
        serviceData.medicalSuppliesDiscount =
            _getValue(discounts['medical_supplies_discount']);
        serviceData.isHomeDelivery =
            _getBoolValue(discounts['is_home_delivery']);
        serviceData.pharmacyIsHomeCard =
            _getBoolValue(discounts['pharmacy_is_home_card']);
        break;

      case 'veterinary_pharmacy':
        serviceData.localMedicinesDiscount =
            _getValue(discounts['local_medicines_discount']);
        serviceData.importedMedicinesDiscount =
            _getValue(discounts['imported_medicines_discount']);
        serviceData.medicalSuppliesDiscount =
            _getValue(discounts['medical_supplies_discount']);
        serviceData.isHomeDelivery =
            _getBoolValue(discounts['is_home_delivery']);
        serviceData.pharmacyIsHomeCard =
            _getBoolValue(discounts['pharmacy_is_home_card']);
        break;

      case 'lab':
        serviceData.allTestsDiscount =
            _getValue(discounts['all_tests_discount']);
        serviceData.isHomeService = _getBoolValue(discounts['is_home_service']);
        serviceData.isHomeCard = _getBoolValue(discounts['is_home_card']);
        break;

      case 'radiology_center':
        serviceData.xRayDiscount = _getValue(discounts['xray_discount']);
        break;

      case 'optics':
        serviceData.glassesDiscount = _getValue(discounts['glasses_discount']);
        serviceData.sunglassesDiscount =
            _getValue(discounts['sunglasses_discount']);
        serviceData.contactLensesDiscount =
            _getValue(discounts['contact_lenses_discount']);
        serviceData.eyeExamDiscount = _getValue(discounts['eye_exam_discount']);
        serviceData.isDelivery = _getBoolValue(discounts['is_delivery']);
        serviceData.eyeCareIsCard =
            _getBoolValue(discounts['eye_care_is_card']);
        break;

      case 'gym':
        serviceData.gymMonthSubPriceB =
            _getValue(discounts['gym_month_sub_price_b']);
        serviceData.gymMonthSubPriceA =
            _getValue(discounts['gym_month_sub_price_a']);
        serviceData.gymMonth3SubPriceB =
            _getValue(discounts['gym_month_3_sub_price_b']);
        serviceData.gymMonth3SubPriceA =
            _getValue(discounts['gym_month_3_sub_price_a']);
        serviceData.gymMonth6SubPriceB =
            _getValue(discounts['gym_month_6_sub_price_b']);
        serviceData.gymMonth6SubPriceA =
            _getValue(discounts['gym_month_6_sub_price_a']);
        serviceData.gymMonth12SubPriceB =
            _getValue(discounts['gym_month_12_sub_price_b']);
        serviceData.gymMonth12SubPriceA =
            _getValue(discounts['gym_month_12_sub_price_a']);
        serviceData.otherDiscount = _getValue(discounts['other_discount']);
        break;
    }
  }

  bool _validateWorkingHours() {
    bool hasAtLeastOneOpenDay = false;

    for (final hours in _workingHours.values) {
      if (hours.isNotEmpty &&
          hours.toLowerCase() != 'closed'.tr.toLowerCase()) {
        hasAtLeastOneOpenDay = true;
        break;
      }
    }

    return hasAtLeastOneOpenDay;
  }

  void _showError(String message) {
    Get.snackbar(
      'error'.tr,
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBars.appBarBack(
        title: 'add_new_branch',
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            // Service Info Header
            _buildServiceHeader(),

            // Form Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Governorate Dropdown
                    _buildSectionLabel('governorate'.tr, true),
                    12.ESH(),
                    _buildGovernorateDropdown(),
                    24.ESH(),

                    // City Dropdown
                    if (_selectedGovernorate.isNotEmpty) ...[
                      _buildSectionLabel('city'.tr, true),
                      12.ESH(),
                      _buildCityDropdown(),
                      24.ESH(),
                    ],

                    // Address Field
                    _buildSectionLabel('address'.tr, true),
                    12.ESH(),
                    TextFieldDefault(
                      controller: _addressController,
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

                    // Location URL Field
                    _buildSectionLabel('location'.tr, true),
                    12.ESH(),
                    TextFieldDefault(
                      controller: _locationUrlController,
                      keyboardType: TextInputType.url,
                      hint: 'Enter_location'.tr,
                      validation: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'location_required'.tr;
                        }
                        final urlPattern = RegExp(
                          r'^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$',
                          caseSensitive: false,
                        );
                        if (!urlPattern.hasMatch(value.trim())) {
                          return 'invalid_url'.tr;
                        }
                        return null;
                      },
                    ),
                    8.ESH(),
                    _buildOpenMapsButton(),
                    24.ESH(),

                    // Phone Number Field
                    _buildSectionLabel('phone_number'.tr, true),
                    12.ESH(),
                    TextFieldDefault(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      hint: 'enter_phone_number'.tr,
                      maxLength: 11,
                      validation: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'phone_required'.tr;
                        }
                        final cleanValue =
                            value.replaceAll(RegExp(r'[^\d]'), '');
                        if (cleanValue.length != 11) {
                          return 'phone_must_be_11_digits'.tr;
                        }
                        if (!cleanValue.startsWith('01')) {
                          return 'phone_must_start_with_01'.tr;
                        }
                        return null;
                      },
                    ),
                    24.ESH(),

                    // WhatsApp Number Field
                    _buildSectionLabel('whatsapp_number'.tr, true),
                    12.ESH(),
                    TextFieldDefault(
                      controller: _whatsappController,
                      keyboardType: TextInputType.phone,
                      hint: 'enter_whatsapp_number'.tr,
                      maxLength: 11,
                      validation: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'whatsapp_required'.tr;
                        }
                        final cleanValue =
                            value.replaceAll(RegExp(r'[^\d]'), '');
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
                    _buildSectionLabel('working_hours'.tr, true),
                    12.ESH(),
                    _buildWorkingHoursSection(),
                  ],
                ),
              ),
            ),

            // Submit Button
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextL(
            'adding_branch_to'.tr,
            fontSize: 16.sp,
            color: Colors.grey[600],
          ),
          8.ESH(),
          CustomTextL(
            widget.service.serviceName,
            fontSize: 18.sp,
            fontWeight: FW.bold,
            color: AppColors.main,
          ),
        ],
      ),
    );
  }

  Widget _buildGovernorateDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedGovernorate.isEmpty ? null : _selectedGovernorate,
      decoration: _dropdownDecoration(),
      hint: CustomTextL('select_governorate'.tr,
          color: Colors.grey[600], fontSize: 16.sp),
      items: governorates.map((gov) {
        return DropdownMenuItem<String>(
          value: gov,
          child: CustomTextL(gov.tr, fontSize: 14.sp),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedGovernorate = value ?? '';
          _selectedCity = '';
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'please_select_governorate'.tr;
        }
        return null;
      },
    );
  }

  Widget _buildCityDropdown() {
    final cities = citiesByGovernorate[_selectedGovernorate] ?? [];

    return DropdownButtonFormField<String>(
      value: _selectedCity.isEmpty ? null : _selectedCity,
      decoration: _dropdownDecoration(),
      hint: CustomTextL('select_city'.tr,
          color: Colors.grey[600], fontSize: 16.sp),
      items: cities.map((city) {
        return DropdownMenuItem<String>(
          value: city,
          child: CustomTextL(city.tr, fontSize: 14.sp),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedCity = value ?? '';
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'please_select_city'.tr;
        }
        return null;
      },
    );
  }

  Widget _buildWorkingHoursSection() {
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
        return _buildWorkingHoursField(day.key, day.value);
      }).toList(),
    );
  }

  Widget _buildWorkingHoursField(String dayKey, String dayLabel) {
    final currentHours = _workingHours[dayKey] ?? '9:00 AM - 5:00 PM';
    final isClosed = currentHours.toLowerCase() == 'closed'.tr.toLowerCase();

    String fromTime = '9:00 AM';
    String toTime = '5:00 PM';

    if (!isClosed && currentHours.contains(' - ')) {
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
                  CustomTextL('closed'.tr,
                      fontSize: 12.sp, color: Colors.grey[600]),
                  8.ESW(),
                  Transform.scale(
                    scale: 0.8,
                    child: Switch(
                      value: isClosed,
                      activeColor: AppColors.main,
                      onChanged: (value) {
                        setState(() {
                          _workingHours[dayKey] =
                              value ? 'closed'.tr : '9:00 AM - 5:00 PM';
                        });
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
                  child: InkWell(
                    onTap: () =>
                        _showTimePicker(true, dayKey, fromTime, toTime),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 18.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTextL(fromTime, fontSize: 15.sp),
                          Icon(Icons.access_time,
                              size: 20.sp, color: AppColors.main),
                        ],
                      ),
                    ),
                  ),
                ),
                12.ESW(),
                CustomTextL('to', fontSize: 16.sp, color: Colors.grey[600]),
                12.ESW(),
                Expanded(
                  child: InkWell(
                    onTap: () =>
                        _showTimePicker(false, dayKey, fromTime, toTime),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 18.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTextL(toTime, fontSize: 15.sp),
                          Icon(Icons.access_time,
                              size: 20.sp, color: AppColors.main),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _showTimePicker(bool isFromTime, String dayKey,
      String currentFromTime, String currentToTime) async {
    final currentHours = _workingHours[dayKey] ?? '9:00 AM - 5:00 PM';
    final isClosed = currentHours.toLowerCase() == 'closed'.tr.toLowerCase();

    if (isClosed) return;

    TimeOfDay initialTime = isFromTime
        ? _parseTimeString(currentFromTime)
        : _parseTimeString(currentToTime);

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.main,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        final formattedTime = _formatTimeOfDay(picked);

        String fromTime = currentFromTime;
        String toTime = currentToTime;

        if (isFromTime) {
          fromTime = formattedTime;
        } else {
          toTime = formattedTime;
        }

        _workingHours[dayKey] = '$fromTime - $toTime';
      });
    }
  }

  TimeOfDay _parseTimeString(String timeString) {
    try {
      final cleanedString = timeString.trim().toLowerCase();
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
    } catch (e) {
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

  Widget _buildOpenMapsButton() {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: _openGoogleMaps,
        style: TextButton.styleFrom(
          foregroundColor: AppColors.main,
          padding: EdgeInsets.symmetric(vertical: 12.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        child: Row(
          children: [
            Icon(Icons.map_outlined, size: 20.sp, color: AppColors.main),
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
      _showError('cannot_open_google_maps'.tr);
    }
  }

  Widget _buildSubmitButton() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: ButtonDefault(
        title: 'add_branch',
        onTap: _isLoading ? null : _submitBranch,
        isLoading: _isLoading,
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
    );
  }
}
