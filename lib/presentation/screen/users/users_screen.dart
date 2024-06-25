import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:test_it_maha/domain/entity/users/users_entity.dart';
import 'package:test_it_maha/presentation/screen/users/users_controller.dart';
import 'package:toast/toast.dart';

class UsersScreen extends GetView<UsersController> {

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Data User', style: TextStyle(color: Colors.white),),
        centerTitle: false,
        backgroundColor: Colors.blue,
      ),
      body: SmartRefresher(
        controller: controller.refreshController,
        onRefresh: () {
          controller.getUsers();
          controller.refreshController.refreshCompleted();
        },
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.w),
            width: 1.sw,
            child: _buildBody(),
          ),
        )
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () => Get.bottomSheet(
          isScrollControlled: true,
            isDismissible: true,
            enableDrag: true,
            _buildFAB()
        ),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Obx(() => controller.usersData.value.maybeWhen(
        initial: () => SizedBox(),
        loading: () => ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) {
            return SkeletonAnimation(
              child: Container(
                width: 1.sw,
                height: 60.h,
                padding: EdgeInsets.all(16.w),
                margin: EdgeInsets.only(bottom: 10.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: Colors.grey[300],
                ),
              )
            );
          },
        ),
        success: (data) => data.isEmpty ? Center(child: Text("Data Kosong"),) : ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Container(
              width: 1.sw,
              padding: EdgeInsets.all(16.w),
              margin: EdgeInsets.only(bottom: 10.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: Colors.white
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAvatar(data[index]),
                  SizedBox(width: 8.w,),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${data[index].firstName} ${data[index].lastName}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 4.h,),
                        Text(
                          '${data[index].email}',
                          style: TextStyle(
                            color: Colors.grey
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
        error: (message) => Center(
          child: GestureDetector(
            onTap: () => controller.getUsers,
            child: Text(
              "$message\nCoba Lagi?"
            ),
          ),)
    ));
  }

  Widget _buildAvatar(DataEntity data) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40.r),
      child: Image.network(
        '${data.avatar}',
        width: 40.w,
        height: 40.h,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return SkeletonAnimation(
              child: Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(40.r)
                ),
              )
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(40.r)
            ),
            child: Center(
              child: Icon(
                  Icons.error_outline
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFAB() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(20.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Tambah User",
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 16.h,),
          TextField(
            controller: controller.firstNameTEC,
            decoration: InputDecoration(
              label: Text('First Name')
            ),
          ),
          SizedBox(height: 16.h,),
          TextField(
            controller: controller.lastNameTEC,
            decoration: InputDecoration(
                label: Text('Last Name')
            ),
          ),
          SizedBox(height: 16.h,),
          TextField(
            controller: controller.emailTEC,
            decoration: InputDecoration(
                label: Text('Email')
            ),
          ),
          SizedBox(height: 16.h,),
          SizedBox(
            width: 1.sw,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              onPressed: () {
                Get.back();
                controller.addUsers(
                  onSuccess: () => Toast.show("Berhasil disimpan", duration: Toast.lengthShort, gravity:  Toast.bottom),
                  onError: (message) => Toast.show("$message", duration: Toast.lengthShort, gravity:  Toast.bottom),
                );
              },
              child: Text('Simpan'),
            ),
          )
        ],
      ),
    );
  }
}