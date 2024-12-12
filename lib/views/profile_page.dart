import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back,color: Colors.white,),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.settings,color: Colors.white,),
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
                    : AssetImage('assets/profile.jpg') as ImageProvider,
                child: controller.profileImage.value == null
                    ? Icon(Icons.person, size: 60, color: Colors.white)
                    : null,
              );
            }),
            ElevatedButton(
              onPressed: () {
                Get.bottomSheet(
                  Container(
                    padding: EdgeInsets.all(16),
                    color: Colors.white,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: Text('Pick from Gallery'),
                          onTap: () {
                            controller.pickImage(ImageSource.gallery);
                            Get.back();
                          },
                        ),
                        ListTile(
                          title: Text('Take a Photo'),
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
              child: Text('Change Profile Picture'),
            ),
            SizedBox(height: 20),
            TextField(
              onChanged: (value) {
                controller.username.value = value;
              },
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 20),
            Obx(() {
              return Text(
                'Namaste, ${controller.username.value}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              );
            }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.of(context).pushNamed('/home');
        },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}