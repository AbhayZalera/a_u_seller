import 'dart:convert'; // Make sure to import this for JSON decoding
import 'dart:io';
import 'package:a_u_seller/controller/home_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import '../const/const.dart';
import '../const/firebase_consts.dart';
import '../models/category_model.dart';

class ProductController extends GetxController {
  var pnameController = TextEditingController();
  var pdescController = TextEditingController();
  var ppriceController = TextEditingController();
  var pquantityController = TextEditingController();

  var categoryList = <String>[].obs;
  var subcategoryList = <String>[].obs;
  List<Category> category = [];
  var pImagesLinks = [];
  var categoryvalue = ''.obs;
  var subcategoryvalue = ''.obs;
  var selectedColorIndex = 0.obs;
  var pImagesList = List<dynamic>.generate(3, (index) => null);

  @override
  void onInit() {
    super.onInit();
    getCategories();
  }

  Future<void> getCategories() async {
    try {
      // Clear the existing category list
      categoryList.clear();

      // Load the JSON file
      var data =
          await rootBundle.loadString("lib/services/category_madel.json");

      // Parse the JSON data
      var cat = categoryModelFromJson(data);
      category = cat.categories;

      // Populate the category list
      populateCategoriesList();
    } catch (e) {
      print("Error loading categories: $e"); // Log any errors
    }
  }

  void populateCategoriesList() {
    categoryList.clear();
    for (var item in category) {
      categoryList.add(item.name);
    }
  }

  void populateSubcategories(String cat) {
    subcategoryList.clear();
    var data = category.where((element) => element.name == cat).toList();

    if (data.isNotEmpty) {
      for (var subCat in data.first.subcategory) {
        subcategoryList.add(subCat);
      }
    }
  }

  pickImage(index, context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 80);
      if (img == null) {
        return;
      } else {
        pImagesList[index] = File(img.path);
      }
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  // uploadImages() async {
  //   pImagesLinks.clear();
  //   for (var item in pImagesList) {
  //     if (item != null) {
  //       var filename = basename(item.value);
  //       var destination = 'images/vendors/${currentUser!.uid}/$filename';
  //       Reference ref = FirebaseStorage.instance.ref().child(destination);
  //       await ref.putFile(item);
  //       var n = await ref.getDownloadURL();
  //       pImagesLinks.add(n);
  //     }
  //   }
  // }
  uploadImages() async {
    pImagesLinks.clear();
    for (var item in pImagesList) {
      if (item != null) {
        var filename = basename(item.path);
        var destination = 'images/vendors${currentUser!.uid}/$filename';
        Reference ref = FirebaseStorage.instance.ref().child(destination);
        await ref.putFile(item); // <- Use item directly here
        var downloadUrl = await ref.getDownloadURL();
        pImagesLinks.add(downloadUrl);
      }
    }
  }

//   uploadProduct(context) async {
//     var store = fireStore.collection(productCollection).doc();
//     await store.set({
//       'is_featured':false,
//       'p_category': categoryvalue.value,
//       'p_subcategory':subcategoryvalue.value,
//       'p_color':FieldValue.arrayUnion([Colors.black,Colors.blueAccent,Colors.blueGrey]),
//       'p_imgs':FieldValue.arrayUnion(pImagesLinks),
//       'p_wishlist':FieldValue.arrayUnion([]),
//       'p_desc':pdescController.text,
//       'p_name':pnameController.text,
//       'p_price':ppriceController.text,
//       'p_quantity':pquantityController.text,
//       'p_seller':Get.find<HomeController>().username,
//       'p_rating': '5.0',
//       'vendor_id': currentUser!.uid,
//       'featured_id': ''
//     }
//     );
//     VxToast.show(context, msg: "Product uploaded");
//   }
  uploadProduct(context) async {
    var store = fireStore.collection(productCollection).doc();
    await store.set({
      'is_featured': false,
      'p_category': categoryvalue.value,
      'p_subcategory': subcategoryvalue.value,
      'p_imgs': FieldValue.arrayUnion(pImagesLinks),
      'p_wishlist': FieldValue.arrayUnion([]),
      'p_desc': pdescController.text,
      'p_name': pnameController.text,
      'p_price': ppriceController.text,
      'p_quantity': pquantityController.text,
      'p_seller': Get.find<HomeController>().username,
      'p_rating': '5.0',
      'vendor_id': currentUser!.uid,
      'featured_id': ''
    });

    VxToast.show(context, msg: "Product uploaded");
  }

  addFeatured(docId) async {
    await fireStore.collection(productCollection).doc(docId).set({
      'featured_id': currentUser!.uid,
      'is_featured': true,
    }, SetOptions(merge: true));
  }

  removeFeatured(docId) async {
    await fireStore.collection(productCollection).doc(docId).set({
      'featured_id': '',
      'is_featured': false,
    }, SetOptions(merge: true));
  }

  removeProduct(docId) async {
    await fireStore.collection(productCollection).doc(docId).delete();
  }
}
