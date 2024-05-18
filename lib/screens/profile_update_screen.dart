import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/user_profile_controller.dart';

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
      appBar: AppBar(
        title: Text('Update Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfilePhotoChangeModel(
              selectedImagePath: selectedImagePath,
              onImageSelected: (imagePath) {
                setState(() {
                  selectedImagePath = imagePath;
                });
              },
            ),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              controller: _businessTypeIdController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Business Type ID'),
            ),
            SizedBox(height: 20),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await controller.updateProfile(
                  name: _nameController.text,
                  businessTypeId:
                      int.tryParse(_businessTypeIdController.text) ?? 0,
                  imagePath: selectedImagePath,
                );
                Get.back();
              },
              child: Text('Update Profile'),
            ),
          ],
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
      height: 103.h,
      width: 103.w,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Center(
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[200],
              ),
              child: selectedImagePath.isEmpty
                  ? Icon(Icons.person, size: 50, color: Colors.grey[400])
                  : ClipOval(
                      child: Image.file(
                        File(selectedImagePath),
                        height: 100,
                        width: 100,
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
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: Icon(Icons.camera_alt, color: Colors.white),
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
