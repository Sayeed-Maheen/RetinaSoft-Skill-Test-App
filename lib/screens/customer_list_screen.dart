import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/customer_controller.dart';

class CustomerListScreen extends StatelessWidget {
  final CustomerSupplierController customerSupplierController =
      Get.put(CustomerSupplierController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer List'),
      ),
      body: CustomerListWidget(),
    );
  }
}

class CustomerListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerSupplierController>(
      builder: (controller) {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.customerList.isEmpty) {
          return Center(child: Text('No customers available'));
        }

        return ListView.builder(
          itemCount: controller.customerList.length,
          itemBuilder: (context, index) {
            final customer = controller.customerList[index];
            return ListTile(
              title: Text(customer['name'] ?? ''), // Null check for name
              subtitle: Text(customer['email'] ?? ''), // Null check for email
            );
          },
        );
      },
    );
  }
}
