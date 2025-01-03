import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../controller/user_controller.dart';

var userController = Get.put(UserController());

class UserProfileController extends GetxController {
  var username = ''.obs;
  var profileImage = Rxn<File>();

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage.value = File(pickedFile.path);
    }
  }
}

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserProfileController());
    return Scaffold(
      appBar: AppBar(
        elevation: 12,
        shadowColor: Colors.black.withOpacity(0.3),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed('/home');
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.settings,
              color: Colors.white,
            ),
          )
        ],
        title: const Text(
          "User Profile",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 26, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(() {
              return CircleAvatar(
                radius: 60,
                backgroundImage: controller.profileImage.value != null
                    ? FileImage(controller.profileImage.value!)
                    : const AssetImage('assets/profile.jpg') as ImageProvider,
              );
            }),
            ElevatedButton(
              onPressed: () {
                Get.bottomSheet(
                  Container(
                    padding: const EdgeInsets.all(16),
                    color: Colors.white,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: const Text('Pick from Gallery'),
                          onTap: () {
                            controller.pickImage(ImageSource.gallery);
                            Get.back();
                          },
                        ),
                        ListTile(
                          title: const Text('Take a Photo'),
                          onTap: () {
                            controller.pickImage(ImageSource.camera);
                            Get.back();
                          },
                        ),
                      ],
                    ),
                  ),
                  isScrollControlled: true,
                );
              },
              child: const Text('Change Profile Picture'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: userController.txtName,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 20),
            Obx(() {
              return Text(
                'Namaste, ${userController.txtName.text}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              );
            }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // userController.txtName.text
          userController.registerUser(userController.txtName.text);
          Navigator.of(context).pushNamed('/home');
        },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
