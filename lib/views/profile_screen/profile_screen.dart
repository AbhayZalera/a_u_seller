import 'package:a_u_seller/const/firebase_consts.dart';
import 'package:a_u_seller/controller/profile_controller.dart';
import 'package:a_u_seller/services/store_services.dart';
import 'package:a_u_seller/views/auth_screen/login_screen.dart';
import 'package:a_u_seller/views/messages_screen/messages_screen.dart';
import 'package:a_u_seller/views/profile_screen/edit_profilescreen.dart';
import 'package:a_u_seller/views/widgets/loading_indicator.dart';
import 'package:a_u_seller/views/widgets/text_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../const/const.dart';
import '../../controller/auth_controller.dart';
import '../shop_screen/shop_settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    var profileController = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        backgroundColor: purpleColor,
        automaticallyImplyLeading: false,
        title: boldText(text: settings, size: 16.0),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => EditProfileScreen(
                      username: profileController.snapshotData['vendor_name'],
                      //pass: profileController.snapshotData['password'],
                    ));
                            },
              icon: const Icon(Icons.edit, color: white)),
          TextButton(
              onPressed: () async {
                await controller.signoutMethod(context);
                Get.offAll(() => const LoginScreen());
              },
              child: normalText(text: logout))
        ],
      ),
      body: FutureBuilder(
        future: StoreServices.getProfile(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return loadingIndicator(circleColor: white);
          } else {
            profileController.snapshotData = snapshot.data!.docs[0];
            return Column(
              children: [
                ListTile(
                  // leading: Image.asset(imgProduct)
                  //     .box
                  //     .roundedFull
                  //     .clip(Clip.antiAlias)
                  //     .make(),
                  leading:
                  profileController.snapshotData['imageUrl'] == ''
                      ? Image.asset(imgProduct,
                              width: 100, height: 100, fit: BoxFit.cover)
                          .box
                          .roundedFull
                          .clip(Clip.antiAlias)
                          .make()
                      : Image.network(
                              profileController.snapshotData['imageUrl'],
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover)
                          .box
                          .roundedFull
                          .clip(Clip.antiAlias)
                          .make(),

                  title: boldText(
                      text: profileController.snapshotData['vendor_name']),
                  subtitle:
                      normalText(text: profileController.snapshotData['email']),
                ),
                10.heightBox,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      children: List.generate(
                          profileButtonsIcons.length,
                          (index) => ListTile(
                                onTap: () {
                                  switch (index) {
                                    case 0:
                                      Get.to(() => const ShopSettings());
                                      break;
                                    case 1:
                                      Get.to(() => const MessagesScreen());
                                      break;
                                    default:
                                  }
                                },
                                leading: Icon(profileButtonsIcons[index],
                                    color: white),
                                title: normalText(
                                    text: profileButtonsTitles[index]),
                              ))),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
