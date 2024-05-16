import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';

class CustomButton extends StatefulWidget {
  final void Function()?
      onPressed; // Callback function for when the button is pressed
  final String text; // Text to be displayed on the button
  final bool? loading;
  final Color color;

  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.color,
    this.loading,
  }) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: widget.color, // Set the background color of the container
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: MaterialButton(
        height: 50.h,
        splashColor: Colors.transparent, // Set the splash color of the button
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        onPressed: widget
            .onPressed, // Set the callback function for when the button is pressed
        child: Text(
          widget.text, // Display the text for the button
          style: TextStyle(
            color: colorWhite,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
