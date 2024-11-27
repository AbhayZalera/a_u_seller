// import 'dart:io';
// import 'package:a_u_seller/controller/profile_controller.dart';
// import 'package:a_u_seller/views/widgets/custom_textfield.dart';
// import 'package:a_u_seller/views/widgets/loading_indicator.dart';
// import 'package:a_u_seller/views/widgets/text_style.dart';
// import 'package:get/get.dart';
// import '../../const/const.dart';
//
// class EditProfileScreen extends StatefulWidget {
//   final String? username;
//
//   const EditProfileScreen({super.key, this.username});
//
//   @override
//   State<EditProfileScreen> createState() => _EditProfileScreenState();
// }
//
// class _EditProfileScreenState extends State<EditProfileScreen> {
//   var controller = Get.find<ProfileController>();
//
//   @override
//   void initState() {
//     super.initState();
//     controller.nameController.text = widget.username ?? '';
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: purpleColor,
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             Get.back();
//           },
//           icon: const Icon(
//             Icons.arrow_back,
//             color: white,
//           ),
//         ),
//         title: boldText(text: settings, size: 16.0),
//         actions: [
//           TextButton(
//             onPressed: () async {
//               controller.isloading(true);
//               try {
//                 // Handle image upload
//                 if (controller.profileImgPath.value.isNotEmpty) {
//                   await controller.uploadProfileImage();
//                 } else {
//                   controller.profileImageLink =
//                       controller.snapshotData['imageUrl'];
//                 }
//
//                 // Handle password update
//                 if (controller.oldPassController.text.isNotEmpty) {
//                   if (controller.snapshotData['password'] ==
//                       controller.oldPassController.text) {
//                     String updatedPassword =
//                         controller.newPassController.text.isNotEmpty
//                             ? controller.newPassController.text
//                             : controller.snapshotData['password'];
//
//                     await controller.changeAuthPassword(
//                       email: controller.snapshotData['email'],
//                       password: controller.oldPassController.text,
//                       newPassword: updatedPassword,
//                     );
//
//                     // Update profile details
//                     await controller.updateProfile(
//                       imageUrl: controller.profileImageLink,
//                       vendor_name: controller.nameController.text,
//                       password: updatedPassword,
//                     );
//
//                     VxToast.show(context, msg: "Profile and Password Updated");
//                   } else {
//                     VxToast.show(context, msg: "Old Password is incorrect");
//                   }
//                 } else {
//                   // No password change, just update the profile
//                   await controller.updateProfile(
//                     imageUrl: controller.profileImageLink,
//                     vendor_name: controller.nameController.text,
//                     password: controller.snapshotData['password'],
//                   );
//
//                   VxToast.show(context, msg: "Profile Updated");
//                 }
//               } catch (e) {
//                 VxToast.show(context, msg: "Error: ${e.toString()}");
//               } finally {
//                 controller.isloading(false);
//               }
//             },
//             child: normalText(text: save),
//           ),
//         ],
//       ),
//       body: Obx(
//         () => Column(
//           children: [
//             controller.snapshotData['imageUrl'] == '' &&
//                     controller.profileImgPath.isEmpty
//                 ? Image.asset(imgProduct,
//                         width: 100, height: 100, fit: BoxFit.cover)
//                     .box
//                     .roundedFull
//                     .clip(Clip.antiAlias)
//                     .make()
//                 : controller.snapshotData['imageUrl'] != '' &&
//                         controller.profileImgPath.isEmpty
//                     ? Image.network(
//                         controller.snapshotData['imageUrl'],
//                         width: 100,
//                         height: 100,
//                         fit: BoxFit.cover,
//                       )
//                     : Image.file(
//                         File(controller.profileImgPath.value),
//                         width: 100,
//                         height: 100,
//                         fit: BoxFit.cover,
//                       ).box.roundedFull.clip(Clip.antiAlias).make(),
//             10.heightBox,
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(backgroundColor: white),
//               onPressed: () {
//                 controller.changeImage(context);
//               },
//               child: normalText(text: changeImage, color: fontGrey),
//             ),
//             10.heightBox,
//             const Divider(color: white),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 children: [
//                   customTextField(
//                       controller: controller.nameController,
//                       label: name,
//                       hint: "Shwet",
//                       fontColor: white),
//                   10.heightBox,
//                   customTextField(
//                     controller: controller.oldPassController,
//                     label: password,
//                     hint: passwordHint,
//                     fontColor: white,
//                   ),
//                   10.heightBox,
//                   customTextField(
//                     controller: controller.newPassController,
//                     label: confirmPass,
//                     hint: passwordHint,
//                     fontColor: white,
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:a_u_seller/controller/profile_controller.dart';
import 'package:a_u_seller/views/widgets/loading_indicator.dart';
import 'package:a_u_seller/views/widgets/text_style.dart';
import 'package:get/get.dart';
import '../../const/const.dart';

class EditProfileScreen extends StatefulWidget {
  final String? username;

  const EditProfileScreen({super.key, this.username});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var controller = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    controller.nameController.text = widget.username ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: purpleColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: white,
          ),
        ),
        title: boldText(text: settings, size: 16.0),
        actions: [
          TextButton(
            onPressed: () async {
              controller.isloading(true);
              try {
                if (controller.profileImgPath.value.isNotEmpty) {
                  await controller.uploadProfileImage();
                } else {
                  controller.profileImageLink =
                  controller.snapshotData['imageUrl'];
                }

                if (controller.oldPassController.text.isNotEmpty) {
                  if (controller.snapshotData['password'] ==
                      controller.oldPassController.text) {
                    String updatedPassword =
                    controller.newPassController.text.isNotEmpty
                        ? controller.newPassController.text
                        : controller.snapshotData['password'];

                    await controller.changeAuthPassword(
                      email: controller.snapshotData['email'],
                      password: controller.oldPassController.text,
                      newPassword: updatedPassword,
                    );

                    await controller.updateProfile(
                      imageUrl: controller.profileImageLink,
                      vendor_name: controller.nameController.text,
                      password: updatedPassword,
                    );

                    VxToast.show(context, msg: "Profile and Password Updated");
                  } else {
                    VxToast.show(context, msg: "Old Password is incorrect");
                  }
                } else {
                  await controller.updateProfile(
                    imageUrl: controller.profileImageLink,
                    vendor_name: controller.nameController.text,
                    password: controller.snapshotData['password'],
                  );

                  VxToast.show(context, msg: "Profile Updated");
                }
              } catch (e) {
                VxToast.show(context, msg: "Error: ${e.toString()}");
              } finally {
                controller.isloading(false);
              }
              controller.newPassController.clear();
              controller.oldPassController.clear();
            },
            child: normalText(text: save),
          ),
        ],
      ),
      body: Obx(
            () => Column(
          children: [
            controller.snapshotData['imageUrl'] == '' &&
                controller.profileImgPath.isEmpty
                ? Image.asset(imgProduct,
                width: 100, height: 100, fit: BoxFit.cover)
                .box
                .roundedFull
                .clip(Clip.antiAlias)
                .make()
                : controller.snapshotData['imageUrl'] != '' &&
                controller.profileImgPath.isEmpty
                ? Image.network(
              controller.snapshotData['imageUrl'],
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            )
                : Image.file(
              File(controller.profileImgPath.value),
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ).box.roundedFull.clip(Clip.antiAlias).make(),
            10.heightBox,
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: white),
              onPressed: () {
                controller.changeImage(context);
              },
              child: normalText(text: changeImage, color: fontGrey),
            ),
            10.heightBox,
            const Divider(color: white),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.nameController,
                    style: const TextStyle(color: white),
                    decoration: InputDecoration(
                      labelText: name,
                      labelStyle: const TextStyle(color: white),
                      hintText: "Shwet",
                      hintStyle: const TextStyle(color: darkGrey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(color: white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(color: white),
                      ),
                    ),
                  ),
                  10.heightBox,
                  TextFormField(
                    controller: controller.oldPassController,
                    style: const TextStyle(color: white),
                    decoration: InputDecoration(
                      labelText: password,
                      labelStyle: const TextStyle(color: white),
                      hintText: passwordHint,
                      hintStyle: const TextStyle(color: darkGrey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(color: white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(color: white),
                      ),
                    ),
                  ),
                  10.heightBox,
                  TextFormField(
                    controller: controller.newPassController,
                    style: const TextStyle(color: white),
                    decoration: InputDecoration(
                      labelText: confirmPass,
                      labelStyle: const TextStyle(color: white),
                      hintText: passwordHint,
                      hintStyle: const TextStyle(color: darkGrey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(color: white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(color: white),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
