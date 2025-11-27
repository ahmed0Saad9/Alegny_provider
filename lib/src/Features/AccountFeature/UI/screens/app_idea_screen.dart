import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Appbars/app_bars.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Other/base_scaffold.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';
import 'package:Alegny_provider/src/core/constants/sizes.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AppIdeaScreen extends StatefulWidget {
  const AppIdeaScreen({super.key});

  @override
  State<AppIdeaScreen> createState() => _AppIdeaScreenState();
}

class _AppIdeaScreenState extends State<AppIdeaScreen> {
  late YoutubePlayerController _youtubeController;
  bool _isLoading = true;
  bool _hasError = false;

  // YouTube video URL
  final String videoUrl = 'https://youtu.be/CR7DWj8W8m4?si=3qXpQbHwYd4dT87d';

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    // Reset to all orientations when leaving screen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  void _initializePlayer() {
    try {
      // Extract video ID from YouTube URL
      final videoId = YoutubePlayer.convertUrlToId(videoUrl);

      if (videoId != null) {
        _youtubeController = YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(
            autoPlay: false,
            mute: false,
            enableCaption: false,
            loop: false,
            isLive: false,
            forceHD: false,
            controlsVisibleAtStart: false,
          ),
        );

        setState(() {
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          _hasError = true;
        });
      }
    } catch (e) {
      print('Error initializing YouTube player: $e');
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _youtubeController,
        showVideoProgressIndicator: true,
        progressIndicatorColor: AppColors.main,
        progressColors: ProgressBarColors(
          playedColor: AppColors.main,
          handleColor: AppColors.main,
          bufferedColor: Colors.grey[300]!,
          backgroundColor: Colors.grey[600]!,
        ),
        onReady: () {
          print('YouTube Player is ready');
        },
        onEnded: (data) {
          print('Video ended');
        },
      ),
      builder: (context, player) {
        return BaseScaffold(
          appBar: AppBars.appBarBack(title: 'app_idea'.tr),
          body: SingleChildScrollView(
            padding: AppPadding.paddingScreenSH16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                30.ESH(),
                _buildVideoSection(player),
                40.ESH(),
                _buildAppDescriptionSection(),
                40.ESH(),
                _buildFeaturesSection(),
                40.ESH(),
                _buildHowItWorksSection(),
                40.ESH(),
                _buildTargetAudienceSection(),
                40.ESH(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildVideoSection(Widget player) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Row(
              children: [
                Icon(
                  Icons.play_circle_outline,
                  color: AppColors.main,
                  size: 24.w,
                ),
                12.ESW(),
                Expanded(
                  child: CustomTextL(
                    'watch_demo'.tr,
                    fontSize: 20.sp,
                    fontWeight: FW.bold,
                    color: AppColors.main,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: _buildVideoPlayer(player),
            ),
          ),
          20.ESH(),
        ],
      ),
    );
  }

  Widget _buildVideoPlayer(Widget player) {
    if (_isLoading) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          color: Colors.black,
          child: const Center(
            child: CircularProgressIndicator(
              color: AppColors.main,
            ),
          ),
        ),
      );
    }

    if (_hasError) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          color: Colors.grey[300],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 48.sp,
                color: Colors.red,
              ),
              12.ESH(),
              CustomTextL(
                'video_load_error'.tr,
                fontSize: 14.sp,
                color: Colors.red,
              ),
              16.ESH(),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _isLoading = true;
                    _hasError = false;
                  });
                  _initializePlayer();
                },
                icon: const Icon(Icons.refresh),
                label: CustomTextL(
                  'retry'.tr,
                  fontSize: 14.sp,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.main,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return player;
  }

  // ... Keep all your other existing methods (_buildAppDescriptionSection, etc.)
  Widget _buildAppDescriptionSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.medical_services,
                color: AppColors.main,
                size: 24.w,
              ),
              12.ESW(),
              CustomTextL(
                'about_app'.tr,
                fontSize: 22.sp,
                fontWeight: FW.bold,
                color: AppColors.main,
              ),
            ],
          ),
          16.ESH(),
          CustomTextL(
            'app_description'.tr,
            fontSize: 16.sp,
            color: AppColors.titleGray7A,
          ),
          16.ESH(),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColors.main.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.main.withOpacity(0.2)),
            ),
            child: CustomTextL(
              'app_description_arabic'.tr,
              fontSize: 15.sp,
              color: AppColors.titleGray7A,
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.main.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.main.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.star_outline,
                color: AppColors.main,
                size: 24.w,
              ),
              12.ESW(),
              CustomTextL(
                'key_features'.tr,
                fontSize: 20.sp,
                fontWeight: FW.bold,
                color: AppColors.main,
              ),
            ],
          ),
          20.ESH(),
          _buildFeatureItem(
              'service_management'.tr, Icons.medical_services_outlined),
          16.ESH(),
          _buildFeatureItem(
              'discount_management'.tr, Icons.local_offer_outlined),
          16.ESH(),
          _buildFeatureItem('multi_branch_support'.tr, Icons.business_outlined),
          16.ESH(),
          _buildFeatureItem('professional_profile'.tr, Icons.person_outline),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String text, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36.w,
          height: 36.w,
          decoration: BoxDecoration(
            color: AppColors.main.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 18.w,
            color: AppColors.main,
          ),
        ),
        12.ESW(),
        Expanded(
          child: CustomTextL(
            text,
            fontSize: 15.sp,
            color: AppColors.titleGray7A,
          ),
        ),
      ],
    );
  }

  Widget _buildHowItWorksSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.work_outline,
                color: AppColors.titleGray7A,
                size: 24.w,
              ),
              12.ESW(),
              CustomTextL(
                'for_providers'.tr,
                fontSize: 20.sp,
                fontWeight: FW.bold,
                color: AppColors.titleGray7A,
              ),
            ],
          ),
          20.ESH(),
          _buildStepItem('1', 'create_profile'.tr),
          16.ESH(),
          _buildStepItem('2', 'add_services'.tr),
          16.ESH(),
          _buildStepItem('3', 'set_prices_discounts'.tr),
        ],
      ),
    );
  }

  Widget _buildStepItem(String stepNumber, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 30.w,
          height: 30.w,
          decoration: const BoxDecoration(
            color: AppColors.main,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: CustomTextL(
              stepNumber,
              fontSize: 14.sp,
              color: Colors.white,
              fontWeight: FW.bold,
            ),
          ),
        ),
        12.ESW(),
        Expanded(
          child: CustomTextL(
            text,
            fontSize: 15.sp,
            color: AppColors.titleGray7A,
          ),
        ),
      ],
    );
  }

  Widget _buildTargetAudienceSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextL(
            'target_audience'.tr,
            fontSize: 18.sp,
            fontWeight: FW.bold,
            color: AppColors.titleGray7A,
          ),
          16.ESH(),
          _buildAudienceItem('doctors'.tr, Icons.medical_services),
          _buildAudienceItem('clinics'.tr, Icons.local_hospital),
          _buildAudienceItem('hospitals'.tr, Icons.business),
          _buildAudienceItem('human_pharmacy'.tr, Icons.local_pharmacy),
          _buildAudienceItem('veterinarians'.tr, Icons.pets),
          _buildAudienceItem('veterinary_pharmacy'.tr, Icons.pets),
          _buildAudienceItem('gym'.tr, Icons.pets),
          _buildAudienceItem('optics'.tr, Icons.pets),
        ],
      ),
    );
  }

  Widget _buildAudienceItem(String text, IconData icon) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18.w,
            color: AppColors.main,
          ),
          12.ESW(),
          CustomTextL(
            text,
            fontSize: 14.sp,
            color: AppColors.titleGray7A,
          ),
        ],
      ),
    );
  }
}
