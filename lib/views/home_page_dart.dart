import 'package:budget_tracker_app/controller/home_controller.dart';
import 'package:budget_tracker_app/views/components/insert_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


var controller = Get.put(HomeController());

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 10,
        shadowColor: Colors.black,
        title: const Text(
          "Namaste, Priyam...",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold,fontSize: 25),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
         
        
        children: [
          Row(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Income',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
                      Divider(),
                      Obx(() =>Text('${controller.income}/-',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,letterSpacing: 1),)),
                    ],
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(onPressed: (){
                controller.fetchData();
              }, child: Text('All',),),
              OutlinedButton(onPressed: (){
             controller.filterCategory(1);
              }, child: Text('Income',)),
              OutlinedButton(onPressed: (){
             controller.filterCategory(0);
              }, child: Text('Expanse',)),
            ],
          ),
          SizedBox(height: 10,),
          
          Obx(
            () => Expanded(
              child: ListView.builder(
                itemCount: controller.budgetList.length,
                itemBuilder: (context, index) => Card(
                  color: controller.budgetList[index].isIncome==1?Colors.green.shade100:Colors.red.shade100,
                  child: ListTile(
                    leading: Text(controller.budgetList[index].id.toString()),
                    title: Text(controller.budgetList[index].amount.toString()),
                    subtitle: Text("${controller.budgetList[index].category!} - ${controller.budgetList[index].date!}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(onPressed: (){
                          editBox(context, controller.budgetList[index]);
                        }, icon: const Icon(Icons.edit),),
                        IconButton(onPressed: (){
                          controller.deleteData(controller.budgetList[index].id!);
                        }, icon: const Icon(Icons.delete),),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          insertBox(context);
          controller.txtCategory.clear();
          controller.txtAmount.clear();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

