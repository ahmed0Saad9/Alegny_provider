import 'package:Alegny_provider/src/Features/AccountFeature/Bloc/Controller/profile_controller.dart';
import 'package:Alegny_provider/src/Features/AccountFeature/UI/widgets/language_select.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/Register/Ui/Screens/terms_and_conditions_screen.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/BottomSheets/base_bottom_sheet.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Other/avatar_widget.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';
import 'package:Alegny_provider/src/core/services/svg_widget.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const String phone1 = '+201031726250';
  static const String phone2 = '+201031724253';
  static const String whatsapp1 = '+201031726250';
  static const String whatsapp2 = '+201031724253';

  // Method to launch phone call
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    try {
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      } else {
        Get.snackbar(
          'error'.tr,
          'cannot_open_phone'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'error_occurred'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Method to launch WhatsApp
  Future<void> _openWhatsApp(String phoneNumber) async {
    // Remove any spaces, dashes, or special characters except +
    String cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');

    // WhatsApp URL (works for both Android and iOS)
    final Uri whatsappUri = Uri.parse('https://wa.me/$cleanNumber');

    try {
      if (await canLaunchUrl(whatsappUri)) {
        await launchUrl(
          whatsappUri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        Get.snackbar(
          'error'.tr,
          'whatsapp_not_installed'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'error_occurred'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: GetBuilder<ProfileController>(
          init: ProfileController(),
          builder: (controller) => Scaffold(
                backgroundColor: const Color(0xFFF5F5F5),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Profile Header Card
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.all(16.w),
                        padding: EdgeInsets.all(24.w),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [AppColors.main, Color(0xFF26A69A)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20.r),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF4DB6AC).withOpacity(0.3),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            // Avatar
                            Stack(
                              children: [
                                Container(
                                    width: 100.w,
                                    height: 100.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 4,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius: 10,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: ClipOval(
                                      child: AvatarWidget(
                                        imageFile: controller.image?.media,
                                        height: 100,
                                        width: 100,
                                      ),
                                    )),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: InkWell(
                                    onTap: () {
                                      controller.setImageFromGallery();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(8.w),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            blurRadius: 5,
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        Icons.camera_alt,
                                        size: 16.sp,
                                        color: AppColors.main,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            16.ESH(),
                            CustomTextR(
                              'Ahmed Saad',
                              fontSize: 24.sp,
                              fontWeight: FW.bold,
                              color: Colors.white,
                            ),
                            SizedBox(height: 8.h),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 8.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.email_outlined,
                                    size: 16.sp,
                                    color: Colors.white,
                                  ),
                                  8.ESW(),
                                  Column(
                                    children: [
                                      CustomTextR(
                                        'ahmedsaad191419@gmail.com',
                                        fontSize: 12.sp,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            16.ESH(), // Edit Button
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: AppColors.main,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 32.w,
                                  vertical: 12.h,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.r),
                                ),
                                elevation: 0,
                              ),
                              child: CustomTextL(
                                'edit',
                                color: AppColors.main,
                                fontSize: 14.sp,
                                fontWeight: FW.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // General Section
                      _buildSectionHeader('general'),
                      _buildMenuItem(
                        icon: Icons.support_agent_outlined,
                        title: 'complaints_suggestions',
                        onTap: () {},
                      ),
                      _buildMenuItem(
                        icon: Icons.play_circle_outline,
                        title: 'app_idea',
                        onTap: () {},
                      ),

                      16.ESH(),
                      // Settings Section
                      _buildSectionHeader('settings'),
                      _buildMenuItem(
                        icon: Icons.language_outlined,
                        title: 'language',
                        onTap: () => Get.bottomSheet(
                          BaseBottomSheet(
                            spaceBHeaderAndWidget: 0,
                            icon: 'Translate',
                            title: 'select_language',
                            height: Get.height * 0.4,
                            widget: const LanguageSelect(),
                          ),
                        ),
                      ),
                      _buildMenuItem(
                        icon: Icons.lock_outline,
                        title: 'change_password',
                        onTap: () {},
                      ),
                      _buildMenuItem(
                        icon: Icons.description_outlined,
                        title: 'terms_conditions',
                        onTap: () => Get.to(
                          () => TermsConditionsScreen(),
                        ),
                      ),

                      16.ESH(),
                      // Contact Section
                      _buildSectionHeader('contact_us'),
                      _buildMenuItem(
                        icon: Icons.phone_outlined,
                        title: 'contact_phone_1',
                        subtitle: phone1,
                        onTap: () => _makePhoneCall(phone1),
                      ),
                      _buildMenuItem(
                        icon: Icons.phone_outlined,
                        title: 'contact_phone_2',
                        subtitle: phone2,
                        onTap: () => _makePhoneCall(phone2),
                      ),
                      _buildMenuItem(
                        icon: Icons.abc,
                        iconColor: const Color(0xFF25D366),
                        title: 'contact_whatsapp_1',
                        subtitle: whatsapp1,
                        onTap: () => _openWhatsApp(whatsapp1),
                      ),
                      _buildMenuItem(
                        icon: Icons.abc,
                        iconColor: const Color(0xFF25D366),
                        title: 'contact_whatsapp_2',
                        subtitle: whatsapp2,
                        onTap: () => _openWhatsApp(whatsapp2),
                      ),

                      24.ESH(),
                      // Social Media Section
                      CustomTextL(
                        'follow_us',
                        fontSize: 16.sp,
                        fontWeight: FW.medium,
                        color: Colors.grey[700],
                      ),
                      16.ESH(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildSocialButton(
                            color: const Color(0xFFE4405F),
                            icon: 'assets/icons/instagram.png',
                            onTap: () {},
                          ),
                          16.ESW(),
                          _buildSocialButton(
                            color: Colors.black,
                            icon: 'assets/icons/tiktok.png',
                            onTap: () {},
                          ),
                          16.ESW(),
                          _buildSocialButton(
                            color: const Color(0xFFFF0000),
                            icon: 'assets/icons/youtube.png',
                            onTap: () {},
                          ),
                          16.ESW(),
                          _buildSocialButton(
                            color: const Color(0xFF1877F2),
                            icon: 'assets/icons/facebook.png',
                            onTap: () {},
                          ),
                        ],
                      ),

                      32.ESH(),

                      // Logout Button
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16.w),
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[50],
                            foregroundColor: Colors.red[700],
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            elevation: 0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.logout, size: 20.sp),
                              SizedBox(width: 8.w),
                              Text(
                                'logout'.tr,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SemiBold",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      32.ESH(),
                    ],
                  ),
                ),
              )),
    );
  }

  Widget _buildSectionHeader(
    String title,
  ) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFFE0F2F1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: CustomTextL(
        title,
        fontSize: 14.sp,
        color: AppColors.main,
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
    Color? iconColor,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        leading: Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            color: (iconColor ?? AppColors.main).withOpacity(0.1),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(
            icon,
            color: iconColor ?? AppColors.main,
            size: 22.sp,
          ),
        ),
        title: CustomTextL(
          title,
          fontSize: 14.sp,
          fontWeight: FW.medium,
          color: Colors.grey[800],
        ),
        subtitle: subtitle != null
            ? CustomTextR(
                subtitle,
                fontSize: 12.sp,
                color: Colors.grey[600],
              )
            : null,
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16.sp,
          color: Colors.grey[400],
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required Color color,
    required String icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        width: 60.w,
        height: 60.w,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: IconSvg(
            icon,
            color: Colors.white,
            size: 28.sp,
          ),
        ),
      ),
    );
  }
}
