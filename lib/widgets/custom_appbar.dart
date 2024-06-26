import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../utils/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final Widget? action;
  final PreferredSizeWidget? bottom; // Optional bottom property

  const CustomAppBar({Key? key, required this.text, this.action, this.bottom})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      flexibleSpace: Container(
        color: colorGreen,
      ),
      titleSpacing: -1,
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(
          Icons.arrow_back,
          color: colorWhite,
        ),
      ),
      actions: action != null ? [action!] : null,
      title: Text(
        text,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: colorWhite,
        ),
      ),
      bottom: bottom, // Add bottom to AppBar
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0.0));
}
