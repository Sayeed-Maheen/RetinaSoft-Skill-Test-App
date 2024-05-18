import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/create_customer_supplier_controller.dart';

class CreateCustomerSupplierScreen extends StatefulWidget {
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
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Customer/Supplier'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an address';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _areaController,
                decoration: InputDecoration(labelText: 'Area'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an area';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _postCodeController,
                decoration: InputDecoration(labelText: 'Post Code'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a post code';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _cityController,
                decoration: InputDecoration(labelText: 'City'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a city';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _stateController,
                decoration: InputDecoration(labelText: 'State'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a state';
                  }
                  return null;
                },
              ),
              Obx(
                () => RadioListTile(
                  title: Text('Customer'),
                  value: 0,
                  groupValue: _controller.type,
                  onChanged: (value) {
                    _controller.type = value!;
                  },
                ),
              ),
              Obx(
                () => RadioListTile(
                  title: Text('Supplier'),
                  value: 1,
                  groupValue: _controller.type,
                  onChanged: (value) {
                    _controller.type = value!;
                  },
                ),
              ),
              ElevatedButton(
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
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              '${_controller.type == 0 ? 'Customer' : 'Supplier'} created successfully'),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Failed to create ${_controller.type == 0 ? 'customer' : 'supplier'}'),
                        ),
                      );
                    }
                  }
                },
                child: Text('Create'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
