import 'package:budget_tracker_app/controller/home_controller.dart';
import 'package:budget_tracker_app/views/components/insert_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

var controller = Get.put(HomeController());

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Index for BottomNavigationBar
  int _selectedIndex = 0;

  // Pages for Bottom Navigation
  final List<Widget> _pages = [
    Center(child: Text("Home Page", style: TextStyle(fontSize: 30))),
    Center(child: Text("Search Page", style: TextStyle(fontSize: 30))),
    Center(child: Text("Profile Page", style: TextStyle(fontSize: 30))),
  ];

  // Bottom Navigation Bar item tap handler
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         elevation: 12,
         shadowColor: Colors.black.withOpacity(0.3),
         backgroundColor: Colors.blueAccent,
         title: const Text(
           "Namaste, Priyam...",
           style: TextStyle(
               fontWeight: FontWeight.bold, fontSize: 26, color: Colors.white),
         ),
        bottom: PreferredSize(
           preferredSize: Size(double.infinity, 60),
           child: Padding(
             padding: const EdgeInsets.all(10.0),
             child: TextField(
               onChanged: (value) {
                 controller.filterBySearch(value);
               },
               controller: controller.txtSearch,
               decoration: InputDecoration(
                 hintText: 'Search here...',
                 hintStyle: TextStyle(color: Colors.grey.shade600),
                 filled: true,
                 fillColor: Colors.white,
                 suffixIcon: IconButton(
                   onPressed: () {
                     controller.filterBySearch(controller.txtSearch.text);
                   },
                   icon: Icon(Icons.search, color: Colors.blueAccent),
                 ),
                 contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(10),
                   borderSide: BorderSide.none,
                 ),
               ),
             ),
           ),
         ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Card(
                color: Colors.green.shade100,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Income',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                     Obx(() =>  Text(
                       '${controller.income}/-',
                       style: TextStyle(
                           fontWeight: FontWeight.w500,
                           fontSize: 16,
                           letterSpacing: 1),
                     ),),
                    ],
                  ),
                ),
              ),
              Card(
                color: Colors.red.shade100,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Expense',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    Obx(() =>   Text(
                      '${controller.expense}/-',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          letterSpacing: 1),
                    ),),
                    ],
                  ),
                ),
              ),
              Card(
                color: Colors.grey.shade300,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Balance',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                     Obx(() =>  Text(
                       '${controller.balance}/-',
                       style: TextStyle(
                           fontWeight: FontWeight.w500,
                           fontSize: 16,
                           letterSpacing: 1),
                     ),),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                onPressed: () {
                  controller.fetchData();
                },
                child: Text(
                  'All',
                ),
              ),
              OutlinedButton(
                  onPressed: () {
                    controller.filterCategory(1);
                  },
                  child: Text(
                    'Income',
                  )),
              OutlinedButton(
                  onPressed: () {
                    controller.filterCategory(0);
                  },
                  child: Text(
                    'Expanse',
                  )),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Obx(
            () => Expanded(
              child: ListView.builder(
                itemCount: controller.budgetList.length,
                itemBuilder: (context, index) => Card(
                  color: controller.budgetList[index].isIncome == 1
                      ? Colors.green.shade100
                      : Colors.red.shade100,
                  child: ListTile(
                    leading: Text(controller.budgetList[index].id.toString()),
                    title: Text(controller.budgetList[index].amount.toString()),
                    subtitle: Text(
                        "${controller.budgetList[index].category!} - ${controller.budgetList[index].date!}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            editBox(context, controller.budgetList[index]);
                          },
                          icon: const Icon(Icons.edit,
                           color: Colors.blueAccent,),
                        ),
                        IconButton(
                          onPressed: () {
                            controller
                                .deleteData(controller.budgetList[index].id!);
                          },
                          icon: const Icon(Icons.delete,
                           color: Colors.redAccent,),
                        ),
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
      bottomNavigationBar:  BottomNavigationBar(currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money),
            label: 'Income',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            label: 'Expense',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),],),

    );
  }
}


