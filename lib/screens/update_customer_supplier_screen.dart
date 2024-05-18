import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/update_customer_supplier_controller.dart';

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
      appBar: AppBar(
        title: Text(
          'Update ${widget.isCustomer ? 'Customer' : 'Supplier'}',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Address',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an address';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _areaController,
                decoration: const InputDecoration(
                  labelText: 'Area',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an area';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _postCodeController,
                decoration: const InputDecoration(
                  labelText: 'Post Code',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a post code';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(
                  labelText: 'City',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a city';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _stateController,
                decoration: const InputDecoration(
                  labelText: 'State',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a state';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
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
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Update successful'),
                  ),
                );
              } else {
                // Show error message
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Failed to update'),
                  ),
                );
              }
            }
          },
          child: const Text('Update'),
        ),
      ),
    );
  }
}
