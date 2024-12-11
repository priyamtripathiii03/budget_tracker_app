import 'package:budget_tracker_app/views/home_page_dart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> insertBox(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Add Record'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: controller.txtAmount,
            decoration: const InputDecoration(hintText: 'Amount'),
          ),
          TextField(
            controller: controller.txtCategory,
            decoration: const InputDecoration(hintText: 'Category'),
          ),
          Obx(
            () => SwitchListTile(
              title: Text('Income'),
              value: controller.isIncome.value,
              onChanged: (value) {
                controller.switchOfIncome(value);
              },
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Cancel')),
        TextButton(
            onPressed: () {
              int isIncome = controller.isIncome.value ? 1 : 0;
              controller.insertData(double.parse(controller.txtAmount.text),
                  controller.txtCategory.text, isIncome);
              Get.back();
            },
            child: const Text('Insert')),
      ],
    ),
  );
}
