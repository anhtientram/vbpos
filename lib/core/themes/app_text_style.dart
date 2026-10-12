import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

final class AppTextStyle {
  static final AppTextStyle _instance = AppTextStyle._();

  AppTextStyle._();

  factory AppTextStyle() => _instance;

  // ─── Headings ───────────────────────────────────────────────
  TextStyle get heading1 => GoogleFonts.barlow(
    color: AppColors.secondary500,
    fontSize: 31.sp,
    fontWeight: FontWeight.w600,
    height: 1,
  );

  TextStyle get heading2 => GoogleFonts.barlow(
    color: AppColors.primary900,
    fontSize: 25.sp,
    fontWeight: FontWeight.w600,
    height: 1,
  );

  TextStyle get heading3 => GoogleFonts.barlow(
    color: AppColors.neutral13,
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );

  TextStyle get heading4 => GoogleFonts.barlow(
    color: AppColors.neutral1,
    fontSize: 17.sp,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );
 TextStyle get heading5 => GoogleFonts.barlow(
    color: AppColors.neutral1,
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
    height: 1.2,
  );

  // ─── Footnote ───────────────────────────────────────────────
  TextStyle get footnote => GoogleFonts.barlow(
    color: AppColors.neutral1,
    fontSize: 16.sp,
    fontWeight: FontWeight.w300,
    letterSpacing: 0.1,
    height: 0.8,
  );

  // ─── XLarge (20px) ──────────────────────────────────────────
  TextStyle get bodyXLargeMedium => GoogleFonts.barlow(
    color: AppColors.neutral13,
    fontSize: 20.sp,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  TextStyle get bodyXLargeRegular => GoogleFonts.barlow(
    color: AppColors.neutral13,
    fontSize: 20.sp,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );

  TextStyle get bodyXLStrong => GoogleFonts.barlow(
    color: AppColors.neutral1,
    fontSize: 18.sp,
    height: 1.4,
    fontWeight: FontWeight.w600,
  );

  // ─── Large (18px) ───────────────────────────────────────────
  TextStyle get bodyLargeMedium => GoogleFonts.barlow(
    color: AppColors.neutral13,
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  TextStyle get bodyLargeRegular => GoogleFonts.barlow(
    color: AppColors.neutral1,
    fontSize: 18.sp,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );

  TextStyle get bodyLargeBold => GoogleFonts.barlow(
    color: AppColors.neutral13,
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  TextStyle get bodyLGNormal => GoogleFonts.barlow(
    color: AppColors.neutral1,
    fontSize: 16.sp,
    height: 1.25,
    fontWeight: FontWeight.w500,
    // thay đổi từ 400 -> 500
  );
  TextStyle get bodyLGItalic => GoogleFonts.barlow(
    color: AppColors.neutral1,
    fontSize: 16.sp,
    height: 1.25,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
    // thay đổi từ 400 -> 500
  );
  TextStyle get bodyLGStrong => GoogleFonts.barlow(
    color: AppColors.neutral1,
    fontSize: 16.sp,
    height: 1.25,
    fontWeight: FontWeight.w500,
  );
  TextStyle get bodyLGStrong600 => GoogleFonts.barlow(
    color: AppColors.neutral1,
    fontSize: 16.sp,
    height: 1.25,
    fontWeight: FontWeight.w600,
  );

  // ─── Medium (16px) ──────────────────────────────────────────
  TextStyle get bodyMediumMedium => GoogleFonts.barlow(
    color: AppColors.neutral13,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  TextStyle get bodyMediumRegular => GoogleFonts.barlow(
    color: AppColors.neutral13,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );

  TextStyle get bodyMediumBold => GoogleFonts.barlow(
    color: AppColors.neutral13,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );
  TextStyle get bodyLGUnderline => GoogleFonts.barlow(
    color: AppColors.neutral9,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    decoration: TextDecoration.underline,
    decorationColor: AppColors.neutral9,
    height: 1.4,
  );
  TextStyle get subtitleLGStrong => GoogleFonts.barlow(
    color: AppColors.neutral1,
    fontSize: 16.sp,
    height: 1,
    fontWeight: FontWeight.w500,
  );

  // ─── Small (14px) ───────────────────────────────────────────
  TextStyle get bodySmallMedium => GoogleFonts.barlow(
    color: AppColors.neutral13,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  TextStyle get bodySmallRegular => GoogleFonts.barlow(
    color: AppColors.neutral13,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );

  TextStyle get bodySmallBold => GoogleFonts.barlow(
    color: AppColors.neutral13,
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  TextStyle get bodySMNormal => GoogleFonts.barlow(
    color: AppColors.neutral1,
    fontSize: 14.sp,
    height: 1.25,
    fontWeight: FontWeight.w400,
  );

  TextStyle get bodySMStrong => GoogleFonts.barlow(
    color: AppColors.neutral1,
    fontSize: 14.sp,
    height: 1.25,
    fontWeight: FontWeight.w500,
  );
  TextStyle get bodyXSStrong => GoogleFonts.barlow(
    color: AppColors.neutral1,
    fontSize: 12.sp,
    height: 1.12,
    fontWeight: FontWeight.w600,
  );
}
