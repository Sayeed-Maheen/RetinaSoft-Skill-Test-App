import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skill_test_app/utils/app_colors.dart';

import '../controllers/branch_list_controller.dart';
import '../controllers/logout_controller.dart';
import 'create_branch_screen.dart';

class HomeScreen extends StatelessWidget {
  final LogoutController _logoutController = Get.put(LogoutController());
  final BranchController branchController = Get.put(BranchController());

  HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _logoutController.logout();
            },
          ),
        ],
      ),
      body: Obx(
        () {
          if (branchController.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(
                color: colorGreen,
              ),
            );
          } else {
            return RefreshIndicator(
              color: colorGreen,
              onRefresh: () async {
                await branchController.fetchBranches();
              },
              child: branchController.branches.isEmpty
                  ? const Center(
                      child: Text('No branches found'),
                    )
                  : ListView.builder(
                      itemCount: branchController.branches.length,
                      itemBuilder: (context, index) {
                        final branch = branchController.branches[index];
                        return ListTile(
                          title: Text(branch.name),
                          // subtitle: Text('Branch ID: ${branch.id}'),
                        );
                      },
                    ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorGreen,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.r),
        ),
        onPressed: () {
          Get.to(() => CreateBranchScreen());
        },
        child: const Icon(
          Icons.add,
          color: colorWhite,
        ),
      ),
    );
  }
}
