import 'package:budget_tracker_app/controller/home_controller.dart';
import 'package:budget_tracker_app/views/components/insert_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'profile_page.dart';

var controller = Get.put(HomeController());
var usercontroller = Get.put(UserProfileController());

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  var username = ''.obs;

  final List<Widget> _pages = <Widget>[
    Center(child: Text("Home Page", style: TextStyle(fontSize: 30))),
    Center(child: Text("Income Page", style: TextStyle(fontSize: 30))),
    Center(child: Text("Expense Page", style: TextStyle(fontSize: 30))),
    // Placeholder for Profile page
    Container(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 3) {
      Get.toNamed('/profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 12,
        shadowColor: Colors.black.withOpacity(0.3),
        backgroundColor: Colors.blueAccent,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed('/');
          },
          child: Icon(
            Icons.person,
            color: Colors.white,
          ),
        ),
        title: Obx(
          () => Text(
            'Namaste, ${usercontroller.username.value}',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 26, color: Colors.white),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 60),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: (value) => controller.filterBySearch(value),
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
                  icon: const Icon(Icons.search, color: Colors.blueAccent),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.blue.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(
                () => Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: controller.balance > 0
                          ? Colors.green.shade200
                          : Colors.red.shade200,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(25),
                    gradient: controller.balance > 0
                        ? LinearGradient(colors: [
                            Colors.green.shade400,
                            Colors.green.shade100,
                            Colors.white
                          ])
                        : LinearGradient(colors: [
                            Colors.red.shade400,
                            Colors.red.shade100,
                            Colors.white
                          ]),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    "Balance: ${controller.balance}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: controller.balance > 0
                          ? Colors.green.shade800
                          : Colors.red.shade800,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 240,
              width: 430,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage(
                      'assets/profile.jpg',
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "\$${controller.balance}",
                    style: const TextStyle(
                      letterSpacing: 1,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Obx(
                        () => Text(
                          '${usercontroller.username.value}'.toUpperCase(),
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "DATE: ",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          letterSpacing: 1,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "22-12-2024",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        controller.fetchData();
                      },
                      child: const Text(
                        'All',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        controller.filterCategory(1);
                      },
                      child: const Text(
                        'Income',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        controller.filterCategory(0);
                      },
                      child: const Text(
                        'Expense',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.budgetList.length,
                  itemBuilder: (context, index) {
                    final item = controller.budgetList[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 6,
                      shadowColor: Colors.black.withOpacity(0.3),
                      color: item.isIncome == 1
                          ? Colors.green.shade100
                          : Colors.red.shade100,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: item.isIncome == 1
                              ? Colors.green.shade400
                              : Colors.red.shade400,
                          child: Icon(
                            item.isIncome == 1
                                ? Icons.arrow_upward
                                : Icons.arrow_downward,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(
                          "\$${item.amount}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: item.isIncome == 1
                                ? Colors.green.shade800
                                : Colors.red.shade800,
                          ),
                        ),
                        subtitle: Text("${item.category} - ${item.date}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                editBox(context, item);
                              },
                              icon: const Icon(Icons.edit,
                                  color: Colors.blueAccent),
                            ),
                            IconButton(
                              onPressed: () {
                                controller.deleteData(item.id!);
                              },
                              icon: const Icon(Icons.delete,
                                  color: Colors.redAccent),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          insertBox(context);
          controller.txtCategory.clear();
          controller.txtAmount.clear();
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          _onItemTapped(index);
          setState(() {
            _selectedIndex = index;
          });
        },
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
          ),
        ],
      ),
    );
  }
}
