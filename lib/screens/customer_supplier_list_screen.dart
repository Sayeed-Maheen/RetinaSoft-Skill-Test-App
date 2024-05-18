import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/customer_supplier_controller.dart';

class CustomerSupplierScreen extends StatelessWidget {
  final CustomerSupplierController _controller =
      Get.put(CustomerSupplierController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Customers and Suppliers'),
            bottom: TabBar(
              tabs: [
                Tab(text: 'Customers'),
                Tab(text: 'Suppliers'),
              ],
            ),
          ),
          body: TabBarView(children: [
            Obx(() {
              if (_controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else if (_controller.customers.isEmpty) {
                print('Customers list is empty'); // Add this line
                return Center(child: Text('No customers found'));
              } else {
                print(
                    'Customers list length: ${_controller.customers.length}'); // Add this line
                return ListView.builder(
                  itemCount: _controller.customers.length,
                  itemBuilder: (context, index) {
                    final customer = _controller.customers[index];
                    return ListTile(
                      title: Text(customer['name'] ?? 'No name'),
                    );
                  },
                );
              }
            }),
            Obx(() {
              if (_controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else if (_controller.suppliers.isEmpty) {
                print('Suppliers list is empty'); // Add this line
                return Center(child: Text('No suppliers found'));
              } else {
                print(
                    'Suppliers list length: ${_controller.suppliers.length}'); // Add this line
                return ListView.builder(
                  itemCount: _controller.suppliers.length,
                  itemBuilder: (context, index) {
                    final supplier = _controller.suppliers[index];
                    return ListTile(
                      title: Text(supplier['name'] ?? 'No name'),
                    );
                  },
                );
              }
            }),
          ])),
    );
  }
}
