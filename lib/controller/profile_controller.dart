import 'dart:io';

import 'package:a_u_seller/const/firebase_consts.dart';
import 'package:a_u_seller/controller/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import '../const/const.dart';

class ProfileController extends GetxController {
  late QueryDocumentSnapshot snapshotData;

  var profileImgPath = ''.obs;

  // changeImage(context) async {
  //   try {
  //     final img = await ImagePicker()
  //         .pickImage(source: ImageSource.gallery, imageQuality: 70);
  //     if (img == null) return;
  //   } on PlatformException catch (e) {
  //     VxToast.show(context, msg: e.toString());
  //   }
  //}
  var profileImageLink = '';
  var isloading = false.obs;

  //text field
  var controller = Get.put(AuthController());
  var nameController = TextEditingController();
  var oldPassController = TextEditingController();
  var newPassController = TextEditingController();

  var shopNameController = TextEditingController();
  var shopAddressController = TextEditingController();
  var shopMobileController = TextEditingController();
  var shopWebsiteController = TextEditingController();
  var shopDescriptionController = TextEditingController();

  changeImage(context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 70);
      if (img != null) {
        profileImgPath.value = img.path;
      }
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadProfileImage() async {
    var filename = basename(profileImgPath.value);
    var destination = 'images/${currentUser!.uid}/$filename';
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImgPath.value));
    profileImageLink = await ref.getDownloadURL();
  }

  updateProfile({vendor_name, password, imageUrl}) async {
    var store = fireStore.collection(vendorsCollection).doc(currentUser!.uid);
    await store.set(
        {'vendor_name': vendor_name, 'password': password, 'imageUrl': imageUrl},
        SetOptions(merge: true));
    isloading(false);
  }

  changeAuthPassword({email, password, newPassword}) async {
    final cred = EmailAuthProvider.credential(email: email, password: password);
    await currentUser!.reauthenticateWithCredential(cred).then((value) {
      currentUser!.updatePassword(newPassword);
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  // updateShop({shopname, shopaddress, shopmobile, shopwebsite, shopdesc}) async {
  //   var store = fireStore.collection(vendorsCollection).doc(currentUser!.uid);
  //   await store.set(
  //     {
  //       'shop_name':shopname.text,
  //       'shop_address': shopaddress.text,
  //       'shop_mobile': shopmobile.text,
  //       'shop_website': shopwebsite.text,
  //       'shop_desc' : shopdesc.text
  //     },SetOptions(merge: true)
  //   );
  //   isloading(false);
  // }

   updateShop({
     required String shopname,
     required String shopaddress,
     required String shopmobile,
     required String shopwebsite,
     required String shopdesc,
   }) async {
     if (shopname.isEmpty || shopaddress.isEmpty || shopmobile.isEmpty || shopwebsite.isEmpty || shopdesc.isEmpty) {
       Get.snackbar('Error', 'Please fill all the fields',
           snackPosition: SnackPosition.BOTTOM,
           backgroundColor: Colors.red,
           colorText: Colors.white);
       return;  // Prevent further execution if any field is empty
     }

     // If all fields are non-empty, proceed to Firestore update
     var store = fireStore.collection(vendorsCollection).doc(currentUser!.uid);
     await store.set({
       'shop_name': shopname,
       'shop_address': shopaddress,
       'shop_mobile': shopmobile,
       'shop_website': shopwebsite,
       'shop_desc': shopdesc
     }, SetOptions(merge: true));

     isloading(false);  // Ensure this is set after the operation completes
   }



}
