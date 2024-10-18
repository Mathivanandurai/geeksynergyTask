
import 'package:flutter/material.dart';
import 'package:task/components/constants/custom_colors.dart';

class GetTextStyleTask {

  static TextStyle get styleS20w700Black {
    return const TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.w700,
    );
  }
  static TextStyle get styleS16w500Black {
    return const TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    );
  }
  static TextStyle get styleS20w700Grey {
    return const TextStyle(
      color: Colors.grey,
      fontSize: 20,
      fontWeight: FontWeight.w400,
    );
  }
  static TextStyle get styleS20w700Blue {
    return const TextStyle(
      color: Colors.blueAccent,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle get styleS30w400RedLN12 {
    return const TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    );
  }
  static TextStyle get styleS16w800White {
    return  TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontFamily: FontFamilyPath.nunito,
      letterSpacing: -0.3,
      fontWeight: FontWeight.w800,
    );
  }
  static TextStyle get styleS18w900Black {
    return  TextStyle(
      color: CustomColors.black1F2732,
      fontSize: 18,
      fontFamily: FontFamilyPath.nunito,
      letterSpacing: -0.5,
      fontWeight: FontWeight.w900,
    );
  }
  static TextStyle get styleS14w400Black {
    return  TextStyle(
      color: CustomColors.black1F2732,
      fontSize: 14,
      fontFamily: FontFamilyPath.nunito,
      letterSpacing: 0.3,
      fontWeight: FontWeight.w400,
    );
  }
  static TextStyle get styleS26w900Black {
    return  TextStyle(
      color: CustomColors.black1F2732,
      fontSize: 26,
      fontFamily: FontFamilyPath.nunito,
      letterSpacing: -1,
      fontWeight: FontWeight.w900,
    );
  }
  static TextStyle get styleS18w700Black {
    return  TextStyle(
      color: CustomColors.black1F2732,
      fontSize: 18,
      fontFamily: FontFamilyPath.nunito,
      letterSpacing: 1,
      fontWeight: FontWeight.w700,
    );
  }
  static TextStyle get styleS16w400LightBlue {
    return  TextStyle(
      color: CustomColors.lightBlue,
      fontSize: 16,
      fontFamily: FontFamilyPath.nunito,
      fontWeight: FontWeight.w400,
    );
  }
}


class FontFamilyPath{
  static String nunito="Nunito";
}