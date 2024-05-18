import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skill_test_app/utils/app_colors.dart';
import 'package:skill_test_app/widgets/custom_appbar.dart';
import 'package:skill_test_app/widgets/custom_button.dart';
import 'package:skill_test_app/widgets/custom_form_field.dart';
import 'package:skill_test_app/widgets/custom_toast.dart';

import '../controllers/user_profile_controller.dart';
import '../utils/strings.dart';

class ProfileUpdateScreen extends StatefulWidget {
  const ProfileUpdateScreen({super.key});

  @override
  State<ProfileUpdateScreen> createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  final ProfileController controller = Get.put(ProfileController());

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _businessTypeIdController =
      TextEditingController();
  String selectedImagePath = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: const CustomAppBar(text: updateProfile),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ProfilePhotoChangeModel(
                selectedImagePath: selectedImagePath,
                onImageSelected: (imagePath) {
                  setState(() {
                    selectedImagePath = imagePath;
                  });
                },
              ),
            ),
            Gap(24.h),
            CustomFormField(
              controller: _nameController,
              hintText: "Enter Name",
              maxlines: 1,
            ),
            Gap(16.h),
            CustomFormField(
              controller: _businessTypeIdController,
              hintText: "Enter Business Type ID",
              maxlines: 1,
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: REdgeInsets.all(16),
        child: CustomButton(
          color: colorGreen,
          text: updateProfile,
          onPressed: () async {
            // Check if name and business type ID fields are empty
            if (_nameController.text.isEmpty ||
                _businessTypeIdController.text.isEmpty) {
              // Show toast indicating fields are empty
              CustomToast.showToast("Error. ${'Please fill all the fields'}");
            } else {
              // All fields are filled, proceed with update
              await controller.updateProfile(
                name: _nameController.text,
                businessTypeId:
                    int.tryParse(_businessTypeIdController.text) ?? 0,
                imagePath: selectedImagePath,
              );
              Get.back();
            }
          },
        ),
      ),
    );
  }
}

class ProfilePhotoChangeModel extends StatelessWidget {
  final String selectedImagePath;
  final Function(String) onImageSelected;

  const ProfilePhotoChangeModel({
    required this.selectedImagePath,
    required this.onImageSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110.w,
      width: 110.w,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Center(
            child: Container(
              height: 105,
              width: 105,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[200],
              ),
              child: selectedImagePath.isEmpty
                  ? Icon(Icons.person, size: 50, color: Colors.grey[400])
                  : ClipOval(
                      child: Image.file(
                        File(selectedImagePath),
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              String imagePath = await selectImageFromGallery();
              onImageSelected(imagePath);
            },
            child: Container(
              height: 30,
              width: 30,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: colorGreen,
              ),
              child: const Icon(
                Icons.camera_alt,
                color: colorWhite,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<String> selectImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    return pickedFile?.path ?? '';
  }
}
