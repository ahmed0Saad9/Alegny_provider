import 'package:flutter/material.dart';
// Radius

const double kNRadius = 12;
const double kNButtonRadius44 = 44;
const double kNButtonRadius41 = 41;
const double kNButtonRadius12 = 12;
const double kNCardRadius6 = 6;
const double kNCardRadius12 = 12;

class AppColors {
  static const Color transparentColor = Colors.transparent;

// colors

  static const Color wight = Color(0xFFFFFFFF);
  static const Color paige = Color(0xFFF9E6AC);

  static const Color secondary = Color(0xff677294);
  static const Color main = Color(0xff50C5C8);

  static const Color darkBackGroung = Color(0xFF0B1427);
  static const Color darkBackGround13 = Color(0xFF131F3A);
  static const Color darkBackGround20 = Color(0xFF20212E);
  static const Color darkBackGround3A = Color(0xFF3A4E7A);
  static const Color scaffoldBackGround = Color(0xFFFFFFFF);
  static const Color backGroundWhite = Color(0xFFFFFFFF);
  static const Color backGroundWhiteF1 = Color(0xFFF1F1F1);
  static const Color backGroundWhiteEA = Color(0xFFEAF8E7);
  static const Color backGroundGrey = Colors.grey;
  static const Color backGroundGreyF7 = Color(0xffF7F7F7);
  static const Color backGroundGreyE5 = Color(0xffE5E5E6);
  static const Color backGroundGreyFD = Color(0xffFDFDFD);
  static const Color backGroundGreyF4 = Color(0xffF4F4F4);
  static const Color backGroundGrey54 = Color(0xff546881);
  static const Color backGroundGreyD9 = Color(0xffD9D9D9);
  static const Color backGroundGreyF2 = Color(0xffF2F2F2);
  static const Color backGroundGreyFE = Color(0xffFEFBF3);
  static const Color backGroundGreen = Color(0xff90C245);
  static const Color backGroundGreen3C = Color(0xff3C8505);
  static const Color backGroundRed = Color(0xFFFF4040);
  static const Color backGroundRedF6 = Color(0xFFFF637B);
  static const Color backGroundRedFD = Color(0xffFD0000);
  static const Color backGroundRedE2 = Color(0xffE23535);
  static const Color backGroundLightGreenF1 = Color(0xffF1F8EC);
  static const Color backGroundLightRedFE = Color(0xffFEF2E8);
  static const Color backGroundLightRedF4 = Color(0xffF4E9E9);
  static const Color backGroundIconGreyF5 = Color(0xFFF5F5F5);
  static const Color backGroundIconGreyF0 = Color(0xFFF0F2F5);
  static const Color backGroundIconWhite = Color(0xFFFFFFFF);
  static const Color backGroundBlue = Color(0xFF1877F2);
  static const Color backGroundOrange = Color(0xFFFA9905);
  static const Color backGroundLightBlue = Color(0xFF03A9F4);

//indicator colors
  static Color dotColor = const Color(0xff023336).withOpacity(0.20);
  static const Color activeDotColor = Color(0xff023336);

  //border color
  static const Color borderGrey = Color(0xffE9EBF8);
  static const Color borderGreyE5 = Color(0xffE5E5E6);
  static const Color borderGrey95 = Color(0xff95979A);
  static const Color borderGreyB2 = Color(0xffB2BBC6);
  static const Color borderGreyB9 = Color(0xffB9B9B9);
  static const Color borderGreyE1 = Color(0xffE1E3F0);
  static const Color borderGreyE9 = Color(0xffE9EBF8);
  static const Color borderGreyE7 = Color(0xffE7E8EE);
  static const Color borderGreyD9 = Color(0xffD9D9D9);
  static const Color borderGreyD0 = Color(0xffD0D2D7);
  static const Color borderGreyD4 = Color(0xffD4D4D4);
  static const Color borderGreyDF = Color(0xffDFDFDF);
  static const Color borderGreyD1 = Color(0xffD1D1D1);
  static const Color borderGrey75 = Color(0xff757D85);
  static const Color borderGreen = Color(0xff90C245);
  static const Color borderGreen3C = Color(0xff3C8505);
  static const Color borderRedFD = Color(0xffFD0000);
  static const Color borderRedF2 = Color(0xffF2572F);
  static const Color borderRedA6 = Color(0xffA63916);

  static const Color borderwhite = Color(0xffffffff);
  static const Color borderBlack0B = Color(0xFF0B1427);

// title color
  static const Color titleGray7A = Color(0xFF7A797A);
  static const Color titleGray62 = Color(0xFF626467);
  static const Color titleMain = Color(0xFF000000);
  static const Color titleSub = Color(0xFF677294);
  static const Color titleGray65 = Color(0xFF656B78);
  static const Color titleGray67 = Color(0xFF677F9E);
  static const Color titleGreyC1 = Color(0xFFC1CAD6);
  static const Color titleGrayCC = Color(0xFFCCE0FF);
  static const Color titleGrayCA = Color(0xFFCACBCD);
  static const Color titleGray54 = Color(0xFF546881);
  static const Color titleGray52 = Color(0xFF525356);
  static const Color titleGray4B = Color(0xFF4B474F);
  static const Color titleGray70 = Color(0xFF707070);
  static const Color titleGray76 = Color(0xFF767676);
  static const Color titleGray47 = Color(0xFF47586E);
  static const Color titleGray99 = Color(0xFF999999);
  static const Color titleGray95 = Color(0xFF959595);
  static const Color titleGray9C = Color(0xFF9CA2AC);
  static const Color titleGray90 = Color(0xFF909DAD);
  static const Color titleGrayAF = Color(0xFFAFAFAF);
  static const Color titleGray83 = Color(0xFF838FA0);
  static const Color titleGray8D = Color(0xFF8D8D8D);
  static const Color titleGray39 = Color(0xFF39434F);
  static const Color titleBlack = Color(0xFF000000);
  static const Color titleBlack25 = Color(0xFF252527);
  static const Color titleBlack10 = Color(0xFF10162E);
  static const Color titleBlack1A = Color(0xFF1A1A1E);
  static const Color titleBlack1F = Color(0xFF1F1926);
  static const Color titleBlack1D = Color(0xFF1D242D);
  static const Color titleBlack3D = Color(0xFF3D4C5E);
  static const Color titleBlack09 = Color(0xFF090A0A);
  static const Color titleBlack0B = Color(0xFF00010F);
  static const Color titleBlack27 = Color(0xFF27364E);
  static const Color titleBlack47 = Color(0xFF47586E);
  static const Color titleWhite = Color(0xFFffffff);
  static const Color titleWhiteF2 = Color(0xFFF2F2F2);
  static const Color titleWhiteD9 = Color(0xFFD9D9D9);

  static const Color titleRedFD = Color(0xFFFD0000);
  static const Color titleRedFF = Color(0xFFFF4947);
  static const Color titleRedE2 = Color(0xFFE23535);
  static const Color titleRedC6 = Color(0xFFC60000);
  static const Color titleRedE1 = Color(0xFFE16565);
  static const Color titleRedB4 = Color(0xFFB42318);
  static const Color titleRedEA = Color(0xFFEA513F);
  static const Color titleGreen = Color(0xFF90C245);
  static const Color titleGreen3C = Color(0xff3C8505);
  static const Color titleGreen28 = Color(0xff28895E);
  static const Color titleDarkGreen = Color(0xFF006E61);
  static const Color titleGold = Color(0xffEEB40B);

  /// Button
  // Button Title Color
  static const Color backGroundButtonMain = Color(0xFF023336);
  static const Color backGroundButtonGrey = Color(0xFFFDFDFD);

  // Button BC color
  static const Color titleButtonMain = Color(0xFF4A4B4D);

  /// SingleChoseCircle color
  static const Color singleChoseCircleUnSelected = Color(0xFFFFFFFF);

// Shimmer colors
  static Color shimmerBaseColor = const Color(0xFFDDDDDD);
  static Color shimmerHighlightColor = const Color(0xFFEBEBEB);

  // Shimmer colors
  static Color errorSnackBar = Colors.red.shade900;
  static Color doneSnackBar = Colors.green.shade900;

  static const Color correctAnswer = Color(0xFF76C499);
  static Color incorrectAnswer = const Color(0xFFD50012);
  static const Color notAnswered = Color(0xFF9E9E9E);

// icon color

  static const Color iconWight = Color(0xFFFFFFFF);
  static const Color iconBlack = Color(0xFF000000);
  static const Color iconGray = Color(0xFF8C8896);
  static const Color iconGray95 = Color(0xFF95979A);
  static const Color iconGray1D = Color(0xFF1D242D);
  static const Color iconGray8D = Color(0xFF8D8D8D);
  static const Color iconGray29 = Color(0xFF292D32);
  static const Color iconGray9C = Color(0xFF9CA2AC);
  static const Color iconGreen = Color(0xFF90C245);
  static const Color iconRed = Color(0xFFE23535);
  static const Color iconYellow = Color(0xFFEEB40B);

// divider color
  static const Color dividerGray = Color(0xFFE4E4E4);
  static const Color dividerGrayC7 = Color(0xFFC7C7C7);
  static const Color dividerGreen = Color(0xFF90C245);
  static const Color dividerGray95 = Color(0xFF95979A);
  static const Color dividerGrayF7 = Color(0xFFF7F7F7);
  static const Color dividerGrayF2 = Color(0xFFF2F2F2);
  static const Color dividerGrayE4 = Color(0xFFE4E4E4);
  static const Color dividerGrayEF = Color(0xFFEFEFF5);
  static const Color dividerGrayB2 = Color(0xFFB2BBC6);
  static const Color dividerGrayD2 = Color(0xFFD2D5D9);
  static const Color dividerGrayD0 = Color(0xFFD0D2D7);
  static const Color dividerGrayDC = Color(0xFFDCDDDF);
  static const Color dividerBlack = Color(0xFF252527);

  static const Color imageBorder = Color(0xFFFFA3A3);
  static const Color titleBarColor = Color(0xFF223E6D);
  static const Color subTitleBarColor = Color(0xFF92A5C6);
  static const Color bottomItemDisableColor = Color(0xFF535353);
  static const Color textColor = Color(0xFF223E6D);
  static const Color lineGray = Color(0xFFE3E5E5);
  static const Color lineGreen = Color(0xff90C245);
  static const Color shadowBlack = Color(0xff000000);

  static const Color dotGray = Color(0xFFF1F1F1);

  static const List<BoxShadow> boxShadow = [
    BoxShadow(
      color: AppColors.lineGreen,
      offset: Offset(1, 4), // Set the shadow offset (x, y)
      spreadRadius: 0,
    ),
  ];
  static List<BoxShadow> boxShadowBlack = [
    BoxShadow(
      color: AppColors.shadowBlack.withOpacity(0.50),
      offset: const Offset(0, 16), // Set the shadow offset (x, y)
      spreadRadius: 0,
      blurRadius: 70,
    ),
  ];
  static List<BoxShadow> cardShadowBlack = [
    BoxShadow(
      color: AppColors.shadowBlack.withOpacity(0.20),
      offset: const Offset(0, 0), // Set the shadow offset (x, y)
      spreadRadius: 0,
      blurRadius: 22,
    ),
  ];
  static List<BoxShadow> linearTimerBackgroundShadow = [
    BoxShadow(
      color: AppColors.shadowBlack.withOpacity(0.25),
      offset: const Offset(0, 1), // Set the shadow offset (x, y)
      spreadRadius: 0,
      blurRadius: 4,
    ),
  ];
  static List<BoxShadow> questionsCardShadow = [
    BoxShadow(
      color: Color(0xff28895E).withOpacity(0.25),
      offset: const Offset(0, 2.27), // Set the shadow offset (x, y)
      spreadRadius: 4.5,
      blurRadius: 14.7,
    ),
  ];
  static List<BoxShadow> answerCardShadow = [
    BoxShadow(
      color: Color(0xff9D57E3).withOpacity(0.25),
      offset: const Offset(0, 2), // Set the shadow offset (x, y)
      spreadRadius: 4,
      blurRadius: 13,
    ),
  ];

  static RadialGradient radialGradient(Color color) => RadialGradient(
        colors: [
          color,
          const Color(0xFF242424),
        ],
        radius: 0.8,
      );

  static Gradient gradientTransparentWhite = LinearGradient(
    colors: [
      AppColors.backGroundWhite.withOpacity(0.13),
      Color(0xff7E7E7E),
    ],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );
}

class TextFieldColors {
// TextField Colors
  static const Color backGround = Colors.transparent;
  static const Color backGroundWhite = Color(0xffFFFFFF);
  static const Color usedBackGround = Color(0xffF2F2F2);
  static const Color activeBackGround = Color(0xFFF2F2F2);
  static const Color hintTitle = Color(0xFF677294);
  static const Color disableTitle = Color(0xFF9CA2AC);

  static const Color mainTitle = Color(0xff0B1427);
  static const Color errorBorder = Color(0xffFD0000);
  static const Color cursor = Color(0xff000000);
  static const Color icon = Color(0xFF677294);
  static const Color suffixIcon = Color(0xFF677294);
  static const Color enableBorder = Color(0xffE7E8EE);
  static const Color focusBorder = Color(0xff50C5C8);
  static const Color searchBorder = Color(0xffE6E6E6);
  static const Color disableBorder = Color(0xffE5E5E6);
  static const Color errorText = Color(0xffFD0000);
}
