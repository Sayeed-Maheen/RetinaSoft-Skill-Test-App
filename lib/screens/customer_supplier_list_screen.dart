import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/custom_appbar.dart';
import 'customer_list_screen.dart';

class CustomerSupplierListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: 'Customer/Supplier'),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Get.to(() => CustomerListScreen());
            },
            child: Text('View Customers'),
          ),
          ElevatedButton(
            onPressed: () {
              // Get.to(() => SupplierListScreen());
            },
            child: Text('View Suppliers'),
          ),
        ],
      ),
    );
  }
}
