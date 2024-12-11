 import 'package:budget_tracker_app/helper/db_helper.dart';
import 'package:budget_tracker_app/modal/budget_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController
{
  TextEditingController txtAmount = TextEditingController();
  TextEditingController txtCategory = TextEditingController();

  RxList<Budget> budgetList =<Budget>[].obs;
  RxBool isIncome = false.obs;

  @override
 Future<void> onInit() async {
  //   TODO: implement onInit
    await DbHelper.dbHelper.database;
    fetchData();
    super.onInit();
  }

  void switchOfIncome(bool value)
  {
    isIncome.value = value;
  }

  Future<void> insertData(double amount,String category,int isIncome)
  async {
    await DbHelper.dbHelper
        .insertRecord(amount,category, DateTime.now().toString(),isIncome);
    fetchData();
  }

  Future<void> deleteData(int id)
  async {
   await DbHelper.dbHelper.deleteRecord(id);
   fetchData();
  }

  Future<void> fetchData()
  async {
  List records = await DbHelper.dbHelper.fetchRecords();
 budgetList.value = records.map((e) => Budget.fromMap(e),).toList();
  }
}