import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skill_test_app/screens/create_customer_supplier_screen.dart';

import '../controllers/customer_supplier_controller.dart';

class CustomerSupplierScreen extends StatelessWidget {
  final CustomerSupplierController _controller =
      Get.put(CustomerSupplierController());

  Future<void> _refreshData() async {
    _controller.fetchCustomers(); // Fetch customers
    _controller.fetchSuppliers(); // Fetch suppliers
  }

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
        body: TabBarView(
          children: [
            Obx(() {
              if (_controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else if (_controller.customers.isEmpty) {
                print('Customers list is empty');
                return Center(child: Text('No customers found'));
              } else {
                print('Customers list length: ${_controller.customers.length}');
                return RefreshIndicator(
                  onRefresh: _refreshData,
                  child: ListView.builder(
                    itemCount: _controller.customers.length,
                    itemBuilder: (context, index) {
                      final customer = _controller.customers[index];
                      return ListTile(
                        title: Text(customer['name'] ?? 'No name'),
                      );
                    },
                  ),
                );
              }
            }),
            Obx(
              () {
                if (_controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else if (_controller.suppliers.isEmpty) {
                  print('Suppliers list is empty');
                  return Center(child: Text('No suppliers found'));
                } else {
                  print(
                      'Suppliers list length: ${_controller.suppliers.length}');
                  return RefreshIndicator(
                    onRefresh: _refreshData,
                    child: ListView.builder(
                      itemCount: _controller.suppliers.length,
                      itemBuilder: (context, index) {
                        final supplier = _controller.suppliers[index];
                        return ListTile(
                          title: Text(supplier['name'] ?? 'No name'),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => CreateCustomerSupplierScreen());
          },
        ),
      ),
    );
  }
}
