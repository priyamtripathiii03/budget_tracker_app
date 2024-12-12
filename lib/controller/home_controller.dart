import 'dart:developer';

import 'package:budget_tracker_app/helper/db_helper.dart';
import 'package:budget_tracker_app/modal/budget_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  TextEditingController txtAmount = TextEditingController();
  TextEditingController txtCategory = TextEditingController();
  TextEditingController txtSearch = TextEditingController();

  RxList<Budget> budgetList = <Budget>[].obs;
  RxDouble income = 0.0.obs;
  RxDouble expense = 0.0.obs;
  RxDouble balance = 0.0.obs;
  RxBool isIncome = false.obs;

  @override
  Future<void> onInit() async {
    //   TODO: implement onInit
    await DbHelper.dbHelper.database;
    fetchData();
    super.onInit();
  }

  void switchOfIncome(bool value) {
    isIncome.value = value;
  }

  Future<void> insertData(double amount, String category, int isIncome) async {
    DateTime date = DateTime.now();
    await DbHelper.dbHelper.insertRecord(
        amount, category, "${date.day}-${date.month}-${date.year}", isIncome);
    await fetchData();
  }

  Future<void> deleteData(int id) async {
    await DbHelper.dbHelper.deleteRecord(id);
    await fetchData();
  }

  Future<void> fetchData() async {
    List records = await DbHelper.dbHelper.fetchRecords();
    budgetList.value = records
        .map(
          (e) => Budget.fromMap(e),
        )
        .toList();
    calculateBalance();
  }

  Future<void> updateData(int id, isIncome, double amount, category) async {
    DateTime date = DateTime.now();
    log('update');
    await DbHelper.dbHelper.updateRecord(id, isIncome, amount,
        "${date.day}-${date.month}-${date.year}", category);
    fetchData();
  }

  Future<void> filterCategory(int isIncome) async {
    List records = await DbHelper.dbHelper.filterCategory(isIncome);
    budgetList.value = records
        .map(
          (e) => Budget.fromMap(e),
        )
        .toList();
  }

  // todo filter by search
  Future<void> filterBySearch(String search)
  async {
   List data = await DbHelper.dbHelper.filterBySearch(search);
   budgetList.value = data.map((e) => Budget.fromMap(e),).toList();
  }

  void calculateBalance() {
    income.value = 0.0;
    balance.value = 0.0;
    expense.value = 0.0;

    for (var record in budgetList) {
      if (record.isIncome == 1) {
        income.value += record.amount!;
      } else {
        expense.value += record.amount!;
      }
    }
    balance.value = income.value - expense.value;
  }
}
