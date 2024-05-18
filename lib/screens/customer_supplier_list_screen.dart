import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:skill_test_app/screens/create_customer_supplier_screen.dart';
import 'package:skill_test_app/utils/app_colors.dart';
import 'package:skill_test_app/widgets/custom_appbar.dart';

import '../controllers/customer_supplier_controller.dart';
import '../utils/strings.dart';

class CustomerSupplierScreen extends StatelessWidget {
  final CustomerSupplierController _controller =
      Get.put(CustomerSupplierController());

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  Future<void> _refreshData() async {
    _controller.fetchCustomers(); // Fetch customers
    _controller.fetchSuppliers(); // Fetch suppliers
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: const CustomAppBar(
          text: customersAndSuppliers,
          bottom: TabBar(
            dividerColor: Colors.transparent,
            indicatorColor: colorWhite,
            labelColor: colorWhite,
            unselectedLabelColor: colorGreenLight,
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
                return const Center(
                  child: CircularProgressIndicator(
                    color: colorGreen,
                  ),
                );
              } else if (_controller.customers.isEmpty) {
                print('Customers list is empty');
                return const Center(child: Text('No customers found'));
              } else {
                print('Customers list length: ${_controller.customers.length}');
                return RefreshIndicator(
                  onRefresh: _refreshData,
                  child: ListView.builder(
                    itemCount: _controller.customers.length,
                    padding: REdgeInsets.only(left: 16, right: 16, top: 16),
                    itemBuilder: (context, index) {
                      final customer = _controller.customers[index];
                      return Container(
                        width: double.infinity,
                        padding: REdgeInsets.all(16),
                        margin: REdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: colorGreenLight,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name: ${capitalize(customer['name'] ?? 'No name')}",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: colorBlack,
                              ),
                            ),
                            Gap(4.h),
                            Text(
                              "Phone: ${capitalize(customer['phone'] ?? 'No phone')}",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: colorBlack,
                              ),
                            ),
                            Gap(2.h),
                            Text(
                              "Balance: ${capitalize(customer['balance'] ?? 'No balance')}",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: colorBlack,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }
            }),
            Obx(
              () {
                if (_controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: colorGreen,
                    ),
                  );
                } else if (_controller.suppliers.isEmpty) {
                  print('Suppliers list is empty');
                  return const Center(child: Text('No suppliers found'));
                } else {
                  print(
                      'Suppliers list length: ${_controller.suppliers.length}');
                  return RefreshIndicator(
                    onRefresh: _refreshData,
                    child: ListView.builder(
                      itemCount: _controller.suppliers.length,
                      padding: REdgeInsets.only(left: 16, right: 16, top: 16),
                      itemBuilder: (context, index) {
                        final supplier = _controller.suppliers[index];
                        return Container(
                          width: double.infinity,
                          padding: REdgeInsets.all(16),
                          margin: REdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: colorGreenLight,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Name: ${capitalize(supplier['name'] ?? 'No name')}",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: colorBlack,
                                ),
                              ),
                              Gap(4.h),
                              Text(
                                "Phone: ${capitalize(supplier['phone'] ?? 'No phone')}",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: colorBlack,
                                ),
                              ),
                              Gap(2.h),
                              Text(
                                "Balance: ${capitalize(supplier['balance'] ?? 'No balance')}",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: colorBlack,
                                ),
                              ),
                            ],
                          ),
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
          backgroundColor: colorGreen,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.r),
          ),
          onPressed: () {
            Get.to(() => CreateCustomerSupplierScreen());
          },
          child: const Icon(
            Icons.add,
            color: colorWhite,
          ),
        ),
      ),
    );
  }
}
