import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'utils/app_colors.dart';

class ScrapCodes extends StatelessWidget {
  const ScrapCodes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        // statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return Column(
      children: [
        //backgroundColor: AppColors.colorWhiteHighEmp,
        AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          flexibleSpace: Container(
            color: colorWhite, // Set a fixed color here
          ),
          titleSpacing: -1,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back,
              color: colorBlack,
            ),
          ),
          title: Text(
            "text",
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: colorBlack,
            ),
          ),
        ),
        Text(
          "Terms of use  & Privacy Policy",
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: colorBlack,
          ),
        ),
        // SvgPicture.asset(
        //   "assets/images/appLogo.svg",
        //   height: 87.h,
        //   width: 96.w,
        // ),

        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 24.sp,
              color: colorBlack,
            ),
            children: const [
              TextSpan(
                text: "WALL",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                ),
              ),
              TextSpan(
                text: "PERS",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(width: 16.w),
        NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overScroll) {
            overScroll.disallowIndicator();
            return true;
          },
          child: const SingleChildScrollView(),
        ),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
              padding: const EdgeInsets.all(8),
              minimumSize: const Size(50, 20),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap),
          child: Text(
            'forgotPassword',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: colorBlack,
            ),
          ),
        ),
        InkWell(
          onTap: () {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => const SigninScreen()));
          },
        ),
        InkWell(
          onTap: () {
            // Navigator.pushAndRemoveUntil(
            //     context,
            // MaterialPageRoute(
            //     builder: (BuildContext context) => const SigninScreen()),
            // ModalRoute.withName('/'));
          },
        ),
        Image.asset(
          "assets/images/drop1.png",
          height: 70.h,
          width: 73.w,
          fit: BoxFit.fill,
        ),
        InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(4.r),
          child: Container(
            height: 26.33.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: colorGreen,
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Center(
              child: Text(
                "buyNow",
                style: TextStyle(
                  fontSize: 8.sp,
                  fontWeight: FontWeight.w500,
                  color: colorWhite,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
