import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:skill_test_app/utils/app_colors.dart';
import 'package:skill_test_app/widgets/custom_appbar.dart';
import 'package:skill_test_app/widgets/custom_button.dart';
import 'package:skill_test_app/widgets/custom_form_field.dart';
import 'package:skill_test_app/widgets/custom_toast.dart';

import '../controllers/create_customer_supplier_controller.dart';
import '../utils/strings.dart';

class CreateCustomerSupplierScreen extends StatefulWidget {
  const CreateCustomerSupplierScreen({super.key});

  @override
  _CreateCustomerSupplierScreenState createState() =>
      _CreateCustomerSupplierScreenState();
}

class _CreateCustomerSupplierScreenState
    extends State<CreateCustomerSupplierScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controller = Get.put(CreateCustomerSupplierController());
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _areaController = TextEditingController();
  final _postCodeController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: const CustomAppBar(text: createCustomerSupplier),
      body: Padding(
        padding: REdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomFormField(
                controller: _nameController,
                hintText: "Enter Name",
                maxlines: 1,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              Gap(16.h),
              CustomFormField(
                controller: _phoneController,
                hintText: "Enter Phone",
                maxlines: 1,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  return null;
                },
              ),
              Gap(16.h),
              CustomFormField(
                controller: _emailController,
                hintText: "Enter Email",
                maxlines: 1,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an email';
                  }
                  return null;
                },
              ),
              Gap(16.h),
              CustomFormField(
                controller: _addressController,
                hintText: "Enter Address",
                maxlines: 1,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an address';
                  }
                  return null;
                },
              ),
              Gap(16.h),
              CustomFormField(
                controller: _areaController,
                hintText: "Enter Area",
                maxlines: 1,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an area';
                  }
                  return null;
                },
              ),
              Gap(16.h),
              CustomFormField(
                controller: _postCodeController,
                hintText: "Enter Post Code",
                maxlines: 1,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a post code';
                  }
                  return null;
                },
              ),
              Gap(16.h),
              CustomFormField(
                controller: _cityController,
                hintText: "Enter City",
                maxlines: 1,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a city';
                  }
                  return null;
                },
              ),
              Gap(16.h),
              CustomFormField(
                controller: _stateController,
                hintText: "Enter State",
                maxlines: 1,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a state';
                  }
                  return null;
                },
              ),
              Obx(
                () => RadioListTile(
                  activeColor: colorGreen,
                  title: const Text('Customer'),
                  value: 0,
                  groupValue: _controller.type,
                  onChanged: (value) {
                    _controller.type = value!;
                  },
                ),
              ),
              Obx(
                () => RadioListTile(
                  activeColor: colorGreen,
                  title: const Text('Supplier'),
                  value: 1,
                  groupValue: _controller.type,
                  onChanged: (value) {
                    _controller.type = value!;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: REdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: CustomButton(
          color: colorGreen,
          text: create,
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              final isSuccess = _controller.type == 0
                  ? await _controller.createCustomer(
                      _nameController.text,
                      _phoneController.text,
                      _emailController.text,
                      _addressController.text,
                      _areaController.text,
                      _postCodeController.text,
                      _cityController.text,
                      _stateController.text,
                    )
                  : await _controller.createSupplier(
                      _nameController.text,
                      _phoneController.text,
                      _emailController.text,
                      _addressController.text,
                      _areaController.text,
                      _postCodeController.text,
                      _cityController.text,
                      _stateController.text,
                    );
              if (isSuccess) {
                CustomToast.showToast(
                    '${_controller.type == 0 ? 'Customer' : 'Supplier'} created successfully');
              } else {
                CustomToast.showToast(
                    'Failed to create ${_controller.type == 0 ? 'customer' : 'supplier'}');
              }
            }
          },
        ),
      ),
    );
  }
}
