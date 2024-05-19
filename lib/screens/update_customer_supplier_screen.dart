import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:skill_test_app/widgets/custom_appbar.dart';
import 'package:skill_test_app/widgets/custom_button.dart';
import 'package:skill_test_app/widgets/custom_form_field.dart';
import 'package:skill_test_app/widgets/custom_toast.dart';

import '../controllers/update_customer_supplier_controller.dart';
import '../utils/app_colors.dart';
import '../utils/strings.dart';

class UpdateCustomerSupplierScreen extends StatefulWidget {
  final int customerId;
  final bool isCustomer;

  const UpdateCustomerSupplierScreen({
    super.key,
    required this.customerId,
    required this.isCustomer,
  });

  @override
  _UpdateCustomerSupplierScreenState createState() =>
      _UpdateCustomerSupplierScreenState();
}

class _UpdateCustomerSupplierScreenState
    extends State<UpdateCustomerSupplierScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controller = Get.put(UpdateCustomerSupplierController());
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _areaController = TextEditingController();
  final _postCodeController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.type =
        widget.isCustomer ? 0 : 1; // Initialize type based on isCustomer
    _fetchData();
  }

  Future<void> _fetchData() async {
    // Fetch the customer or supplier data based on the ID
    // and populate the form field controllers
    // You can implement this method to fetch the data from the API
    // and set the controller values accordingly
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: CustomAppBar(
          text: 'Update ${widget.isCustomer ? 'Customer' : 'Supplier'}'),
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
                  title: const Text('Customer'),
                  value: 0,
                  groupValue: _controller.type,
                  onChanged: (value) {
                    if (value != null) {
                      _controller.type = value;
                    }
                  },
                  activeColor: colorGreen,
                ),
              ),
              Obx(
                () => RadioListTile(
                  title: const Text('Supplier'),
                  value: 1,
                  groupValue: _controller.type,
                  onChanged: (value) {
                    if (value != null) {
                      _controller.type = value;
                    }
                  },
                  activeColor: colorGreen,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: REdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: CustomButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              final updateSuccess = await _controller.updateCustomerSupplier(
                widget.customerId,
                _nameController.text,
                _phoneController.text,
                _emailController.text,
                _addressController.text,
                _areaController.text,
                _postCodeController.text,
                _cityController.text,
                _stateController.text,
                widget.isCustomer,
              );

              if (updateSuccess) {
                // Show success message
                CustomToast.showToast("Update successful");
              } else {
                // Show error message
                CustomToast.showToast("Failed to update");
              }
            }
          },
          color: colorGreen,
          text: update,
        ),
      ),
    );
  }
}
