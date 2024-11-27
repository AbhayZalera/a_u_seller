import 'package:a_u_seller/controller/profile_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../const/colors.dart';
import '../../const/const.dart';
import '../../const/strings.dart';
import '../widgets/text_style.dart';

class ShopSettings extends StatelessWidget {
  const ShopSettings({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
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
            )),
        title: boldText(text: shopSettings, size: 16.0),
        actions: [
          controller.isloading.value
              ? const CircularProgressIndicator(color: white)
              : TextButton(
            onPressed: () async {
              controller.isloading(true);
              await controller.updateShop(
                shopname: controller.shopNameController.text.trim(),
                shopaddress: controller.shopAddressController.text.trim(),
                shopmobile: controller.shopMobileController.text.trim(),
                shopwebsite: controller.shopWebsiteController.text.trim(),
                shopdesc: controller.shopDescriptionController.text.trim(),
              );
              VxToast.show(context, msg: "Shop updated");
            },
            child: normalText(text: save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            shopTextField(
              controller: controller.shopNameController,
              label: shopname,
              hint: nameHint,
              fontColor: white,
            ),
            const SizedBox(height: 10),
            shopTextField(
              controller: controller.shopAddressController,
              label: address,
              hint: shopAddressHint,
              fontColor: white,
            ),
            const SizedBox(height: 10),
            shopTextField(
              controller: controller.shopMobileController,
              label: mobile,
              hint: shopMobileHint,
              fontColor: white,
            ),
            const SizedBox(height: 10),
            shopTextField(
              controller: controller.shopWebsiteController,
              label: website,
              hint: shopwebsiteHint,
              fontColor: white,
            ),
            const SizedBox(height: 10),
            shopTextField(
              controller: controller.shopDescriptionController,
              label: description,
              hint: shopDeschint,
              fontColor: white,
              isDesc: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget shopTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    bool isDesc = false,
    Color fontColor = Colors.black,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: isDesc ? 4 : 1,
      style: TextStyle(color: fontColor),
      decoration: InputDecoration(
        isDense: true,
        labelText: label,
        labelStyle: TextStyle(color: fontColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: white),
        ),
        hintText: hint,
        hintStyle: const TextStyle(color: darkGrey),
      ),
    );
  }
}
