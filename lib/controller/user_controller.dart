import 'package:budget_tracker_app/helper/user_db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UserProfileController extends GetxController
{
  var txtName = TextEditingController();
  var txtEmail = TextEditingController();
  var txtPhone = TextEditingController();

  @override
  void onInit()
  {
    super.onInit();
    UserDbHelper.userDbHelper.database;
  }

  Future<void> registerUser(String name,)
  async {

    await UserDbHelper.userDbHelper.insertUser(name,);
  }

}